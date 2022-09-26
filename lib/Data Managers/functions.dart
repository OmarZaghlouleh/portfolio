import 'package:flutter/cupertino.dart';
import 'package:portfolio/Data%20Managers/values_manager.dart';

Vector2 getWidgetLocation(GlobalKey widgetKey, double currentOffset) {
  final RenderBox renderBox =
      widgetKey.currentContext?.findRenderObject() as RenderBox;

  final Size size = renderBox.size; // or _widgetKey.currentContext?.size

  final Offset offset = renderBox.localToGlobal(Offset(0, currentOffset));

  return Vector2((offset.dx + size.width) / 2, offset.dy - AppHeights.h100);
}
