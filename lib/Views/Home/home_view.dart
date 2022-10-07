// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/Animations/ripple_animation.dart';
import 'package:portfolio/Data%20Managers/assets_manager.dart';
import 'package:portfolio/Data%20Managers/colors_manager.dart';
import 'package:portfolio/Data%20Managers/fonts_manager.dart';
import 'package:portfolio/Data%20Managers/functions.dart';
import 'package:portfolio/Data%20Managers/strings_manager.dart';
import 'package:portfolio/Data%20Managers/values_manager.dart';
import 'package:portfolio/View%20Models/home_view_model.dart';
import 'package:portfolio/View%20Models/splash_view_model.dart';
import 'package:portfolio/Views/Home/Sections/contacts_section.dart';
import 'package:portfolio/Views/Home/Sections/projects_section.dart';
import 'package:portfolio/Views/Home/home_view_functions.dart';
import 'package:portfolio/Views/Home/home_view_parts.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Sections/about_section_view.dart';
import 'Sections/mile_journey_section.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _popupKey = GlobalKey();
  final GlobalKey _musicKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  late DeviceSize _deviceSize;
  final HomeViewFunctions _homeViewFunctions = HomeViewFunctions();

  @override
  void initState() {
    super.initState();
    _deviceSize = DeviceSize(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: ColorsManager.gradientColors),
      ),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: HomeDrawer(
            homeViewFunctions: _homeViewFunctions,
            popupKey: _popupKey,
            musicKey: _musicKey,
            scrollController: _scrollController),
        body: Column(
          children: [
            LayoutBuilder(
              builder: (p0, p1) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: AppDurations.dm300),
                    opacity: p1.maxWidth <= _deviceSize.maxWidth
                        ? OpacityValues.op1
                        : OpacityValues.op0,
                    child: IconButton(
                        onPressed: () {
                          if (_scaffoldKey.currentState != null) {
                            _scaffoldKey.currentState!.isDrawerOpen
                                ? _scaffoldKey.currentState!.closeDrawer()
                                : _scaffoldKey.currentState!.openDrawer();
                          }
                        },
                        icon: const Icon(
                          Icons.list_rounded,
                          color: ColorsManager.whiteColor,
                        )),
                  ),
                  const SizedBox(
                    width: AppWidth.w20,
                  ),
                  Consumer<HomeViewModel>(
                      builder: (context, value, child) => Padding(
                            padding: const EdgeInsets.all(AppPadding.p8),
                            child: AnimatedOpacity(
                              opacity: !value.getIsProfileVisible ? 1 : 0,
                              duration: const Duration(
                                  milliseconds: AppDurations.dm300),
                              child: Row(
                                children: [
                                  ElasticInLeft(
                                    delay: const Duration(
                                        seconds: AppDurations.ds1),
                                    duration: const Duration(
                                        seconds: AppDurations.ds2),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          value.getPersonalInfo.imageUrl),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: AppSize.s10,
                                  ),
                                  ElasticInLeft(
                                    child: Text(AppStrings.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3),
                                  ),
                                ],
                              ),
                            ),
                          )),
                  if (p1.maxWidth > _deviceSize.maxWidth)
                    Padding(
                      padding: const EdgeInsets.all(AppPadding.p8),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: AppSize.s30,
                          ),
                          Consumer<HomeViewModel>(
                            builder: (context, value, child) => AppbarAction(
                                fontSize: value.getAboutFontSize,
                                onPressed: () =>
                                    _homeViewFunctions.pressAboutFunction(
                                        _scrollController, value),
                                onHover: () => _homeViewFunctions
                                    .hoverAboutFunction(value),
                                title: AppStrings.about),
                          ),
                          Consumer<HomeViewModel>(
                              builder: (context, value, child) => InkWell(
                                    onTap: () {},
                                    onHover: (isHovered) {
                                      log("Hov");
                                      value.setProjectsFontSize();
                                      dynamic state = _popupKey.currentState;
                                      if (isHovered) state.showButtonMenu();
                                    },
                                    child: PopupMenuButton(
                                      offset: const Offset(
                                          AppOffset.of0, AppOffset.of10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppSize.s15)),
                                      key: _popupKey,
                                      position: PopupMenuPosition.under,
                                      color: ColorsManager.blackColor
                                          .withOpacity(OpacityValues.op0_3),
                                      onSelected: (selected) {
                                        _homeViewFunctions
                                            .selectProjectFunction(
                                                _scrollController,
                                                value,
                                                selected);
                                      },
                                      itemBuilder: (context) =>
                                          value.getProjects
                                              .map(
                                                (e) => PopupMenuItem(
                                                  value: e.name,
                                                  child: Text(
                                                    e.name,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelMedium,
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                      child: AnimatedSize(
                                        duration: const Duration(
                                            milliseconds: AppDurations.dm300),
                                        curve: Curves.linear,
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              AppPadding.p6),
                                          child: Text(
                                            AppStrings.projects,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .copyWith(
                                                    fontSize: value
                                                        .getProjectsFontSize),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                          Consumer<HomeViewModel>(
                            builder: (context, value, child) => AppbarAction(
                                fontSize: value.getMusicFontSize,
                                onPressed: () =>
                                    _homeViewFunctions.pressMusicFunction(
                                        _scrollController, value, _musicKey),
                                onHover: () => _homeViewFunctions
                                    .hoverMusicFunction(value),
                                title: AppStrings.music),
                          ),
                          Consumer<HomeViewModel>(
                            builder: (context, value, child) => AppbarAction(
                                fontSize: value.getContactFontSize,
                                onPressed: () =>
                                    _homeViewFunctions.pressContactFunction(
                                        _scrollController, value),
                                onHover: () => _homeViewFunctions
                                    .hoverContactFunction(value),
                                title: AppStrings.contact),
                          ),
                          Consumer<HomeViewModel>(
                            builder: (context, value, child) => InkWell(
                              onTap: () async {
                                if (!value.getIsLiked)
                                  await _homeViewFunctions.pressLikeButton(
                                      value, true);
                                else
                                  await _homeViewFunctions.pressLikeButton(
                                      value, false);
                              },
                              onHover: (_) {
                                _homeViewFunctions.hoverLikeButton(value);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorsManager.blackColor
                                      .withOpacity(OpacityValues.op0_3),
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s15),
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
                                          .copyWith(
                                              color: ColorsManager.whiteColor),
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
                          const SizedBox(
                            width: AppSize.s30,
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //About Title
                    _getTitleText(title: AppStrings.about),
                    //About
                    AboutSection(),
                    //Projects Title
                    _getTitleText(title: AppStrings.flutterProjects),
                    //Projects
                    ProjectsSection(),
                    _getTitleText(title: AppStrings.mileJourneyProject),
                    _getLinkText(
                        title: AppStrings.mileJourneyYoutubeUrl +
                            AppStrings.mileJourneyUrl),
                    MileJourneyVideo(widgetKey: _musicKey),
                    _getTitleText(title: AppStrings.contact),
                    ContactSection()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getTitleText({required String title}) {
    return Padding(
      padding: const EdgeInsets.only(
          top: AppPadding.p25, left: AppPadding.p25, right: AppPadding.p25),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }

  Widget _getLinkText({required String title}) {
    return Padding(
      padding: const EdgeInsets.only(
          left: AppPadding.p25, top: AppPadding.p4, bottom: AppPadding.p8),
      child: InkWell(
        onTap: () {
          launchUrl(Uri.parse(AppStrings.mileJourneyUrl));
        },
        child: Text(
          title,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: ColorsManager.greyColor,
              decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}
