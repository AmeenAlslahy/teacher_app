import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' show Size;
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/material.dart' show Colors, TextStyle, Container, EdgeInsets, UnconstrainedBox;
import 'package:flutter_math_fork/flutter_math.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../entities/exam.dart';
import '../entities/exam_pdf_metadata.dart';
import '../../../../core/utils/offscreen_renderer.dart';

class ExamPdfService {
  
  /// Pre-processes math/physics/chemistry blocks into high-res images
  /// so that the pdf package can render them accurately.
  static Future<Map<String, Uint8List>> _prepareBlockImages(List<Question> questions) async {
    final images = <String, Uint8List>{};
    for (var q in questions) {
      for (var block in q.blocks) {
        if (block.type == BlockType.math || 
            block.type == BlockType.physics || 
            block.type == BlockType.chemistry) {
          try {
            final mathWidget = Math.tex(
              block.content,
              textStyle: const TextStyle(fontSize: 22, color: Colors.black),
            );
            
            // Container with white background ensures clean rendering
            final widgetToRender = UnconstrainedBox(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                color: Colors.white,
                child: mathWidget,
              ),
            );
            
            final imageBytes = await OffscreenRenderer.renderWidgetToImage(
              widget: widgetToRender,
              logicalSize: const Size(800, 200),
              pixelRatio: 3.0, // High res for print
            );
            images[block.id] = imageBytes;
          } catch (e) {
            debugPrint('Error rendering block ${block.id}: $e');
          }
        }
      }
    }
    return images;
  }

  /// توليد مستند PDF الخاص بالاختبار
  static Future<pw.Document> generateExamPdf(
      Exam exam, List<Question> questions, ExamPdfMetadata metadata) async {
        
    // 1. Pre-render complex blocks (Canonical Content -> Image representation for PDF)
    final blockImages = await _prepareBlockImages(questions);
    
    final pdf = pw.Document();

    final arabicFont = await PdfGoogleFonts.cairoRegular();
    final arabicFontBold = await PdfGoogleFonts.cairoBold();

    final theme = pw.ThemeData.withFont(
      base: arabicFont,
      bold: arabicFontBold,
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        theme: theme,
        textDirection: pw.TextDirection.rtl,
        margin: const pw.EdgeInsets.all(40),
        header: (context) => _buildHeader(exam, metadata, arabicFont, arabicFontBold),
        footer: (context) => _buildFooter(context, arabicFont),
        build: (context) {
          final mainQuestions = questions
              .where((q) => q.type == QuestionType.groupHeader)
              .toList();
          final subQuestions = questions
              .where((q) =>
                  q.type != QuestionType.groupHeader && q.parentId != null)
              .toList();
          final standaloneQuestions = questions
              .where((q) =>
                  q.type != QuestionType.groupHeader && q.parentId == null)
              .toList();

          final widgets = <pw.Widget>[pw.SizedBox(height: 20)];

          if (standaloneQuestions.isNotEmpty) {
            widgets.addAll(standaloneQuestions.asMap().entries.map((entry) {
              return _buildQuestion(
                  entry.key + 1, entry.value, arabicFont, arabicFontBold, blockImages);
            }));
          }

          for (var mainQ in mainQuestions) {
            widgets.add(pw.Container(
              margin: const pw.EdgeInsets.only(top: 15, bottom: 15),
              child: pw.Text(
                mainQ.content,
                style: pw.TextStyle(font: arabicFontBold, fontSize: 16),
              ),
            ));

            final items =
                subQuestions.where((q) => q.parentId == mainQ.id).toList();
            widgets.addAll(items.asMap().entries.map((entry) {
              return pw.Padding(
                padding: const pw.EdgeInsets.only(right: 15),
                child: _buildQuestion(
                    entry.key + 1, entry.value, arabicFont, arabicFontBold, blockImages),
              );
            }));
          }

          return widgets;
        },
      ),
    );

    return pdf;
  }

  /// طباعة الاختبار مباشرة
  static Future<void> printExam(Exam exam, List<Question> questions, ExamPdfMetadata metadata) async {
    final pdf = await generateExamPdf(exam, questions, metadata);
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'اختبار_${exam.title}',
    );
  }

  /// حفظ ومشاركة الـ PDF
  static Future<void> shareExamPdf(Exam exam, List<Question> questions, ExamPdfMetadata metadata) async {
    final pdf = await generateExamPdf(exam, questions, metadata);
    final bytes = await pdf.save();

    final dir = await getTemporaryDirectory();
    final file =
        File('${dir.path}/اختبار_${exam.title.replaceAll(' ', '_')}.pdf');
    await file.writeAsBytes(bytes);

    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'اختبار: ${exam.title}',
    );
  }

  static pw.Widget _buildHeader(
    Exam exam,
    ExamPdfMetadata metadata,
    pw.Font font,
    pw.Font fontBold,
  ) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 12),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          // ═══════════════ القسم 1: الدولة + الشعار + المدرسة ═══════════════
          pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: 1.5),
            ),
            padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // اليمين: الدولة + الوزارة + إدارة التربية
                pw.Expanded(
                  flex: 3,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        metadata.country,
                        style: pw.TextStyle(font: fontBold, fontSize: 12),
                      ),
                      pw.SizedBox(height: 3),
                      pw.Text(
                        metadata.ministry,
                        style: pw.TextStyle(font: font, fontSize: 11),
                      ),
                      if (metadata.educationAuthority != null &&
                          metadata.educationAuthority!.isNotEmpty) ...[
                        pw.SizedBox(height: 3),
                        pw.Text(
                          metadata.educationAuthority!,
                          style: pw.TextStyle(font: font, fontSize: 10),
                        ),
                      ],
                    ],
                  ),
                ),

                // الوسط: الشعار
                pw.Expanded(
                  flex: 2,
                  child: metadata.schoolLogoPath != null &&
                          metadata.schoolLogoPath!.isNotEmpty
                      ? pw.Center(
                          child: pw.Image(
                            pw.MemoryImage(
                              File(metadata.schoolLogoPath!).readAsBytesSync(),
                            ),
                            height: 55,
                            fit: pw.BoxFit.contain,
                          ),
                        )
                      : pw.SizedBox(height: 55),
                ),

                // اليسار: المدرسة + العام
                pw.Expanded(
                  flex: 3,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        'المدرسة: ${metadata.schoolName}',
                        style: pw.TextStyle(font: fontBold, fontSize: 11),
                        textAlign: pw.TextAlign.left,
                      ),
                      pw.SizedBox(height: 3),
                      pw.Text(
                        'العام الدراسي: ${metadata.academicYear}',
                        style: pw.TextStyle(font: font, fontSize: 10),
                        textAlign: pw.TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ═══════════════ القسم 2: البسملة ═══════════════
          if (metadata.showBasmala)
            pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border(
                  left: pw.BorderSide(width: 1.5),
                  right: pw.BorderSide(width: 1.5),
                  bottom: pw.BorderSide(width: 1.5),
                ),
              ),
              padding: const pw.EdgeInsets.symmetric(vertical: 6),
              child: pw.Center(
                child: pw.Text(
                  'بسم الله الرحمن الرحيم',
                  style: pw.TextStyle(font: fontBold, fontSize: 13),
                ),
              ),
            ),

          // ═══════════════ القسم 3: بيانات الاختبار ═══════════════
          pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(width: 1.5),
                right: pw.BorderSide(width: 1.5),
                bottom: pw.BorderSide(width: 1.5),
              ),
            ),
            padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                // الصف 1
                pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Text(
                        'الاختبار: ${metadata.examTypeName}',
                        style: pw.TextStyle(font: fontBold, fontSize: 11),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        'الصف: ${metadata.className}'
                        '${metadata.sectionName != null && metadata.sectionName!.isNotEmpty ? ' - ${metadata.sectionName}' : ''}',
                        style: pw.TextStyle(font: fontBold, fontSize: 11),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 6),

                // الصف 2
                pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Text(
                        'المادة: ${metadata.subjectName}',
                        style: pw.TextStyle(font: fontBold, fontSize: 11),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        'التاريخ: ${_formatExamDate(exam.examDate)}',
                        style: pw.TextStyle(font: fontBold, fontSize: 11),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 6),

                // الصف 3
                pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Text(
                        'الزمن: ${exam.duration} دقيقة',
                        style: pw.TextStyle(font: fontBold, fontSize: 11),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        'الدرجة الكلية: ${exam.totalMarks}',
                        style: pw.TextStyle(font: fontBold, fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ═══════════════ القسم 4: بيانات الطالب ═══════════════
          pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(width: 1.5),
                right: pw.BorderSide(width: 1.5),
                bottom: pw.BorderSide(width: 1.5),
              ),
            ),
            padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                pw.Text(
                  'اسم الطالب: ..................................................................................',
                  style: pw.TextStyle(font: font, fontSize: 11),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  'رقم الجلوس: ....................................................',
                  style: pw.TextStyle(font: font, fontSize: 11),
                ),
              ],
            ),
          ),

          pw.SizedBox(height: 10),

          // ═══════════════ عنوان الاختبار ═══════════════
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(vertical: 6),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: 1.5),
            ),
            child: pw.Center(
              child: pw.Text(
                exam.title.isNotEmpty ? exam.title : 'اختبار',
                style: pw.TextStyle(font: fontBold, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// تنسيق التاريخ بصيغة dd/MM/yyyy
  static String _formatExamDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  static pw.Widget _buildFooter(pw.Context context, pw.Font font) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(top: 20),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'الصفحة ${context.pageNumber} من ${context.pagesCount}',
            style: pw.TextStyle(font: font, fontSize: 12),
          ),
          pw.Text(
            'انتهت الأسئلة ،،، بالتوفيق',
            style: pw.TextStyle(font: font, fontSize: 12),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildQuestion(
      int number, Question question, pw.Font font, pw.Font fontBold, Map<String, Uint8List> blockImages) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 20),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('$number - ',
                  style: pw.TextStyle(font: fontBold, fontSize: 14)),
              pw.Expanded(
                child: pw.Text(question.content,
                    style: pw.TextStyle(font: font, fontSize: 14)),
              ),
              pw.Text('(${question.marks} درجات)',
                  style: pw.TextStyle(
                      font: font, fontSize: 10, color: PdfColors.grey700)),
            ],
          ),

          if (question.blocks.isNotEmpty)
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 12, bottom: 8, right: 20),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: question.blocks.map((block) {
                  // Text blocks remain native for perfect quality & selection
                  if (block.type == BlockType.text) {
                    return pw.Padding(
                      padding: const pw.EdgeInsets.only(bottom: 8),
                      child: pw.Text(
                        block.content,
                        style: pw.TextStyle(font: font, fontSize: 14),
                      ),
                    );
                  } 
                  // Math/Science blocks are injected as pre-rendered images
                  else if ((block.type == BlockType.math || 
                            block.type == BlockType.physics || 
                            block.type == BlockType.chemistry) && 
                           blockImages.containsKey(block.id)) {
                    return pw.Padding(
                      padding: const pw.EdgeInsets.only(bottom: 12),
                      child: pw.Image(
                        pw.MemoryImage(blockImages[block.id]!),
                        fit: pw.BoxFit.contain,
                      ),
                    );
                  }
                  // Fallback
                  return pw.SizedBox();
                }).toList(),
              ),
            ),

          pw.SizedBox(height: 10),

          if (question.type == QuestionType.multipleChoice ||
              question.type == QuestionType.multipleAnswers)
            _buildOptions(question.options, font)
          else if (question.type == QuestionType.trueFalse)
            pw.Padding(
              padding: const pw.EdgeInsets.only(right: 20),
              child: pw.Text('(     ) صح            (     ) خطأ',
                  style: pw.TextStyle(font: font, fontSize: 14)),
            )
          else
            pw.Container(
              margin: const pw.EdgeInsets.only(top: 10, right: 20),
              height: 100,
              decoration: const pw.BoxDecoration(
                  border: pw.Border(
                bottom: pw.BorderSide(
                    color: PdfColors.grey300, style: pw.BorderStyle.dashed),
              )),
            ),
        ],
      ),
    );
  }

  static pw.Widget _buildOptions(List<QuestionOption> options, pw.Font font) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(right: 20),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: options.map((option) {
          return pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 8),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  width: 12,
                  height: 12,
                  margin: const pw.EdgeInsets.only(top: 2, left: 8),
                  decoration: pw.BoxDecoration(
                    shape: pw.BoxShape.circle,
                    border: pw.Border.all(color: PdfColors.black, width: 1),
                  ),
                ),
                pw.Expanded(
                  child: pw.Text(option.content,
                      style: pw.TextStyle(font: font, fontSize: 14)),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
