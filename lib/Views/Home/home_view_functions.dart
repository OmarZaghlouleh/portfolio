// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/cupertino.dart';
import 'package:portfolio/Data%20Managers/fonts_manager.dart';
import 'package:portfolio/View%20Models/home_view_model.dart';

import '../../Data Managers/functions.dart';
import '../../Data Managers/values_manager.dart';

class HomeViewFunctions {
  void pressAboutFunction(
      ScrollController scrollController, HomeViewModel value) async {
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: AppDurations.dm300),
        curve: Curves.linear);
    value.setAboutCustomFontSize(FontsSize.s20);
    await value.upload();
  }

  void hoverAboutFunction(HomeViewModel value) {
    value.setAboutFontSize();
  }

  void selectProjectFunction(ScrollController scrollController,
      HomeViewModel value, String selected) async {
    if (value.getProjectsName.contains(selected)) {
      scrollController.animateTo(
          getWidgetLocation(
                  value.getProjects
                      .firstWhere((element) => element.name == selected)
                      .key,
                  scrollController.offset)
              .y,
          duration: const Duration(milliseconds: AppDurations.dm100),
          curve: Curves.linear);
    }
  }

  void pressMusicFunction(ScrollController scrollController,
      HomeViewModel value, GlobalKey key) async {
    scrollController.animateTo(
        getWidgetLocation(key, scrollController.offset).y,
        duration: const Duration(milliseconds: AppDurations.dm100),
        curve: Curves.linear);
    value.setCustomMusicFontSize(FontsSize.s20);
  }

  Future<void> pressLikeButton(HomeViewModel value, bool increase) async {
    if (increase)
      await value.setLike();
    else
      await value.decLike();
  }

  void hoverResumeFunction(HomeViewModel value) {
    value.setResumeFontSize();
  }

  void hoverMusicFunction(HomeViewModel value) {
    value.setMusicFontSize();
  }

  void hoverLikeButton(HomeViewModel value) {
    value.setLikeSize();
  }

  void hoverContactFunction(HomeViewModel value) {
    value.setContactFontSize();
  }

  void pressContactFunction(
      ScrollController scrollController, HomeViewModel value) {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: AppDurations.dm300),
        curve: Curves.linear);
    value.setCustomContactFontSize(FontsSize.s20);
  }
}
