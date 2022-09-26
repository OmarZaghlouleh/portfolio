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
import 'package:portfolio/Views/Home/home_view_functions.dart';
import 'package:portfolio/Views/Home/home_view_parts.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  GlobalKey _profileVisibiltyKey = GlobalKey();
  GlobalKey _projectsVisibiltyKey = GlobalKey();
  GlobalKey _contactVisibiltyKey = GlobalKey();
  GlobalKey _musicVisibiltyKey = GlobalKey();

  GlobalKey _popupKey = GlobalKey();
  GlobalKey _musicKey = GlobalKey();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  PageController _pageController = PageController();

  late DeviceSize _deviceSize;
  late HomeViewParts _homeViewParts;
  late HomeViewFunctions _homeViewFunctions;

  late RippleAnimation _rippleAnimation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _rippleAnimation = RippleAnimation(this);
    _deviceSize = DeviceSize(context);
    _homeViewParts = HomeViewParts(
        context,
        _profileVisibiltyKey,
        _projectsVisibiltyKey,
        _deviceSize,
        _pageController,
        _contactVisibiltyKey,
        _musicVisibiltyKey);
    _homeViewFunctions = HomeViewFunctions();
  }

  @override
  void dispose() {
    _rippleAnimation.dispose();
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
                    opacity: p1.maxWidth <= 650
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
                                    child: const CircleAvatar(
                                      backgroundImage:
                                          AssetImage(AssetsManager.profileImg),
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
                  if (p1.maxWidth > 650)
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
                              child: Icon(
                                value.getIsLiked
                                    ? Icons.thumb_up_alt_rounded
                                    : Icons.thumb_up_off_alt_outlined,
                                color: ColorsManager.whiteColor,
                                size: value.getLikeSize,
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
                    _getTitleText(title: AppStrings.about),
                    _homeViewParts.getAboutPart(),
                    _getTitleText(title: AppStrings.flutterProjects),
                    _homeViewParts.getProjectsPart(),
                    _getTitleText(title: AppStrings.mileJourneyProject),
                    Consumer<HomeViewModel>(
                      builder: (context, value, child) => MileJourneyVideo(
                        musicVisibiltyKey: _musicVisibiltyKey,
                        widgetKey: _musicKey,
                        value: value,
                      ),
                    ),
                    _getTitleText(title: AppStrings.contact),
                    Consumer<HomeViewModel>(
                      builder: (context, value, child) =>
                          _homeViewParts.getContactContent(value, context),
                    )
                    // Column(
                    //   children:
                    //       List.generate(150, (index) => const Text("sss"))
                    //           .toList(),
                    // )
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
      padding: const EdgeInsets.all(AppPadding.p25),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }
}
