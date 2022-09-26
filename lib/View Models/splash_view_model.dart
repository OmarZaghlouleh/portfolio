import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:portfolio/Data%20Managers/values_manager.dart';

class SplashViewModel with ChangeNotifier {
  bool _loading = false;
  bool _animation = false;
  Vector2 _animationPosition = Vector2(0, 0);

  void setAnimationPosition(Vector2 position) {
    _animationPosition = position;
    log("New Position: ${_animationPosition.x} ${_animationPosition.y}");
    notifyListeners();
  }

  void setAnimation(bool value) {
    log(value.toString());
    _animation = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool get getLoading => _loading;
  bool get getAnimation => _animation;
  Vector2 get getAnimationPosition => _animationPosition;
}
