import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import '../../domain/entities/question_content.dart';

class RichTextController extends TextEditingController {
  final Map<String, ContentBlock> inlineBlocks;

  RichTextController({super.text, required this.inlineBlocks});

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final text = this.text;
    if (inlineBlocks.isEmpty || !text.contains('[[')) {
      return TextSpan(style: style, text: text);
    }

    final spans = <InlineSpan>[];
    final regex = RegExp(r'\[\[(.*?)\]\]');
    int lastIndex = 0;

    for (final match in regex.allMatches(text)) {
      if (match.start > lastIndex) {
        spans.add(TextSpan(text: text.substring(lastIndex, match.start), style: style));
      }

      final blockId = match.group(1)!;
      final block = inlineBlocks[blockId];

      if (block != null) {
        spans.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
              ),
              child: Math.tex(
                block.content,
                textStyle: style?.copyWith(color: Colors.blue.shade900),
              ),
            ),
          ),
        );
      } else {
        // إذا كان المعرف غير موجود في الخريطة، نعرضه كنص عادي
        spans.add(TextSpan(text: match.group(0), style: style));
      }

      lastIndex = match.end;
    }

    if (lastIndex < text.length) {
      spans.add(TextSpan(text: text.substring(lastIndex), style: style));
    }

    return TextSpan(style: style, children: spans);
  }
}
