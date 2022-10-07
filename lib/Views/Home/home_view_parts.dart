// ignore_for_file: curly_braces_in_flow_control_structures

// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:portfolio/Views/Home/home_view_functions.dart';
import 'package:provider/provider.dart';
import '../../Data Managers/colors_manager.dart';
import '../../Data Managers/strings_manager.dart';
import '../../Data Managers/values_manager.dart';
import '../../View Models/home_view_model.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer(
      {required this.homeViewFunctions,
      required this.popupKey,
      required this.scrollController,
      required this.musicKey,
      super.key});
  GlobalKey popupKey;
  GlobalKey musicKey;

  ScrollController scrollController;
  HomeViewFunctions homeViewFunctions;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) => Container(
        width: p1.maxWidth * 0.5,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(AppSize.s15),
            bottomRight: Radius.circular(AppSize.s15),
          ),
          color: ColorsManager.primaryColor.withOpacity(OpacityValues.op0_7),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<HomeViewModel>(
              builder: (context, value, child) => AppbarAction(
                  fontSize: value.getAboutFontSize,
                  onPressed: () => homeViewFunctions.pressAboutFunction(
                      scrollController, value),
                  onHover: () => () {},
                  //homeViewFunctions.hoverAboutFunction(value),
                  title: AppStrings.about),
            ),
            Consumer<HomeViewModel>(
                builder: (context, value, child) => InkWell(
                    onTap: () {},
                    onHover: (isHovered) {
                      //value.setProjectsFontSize();
                    },
                    child: ExpansionTile(
                      collapsedIconColor: ColorsManager.greyColor,
                      iconColor: ColorsManager.whiteColor,
                      tilePadding: const EdgeInsets.all(AppPadding.p8),
                      title: AnimatedSize(
                        duration:
                            const Duration(milliseconds: AppDurations.dm300),
                        curve: Curves.linear,
                        child: Padding(
                          padding: const EdgeInsets.all(AppPadding.p6),
                          child: Text(
                            AppStrings.projects,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(fontSize: value.getProjectsFontSize),
                          ),
                        ),
                      ),
                      children: value.getProjects
                          .map(
                            (e) => TextButton(
                              onPressed: () {
                                homeViewFunctions.selectProjectFunction(
                                    scrollController, value, e.name);
                              },
                              child: Text(
                                e.name,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          )
                          .toList(),
                    ))),
            Consumer<HomeViewModel>(
              builder: (context, value, child) => AppbarAction(
                  fontSize: value.getMusicFontSize,
                  onPressed: () => homeViewFunctions.pressMusicFunction(
                      scrollController, value, musicKey),
                  onHover: () => () {},
                  //homeViewFunctions.hoverMusicFunction(value),
                  title: AppStrings.music),
            ),
            Consumer<HomeViewModel>(
              builder: (context, value, child) => AppbarAction(
                  fontSize: value.getContactFontSize,
                  onPressed: () => homeViewFunctions.pressContactFunction(
                      scrollController, value),
                  onHover: () => () {},
                  //homeViewFunctions.hoverContactFunction(value),
                  title: AppStrings.contact),
            ),
            Consumer<HomeViewModel>(
              builder: (context, value, child) => Center(
                child: InkWell(
                  onTap: () async {
                    if (!value.getIsLiked)
                      await homeViewFunctions.pressLikeButton(value, true);
                    else
                      await homeViewFunctions.pressLikeButton(value, false);
                  },
                  onHover: (_) {
                    homeViewFunctions.hoverLikeButton(value);
                  },
                  child: Container(
                    width: AppWidth.w55,
                    decoration: BoxDecoration(
                      color: ColorsManager.blackColor
                          .withOpacity(OpacityValues.op0_3),
                      borderRadius: BorderRadius.circular(AppSize.s15),
                    ),
                    padding: const EdgeInsets.all(AppPadding.p8),
                    margin: const EdgeInsets.all(AppPadding.p8),
                    child: Row(
                      children: [
                        Text(
                          value.getLikesNumber.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: ColorsManager.whiteColor),
                        ),
                        const SizedBox(width: AppWidth.w5),
                        Icon(
                          value.getIsLiked
                              ? Icons.thumb_up_alt_rounded
                              : Icons.thumb_up_off_alt_outlined,
                          color: ColorsManager.whiteColor,
                          size: value.getLikeSize,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppbarAction extends StatelessWidget {
  AppbarAction(
      {required this.fontSize,
      required this.onPressed,
      required this.onHover,
      required this.title,
      super.key});

  Function onHover;
  Function onPressed;
  double fontSize;
  String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: Theme.of(context).textButtonTheme.style,
      onPressed: () => onPressed(),
      onHover: (_) => onHover(),
      child: AnimatedSize(
        duration: const Duration(milliseconds: AppDurations.dm300),
        curve: Curves.linear,
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p6),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(fontSize: fontSize),
          ),
        ),
      ),
    );
  }
}
