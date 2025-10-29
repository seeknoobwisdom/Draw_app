import 'package:flutter/material.dart';
import 'stroke.dart';

/// Controller for managing drawing state and implementing palm rejection
class DrawingController extends ChangeNotifier {
  List<Stroke> _strokes = [];
  List<Stroke> _redoStack = [];
  Stroke? _currentStroke;
  
  // One-touch lock system for palm rejection
  int? _activePointerId;
  int? _ignoredPointerId;
  bool _isDrawing = false;
  
  // Palm-first mode: ignore first touch, use second touch for drawing
  bool _palmFirstMode = false;
  
  // Current drawing settings
  Color _currentColor = Colors.black;
  double _currentStrokeWidth = 3.0;
  DrawingTool _currentTool = DrawingTool.pen;
  
  // Getters
  List<Stroke> get strokes => _strokes;
  Color get currentColor => _currentColor;
  double get currentStrokeWidth => _currentStrokeWidth;
  DrawingTool get currentTool => _currentTool;
  bool get canUndo => _strokes.isNotEmpty;
  bool get canRedo => _redoStack.isNotEmpty;
  bool get palmFirstMode => _palmFirstMode;
  
  /// Handle pointer down event - implements one-touch lock
  void onPointerDown(PointerDownEvent event) {
    if (_palmFirstMode) {
      // Palm-first mode: ignore first touch, use second touch
      if (_ignoredPointerId == null) {
        // This is the first touch - ignore it (assume it's the palm)
        _ignoredPointerId = event.pointer;
      } else if (_activePointerId == null) {
        // This is the second touch - use it for drawing
        _activePointerId = event.pointer;
        _isDrawing = true;
        
        // Start a new stroke
        _currentStroke = Stroke(
          points: [event.localPosition],
          color: _currentColor,
          strokeWidth: _currentTool == DrawingTool.highlighter 
              ? _currentStrokeWidth * 3 
              : _currentStrokeWidth,
          tool: _currentTool,
        );
        
        notifyListeners();
      }
      // Ignore any additional touches
    } else {
      // Standard mode: use first touch only
      if (_activePointerId == null) {
        _activePointerId = event.pointer;
        _isDrawing = true;
        
        // Start a new stroke
        _currentStroke = Stroke(
          points: [event.localPosition],
          color: _currentColor,
          strokeWidth: _currentTool == DrawingTool.highlighter 
              ? _currentStrokeWidth * 3 
              : _currentStrokeWidth,
          tool: _currentTool,
        );
        
        notifyListeners();
      }
      // Otherwise, ignore this touch (palm rejection)
    }
  }
  
  /// Handle pointer move event - only responds to locked pointer
  void onPointerMove(PointerMoveEvent event) {
    // Only draw if this is the active pointer
    if (_isDrawing && event.pointer == _activePointerId && _currentStroke != null) {
      _currentStroke = _currentStroke!.copyWith(
        points: [..._currentStroke!.points, event.localPosition],
      );
      notifyListeners();
    }
  }
  
  /// Handle pointer up event - releases the lock
  void onPointerUp(PointerUpEvent event) {
    // Check if this is the ignored pointer (palm-first mode)
    if (_palmFirstMode && event.pointer == _ignoredPointerId) {
      _ignoredPointerId = null;
      notifyListeners();
      return;
    }
    
    // Only respond if this is the active pointer
    if (event.pointer == _activePointerId) {
      _isDrawing = false;
      _activePointerId = null;
      
      // Save the completed stroke
      if (_currentStroke != null && _currentStroke!.points.length > 1) {
        _strokes.add(_currentStroke!);
        _redoStack.clear(); // Clear redo stack on new stroke
        _currentStroke = null;
      }
      
      notifyListeners();
    }
  }
  
  /// Handle pointer cancel event
  void onPointerCancel(PointerCancelEvent event) {
    if (event.pointer == _activePointerId) {
      _isDrawing = false;
      _activePointerId = null;
      _currentStroke = null;
      notifyListeners();
    } else if (_palmFirstMode && event.pointer == _ignoredPointerId) {
      _ignoredPointerId = null;
      notifyListeners();
    }
  }
  
  /// Get the current stroke being drawn (for real-time rendering)
  Stroke? get currentStroke => _currentStroke;
  
  /// Set the drawing color
  void setColor(Color color) {
    _currentColor = color;
    notifyListeners();
  }
  
  /// Set the stroke width
  void setStrokeWidth(double width) {
    _currentStrokeWidth = width;
    notifyListeners();
  }
  
  /// Set the drawing tool
  void setTool(DrawingTool tool) {
    _currentTool = tool;
    notifyListeners();
  }
  
  /// Toggle palm-first mode
  void setPalmFirstMode(bool enabled) {
    _palmFirstMode = enabled;
    // Reset pointers when switching modes
    _activePointerId = null;
    _ignoredPointerId = null;
    _isDrawing = false;
    _currentStroke = null;
    notifyListeners();
  }
  
  /// Undo the last stroke
  void undo() {
    if (_strokes.isNotEmpty) {
      _redoStack.add(_strokes.removeLast());
      notifyListeners();
    }
  }
  
  /// Redo the last undone stroke
  void redo() {
    if (_redoStack.isNotEmpty) {
      _strokes.add(_redoStack.removeLast());
      notifyListeners();
    }
  }
  
  /// Clear all strokes
  void clear() {
    _strokes.clear();
    _redoStack.clear();
    _currentStroke = null;
    notifyListeners();
  }
}
