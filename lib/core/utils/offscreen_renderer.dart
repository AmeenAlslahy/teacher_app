import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

/// A utility class that converts a Flutter Widget into a Uint8List (PNG image)
/// without requiring the widget to be mounted in the active Widget Tree.
/// This is crucial for rendering complex widgets (like LaTeX equations) in the
/// background for PDF generation.
class OffscreenRenderer {
  /// Converts a [Widget] to a [Uint8List] PNG image.
  /// 
  /// [logicalSize] defines the bounding box for the widget. If the widget is smaller,
  /// it will be centered.
  /// [pixelRatio] defines the resolution/sharpness of the output image. A higher
  /// value means sharper images for PDF printing (e.g., 3.0 or 4.0).
  static Future<Uint8List> renderWidgetToImage({
    required Widget widget,
    Size logicalSize = const Size(800, 200), // Default wide bounding box
    double pixelRatio = 3.0,
  }) async {
    final RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();
    
    // In Flutter 3.0+, we use PlatformDispatcher for views
    final ui.FlutterView view = ui.PlatformDispatcher.instance.views.first;

    final RenderView renderView = RenderView(
      view: view,
      child: RenderPositionedBox(alignment: Alignment.center, child: repaintBoundary),
      configuration: ViewConfiguration(
        logicalConstraints: BoxConstraints.tight(logicalSize),
        physicalConstraints: BoxConstraints.tight(Size(logicalSize.width * pixelRatio, logicalSize.height * pixelRatio)),
        devicePixelRatio: pixelRatio,
      ),
    );

    final PipelineOwner pipelineOwner = PipelineOwner();
    final BuildOwner buildOwner = BuildOwner(focusManager: FocusManager());

    pipelineOwner.rootNode = renderView;
    renderView.prepareInitialFrame();

    final RenderObjectToWidgetElement<RenderBox> rootElement = RenderObjectToWidgetAdapter<RenderBox>(
      container: repaintBoundary,
      child: Directionality(
        textDirection: TextDirection.rtl, // Default to RTL for Arabic context
        child: Material(
          color: Colors.transparent,
          child: widget,
        ),
      ),
    ).attachToRenderTree(buildOwner);

    buildOwner.buildScope(rootElement);
    buildOwner.finalizeTree();

    pipelineOwner.flushLayout();
    pipelineOwner.flushCompositingBits();
    pipelineOwner.flushPaint();

    final ui.Image image = await repaintBoundary.toImage(pixelRatio: pixelRatio);
    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    
    if (byteData == null) {
      throw Exception('Failed to convert widget to image byte data');
    }
    
    return byteData.buffer.asUint8List();
  }
}
