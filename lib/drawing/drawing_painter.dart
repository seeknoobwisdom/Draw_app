import 'package:flutter/material.dart';
import 'stroke.dart';

/// Custom painter to render drawing strokes on canvas
class DrawingPainter extends CustomPainter {
  final List<Stroke> strokes;
  final Stroke? currentStroke;

  DrawingPainter({
    required this.strokes,
    this.currentStroke,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Create a layer for proper eraser blending
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());
    
    // Draw all completed strokes
    for (final stroke in strokes) {
      _drawStroke(canvas, stroke);
    }

    // Draw current stroke being drawn
    if (currentStroke != null && currentStroke!.points.isNotEmpty) {
      _drawStroke(canvas, currentStroke!);
    }
    
    // Restore the layer
    canvas.restore();
  }

  void _drawStroke(Canvas canvas, Stroke stroke) {
    if (stroke.points.isEmpty) return;

    final paint = Paint()
      ..color = stroke.color
      ..strokeWidth = stroke.strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    // Apply special effects based on tool type
    if (stroke.tool == DrawingTool.highlighter) {
      paint.color = stroke.color.withOpacity(0.3);
      paint.strokeCap = StrokeCap.square;
    } else if (stroke.tool == DrawingTool.eraser) {
      paint.blendMode = BlendMode.clear;
      paint.strokeCap = StrokeCap.round;
    }

    // Draw smooth path through all points
    if (stroke.points.length == 1) {
      // Draw a dot for single point
      canvas.drawCircle(
        stroke.points[0],
        stroke.strokeWidth / 2,
        paint..style = PaintingStyle.fill,
      );
    } else {
      // Draw smooth lines connecting points
      final path = Path();
      path.moveTo(stroke.points[0].dx, stroke.points[0].dy);

      for (int i = 1; i < stroke.points.length; i++) {
        final p1 = stroke.points[i - 1];
        final p2 = stroke.points[i];
        
        // Use quadratic bezier for smoother lines
        if (i < stroke.points.length - 1) {
          final midPoint = Offset(
            (p1.dx + p2.dx) / 2,
            (p1.dy + p2.dy) / 2,
          );
          path.quadraticBezierTo(p1.dx, p1.dy, midPoint.dx, midPoint.dy);
        } else {
          path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
        }
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) {
    return oldDelegate.strokes != strokes || 
           oldDelegate.currentStroke != currentStroke;
  }
}
