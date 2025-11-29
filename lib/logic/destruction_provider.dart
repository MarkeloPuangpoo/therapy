import 'package:flutter/material.dart';

enum AppState { input, destroying, aftermath }

enum DestructionMode { fire, shred, crumple, dissolve }

class DestructionProvider extends ChangeNotifier {
  AppState _state = AppState.input;
  String _text = '';
  DestructionMode _mode = DestructionMode.fire;

  AppState get state => _state;
  String get text => _text;
  DestructionMode get mode => _mode;

  void setText(String value) {
    _text = value;
    notifyListeners();
  }

  void setMode(DestructionMode mode) {
    _mode = mode;
    notifyListeners();
  }

  void startDestruction() {
    if (_text.trim().isEmpty) return;
    _state = AppState.destroying;
    notifyListeners();
  }

  void completeDestruction() {
    // Crucial: Clear the text immediately
    _text = '';
    _state = AppState.aftermath;
    notifyListeners();
  }

  void reset() {
    _state = AppState.input;
    notifyListeners();
  }
}
