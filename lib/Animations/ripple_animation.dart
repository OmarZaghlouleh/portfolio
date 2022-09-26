import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/Data%20Managers/values_manager.dart';

class RippleAnimation {
  late AnimationController _animationController;
  late Animation<double> _animation;

  RippleAnimation(dynamic vsync) {
    _animationController = AnimationController(
        vsync: vsync,
        duration: const Duration(milliseconds: AppDurations.dm350));

    _animation = Tween<double>(begin: TweenValues.t0, end: TweenValues.t1_5)
        .animate(_animationController);
  }

  void startAnimaton() {
    _animationController.repeat();
  }

  void stopAnimation() {
    _animationController.stop();
  }

  void dispose() {
    _animationController.dispose();
  }

  Animation<double> get getAnimation => _animation;
}
