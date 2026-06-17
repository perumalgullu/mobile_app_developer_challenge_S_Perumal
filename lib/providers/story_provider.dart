import 'package:flutter/material.dart';

enum StoryState {
  idle,
  loading,
  speaking,
  quiz,
  success,
  wrong,
  error,
}

class StoryProvider extends ChangeNotifier {
  StoryState _state = StoryState.idle;

  String? errorMessage;

  StoryState get state => _state;

  void setLoading() {
    _state = StoryState.loading;
    notifyListeners();
  }

  void setSpeaking() {
    _state = StoryState.speaking;
    notifyListeners();
  }

  void showQuiz() {
    _state = StoryState.quiz;
    notifyListeners();
  }
  
  void showWrong() {
  _state = StoryState.wrong;
  notifyListeners();
}

  void showSuccess() {
    _state = StoryState.success;
    notifyListeners();
  }
  

  void showError(String message) {
    errorMessage = message;
    _state = StoryState.error;
    notifyListeners();
  }

  void reset() {
    _state = StoryState.idle;
    errorMessage = null;
    notifyListeners();
  }
}