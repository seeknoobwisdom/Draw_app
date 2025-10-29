import 'package:flutter/material.dart';

/// Represents the type of drawing tool
enum DrawingTool {
  pen,
  eraser,
  highlighter,
}

/// Represents a single stroke on the canvas
class Stroke {
  final List<Offset> points;
  final Color color;
  final double strokeWidth;
  final DrawingTool tool;

  Stroke({
    required this.points,
    required this.color,
    required this.strokeWidth,
    required this.tool,
  });

  /// Creates a copy of this stroke with updated values
  Stroke copyWith({
    List<Offset>? points,
    Color? color,
    double? strokeWidth,
    DrawingTool? tool,
  }) {
    return Stroke(
      points: points ?? this.points,
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      tool: tool ?? this.tool,
    );
  }
}
