// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pod_player/pod_player.dart';
import 'package:portfolio/Data%20Managers/enums_manager.dart';
import 'package:portfolio/Models/project_model.dart';
import 'package:portfolio/Views/Home/home_view_functions.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../Data Managers/assets_manager.dart';
import '../../Data Managers/colors_manager.dart';
import '../../Data Managers/fonts_manager.dart';
import '../../Data Managers/strings_manager.dart';
import '../../Data Managers/values_manager.dart';
import '../../View Models/home_view_model.dart';

class HomeViewParts {
  BuildContext _context;
  Key _profileVisibiltyKey;
  Key _projectsVisibiltyKey;
  Key _contactVisibiltyKey;
  Key _musicVisibiltyKey;

  DeviceSize _deviceSize;
  PageController _pageController;

  HomeViewParts(
      this._context,
      this._profileVisibiltyKey,
      this._projectsVisibiltyKey,
      this._deviceSize,
      this._pageController,
      this._contactVisibiltyKey,
      this._musicVisibiltyKey);

  GlobalKey _portraitColumnKey = GlobalKey();

  Widget getAboutPart() {
    return Consumer<HomeViewModel>(
      builder: (context, value, child) => VisibilityDetector(
        key: _profileVisibiltyKey,
        onVisibilityChanged: (info) {
          if (info.visibleFraction <= AppFractions.f0_2) {
            value.setIsProfileVisible(false);
            value.setAboutCustomFontSize(FontsSize.s15);
          } else {
            value.setIsProfileVisible(true);
            value.setAboutCustomFontSize(FontsSize.s20);
          }
        },
        child: InkWell(
          splashColor: ColorsManager.transarentColor,
          hoverColor: ColorsManager.transarentColor,
          focusColor: ColorsManager.transarentColor,
          overlayColor: MaterialStateProperty.all(
            ColorsManager.transarentColor,
          ),
          highlightColor: ColorsManager.transarentColor,
          onTap: () {},
          onHover: (_) {
            value.setProfileContainerHover();
          },
          child: Container(
            margin: const EdgeInsets.all(AppPadding.p25),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: ColorsManager.gradientColors2,
              ),
              boxShadow: value.getIsProfileContainerHovered
                  ? [
                      BoxShadow(
                          color: ColorsManager.blackColor
                              .withOpacity(OpacityValues.op0_3),
                          offset: const Offset(0, AppSize.s10)),
                      BoxShadow(
                          color: ColorsManager.blackColor
                              .withOpacity(OpacityValues.op0_3),
                          offset: const Offset(0, -AppSize.s10)),
                    ]
                  : [],
              borderRadius: BorderRadius.circular(AppSize.s15),
              border: Border.all(
                  color: ColorsManager.primaryColor, width: AppSize.s1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p50),
              child: LayoutBuilder(
                builder: (p0, p1) => p1.maxWidth > 600
                    ? Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage(AssetsManager.profileImg),
                            radius: AppSize.s80,
                          ),
                          const SizedBox(
                            width: AppSize.s20,
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _getFormRow(
                                    title1: AppStrings.nameTitle,
                                    title2: AppStrings.name,
                                    icon: const Icon(
                                      Icons.person_outline,
                                      color: ColorsManager.greyColor,
                                    ),
                                  ),
                                  _formSpace(),
                                  _getFormRow(
                                      title1: AppStrings.educationTitle,
                                      title2: value.getPersonalInfo.education,
                                      icon: SvgPicture.asset(
                                        AssetsManager.educationIcon,
                                        width: AppSize.s25,
                                        height: AppSize.s25,
                                        color: ColorsManager.greyColor,
                                      )),
                                  _formSpace(),
                                  _getFormRow(
                                    title1: AppStrings.locationTitle,
                                    title2: value.getPersonalInfo.location,
                                    icon: const Icon(
                                      Icons.location_on_outlined,
                                      color: ColorsManager.greyColor,
                                    ),
                                  ),
                                  _formSpace(),
                                  _getFormRow(
                                    title1: AppStrings.phoneTitle,
                                    title2: value.getPersonalInfo.phoneNumber,
                                    icon: const Icon(
                                      Icons.phone_outlined,
                                      color: ColorsManager.greyColor,
                                    ),
                                  ),
                                  _formSpace(),
                                  _getFormRow(
                                    title1: AppStrings.emailTitle,
                                    title2: value.getPersonalInfo.email,
                                    icon: const Icon(
                                      Icons.email_outlined,
                                      color: ColorsManager.greyColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    : Column(
                        children: [
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage(AssetsManager.profileImg),
                            radius: AppSize.s80,
                          ),
                          const SizedBox(
                            height: AppSize.s20,
                          ),
                          _getFormRowFotPortrait(
                            title1: AppStrings.nameTitle,
                            title2: AppStrings.name,
                            icon: const Icon(
                              Icons.person_outline,
                              color: ColorsManager.greyColor,
                            ),
                          ),
                          _formSpace(),
                          _getFormRowFotPortrait(
                              title1: AppStrings.educationTitle,
                              title2: value.getPersonalInfo.education,
                              icon: SvgPicture.asset(
                                AssetsManager.educationIcon,
                                width: AppSize.s25,
                                height: AppSize.s25,
                                color: ColorsManager.greyColor,
                              )),
                          _formSpace(),
                          _getFormRowFotPortrait(
                            title1: AppStrings.locationTitle,
                            title2: value.getPersonalInfo.location,
                            icon: const Icon(
                              Icons.location_on_outlined,
                              color: ColorsManager.greyColor,
                            ),
                          ),
                          _formSpace(),
                          _getFormRowFotPortrait(
                            title1: AppStrings.phoneTitle,
                            title2: value.getPersonalInfo.phoneNumber,
                            icon: const Icon(
                              Icons.phone_outlined,
                              color: ColorsManager.greyColor,
                            ),
                          ),
                          _formSpace(),
                          _getFormRowFotPortrait(
                            title1: AppStrings.emailTitle,
                            title2: value.getPersonalInfo.email,
                            icon: const Icon(
                              Icons.email_outlined,
                              color: ColorsManager.greyColor,
                            ),
                          )
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getProjectsPart() {
    return Consumer<HomeViewModel>(
        builder: (context, value, child) => VisibilityDetector(
              key: _projectsVisibiltyKey,
              onVisibilityChanged: (info) {
                if (int.tryParse(info.visibleFraction.toString()) ==
                        AppFractions.f1 ||
                    info.visibleFraction > AppFractions.f0_2) {
                  value.setIsPrjectsVisible(true);
                  value.setProjectsCustomFontSize(FontsSize.s20);
                } else {
                  value.setIsPrjectsVisible(false);
                  value.setProjectsCustomFontSize(FontsSize.s15);
                }
              },
              child: Column(
                children: value.getProjects
                    .map((e) => LayoutBuilder(builder: (p0, p1) {
                          if (p1.maxWidth > 600)
                            return _getProjectsForLandscape(
                                e: e, context: context, p1: p1);
                          else
                            return _getProjectsForPortrait(
                                e: e, context: context, p1: p1);
                        }))
                    .toList(),
              ),
            ));
  }

  Widget _getProjectsForPortrait(
      {required ProjectsModel e,
      required BuildContext context,
      required BoxConstraints p1}) {
    return Container(
      key: e.key,
      alignment: Alignment.centerLeft,
      height: AppHeights.h1100,
      width: p1.maxWidth,
      margin: const EdgeInsets.all(AppPadding.p25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            // colors: ColorsManager.gradientColors2,
            colors: e.colors
                .map((e) => Color(int.tryParse(e) ?? 0xffffff))
                .toList()),
        borderRadius: BorderRadius.circular(AppSize.s15),
        border:
            Border.all(color: ColorsManager.primaryColor, width: AppSize.s1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (e.images.isNotEmpty || e.videos.isNotEmpty)
            AutoPageView(
              projectsModel: e,
              width: double.infinity,
              height: AppHeights.h700,
              mode: Mode.Portrait,
              loadingColor: Color(int.tryParse(e.colors[0]) ?? 0xffffff),
            ),
          const SizedBox(width: AppWidth.w30),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e.name,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppPadding.p4),
                      child: Text(
                        e.description,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                    const SizedBox(height: AppHeights.h20),
                    if (e.features.isNotEmpty)
                      Text(
                        AppStrings.featuresTitle,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ListBody(
                      children: e.features
                          .map((e) => Padding(
                                padding: const EdgeInsets.all(AppPadding.p8),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      size: AppSize.s10,
                                      color: ColorsManager.greyColor,
                                    ),
                                    const SizedBox(width: AppWidth.w10),
                                    Expanded(
                                      child: Text(
                                        e,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                    if (e.upComingFeatures.isNotEmpty)
                      Text(
                        AppStrings.upComingFeaturesTitle,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ListBody(
                      children: e.upComingFeatures
                          .map((e) => Padding(
                                padding: const EdgeInsets.all(AppPadding.p8),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      size: AppSize.s10,
                                      color: ColorsManager.greyColor,
                                    ),
                                    const SizedBox(width: AppWidth.w10),
                                    Expanded(
                                      child: Text(
                                        e,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getProjectsForLandscape(
      {required ProjectsModel e,
      required BuildContext context,
      required BoxConstraints p1}) {
    return Container(
      key: e.key,
      alignment: Alignment.centerLeft,
      height: AppHeights.h500,
      width: p1.maxWidth,
      margin: const EdgeInsets.all(AppPadding.p25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            //colors: ColorsManager.gradientColors2,
            colors: e.colors
                .map((e) => Color(int.tryParse(e) ?? 0xffffff))
                .toList()),
        borderRadius: BorderRadius.circular(AppSize.s15),
        border:
            Border.all(color: ColorsManager.primaryColor, width: AppSize.s1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AutoPageView(
            width: AppWidth.w300,
            height: AppHeights.h500,
            projectsModel: e,
            mode: Mode.Landscape,
            loadingColor: Color(int.tryParse(e.colors[0]) ?? 0xffffff),
          ),
          const SizedBox(width: AppWidth.w30),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.name,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p4),
                    child: Text(
                      e.description,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                  const SizedBox(height: AppHeights.h20),
                  if (e.features.isNotEmpty)
                    Text(
                      AppStrings.featuresTitle,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ListBody(
                    children: e.features
                        .map((e) => Padding(
                              padding: const EdgeInsets.all(AppPadding.p8),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.circle,
                                    size: AppSize.s10,
                                    color: ColorsManager.greyColor,
                                  ),
                                  const SizedBox(width: AppWidth.w10),
                                  Expanded(
                                    child: Text(
                                      e,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                  if (e.upComingFeatures.isNotEmpty)
                    Text(
                      AppStrings.upComingFeaturesTitle,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ListBody(
                    children: e.upComingFeatures
                        .map((e) => Padding(
                              padding: const EdgeInsets.all(AppPadding.p8),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.circle,
                                    size: AppSize.s10,
                                    color: ColorsManager.greyColor,
                                  ),
                                  const SizedBox(width: AppWidth.w10),
                                  Expanded(
                                    child: Text(
                                      e,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _formSpace() {
    return const SizedBox(height: AppSize.s15);
  }

  Widget _getIconRowItem({required String url, required Widget icon}) {
    return IconButton(
        onPressed: () {
          try {
            launchUrl(Uri.parse(url));
          } catch (e) {}
        },
        icon: icon);
  }

  Widget _getFormRow(
      {required String title1, required String title2, required Widget icon}) {
    return Row(
      children: [
        icon,
        const SizedBox(
          width: AppSize.s5,
        ),
        AutoSizeText(
          title1,
          maxLines: 1,
          style: Theme.of(_context).textTheme.subtitle2,
        ),
        Expanded(
          child: AutoSizeText(
            title2,
            maxLines: 1,
            style: Theme.of(_context).textTheme.labelMedium,
          ),
        )
      ],
    );
  }

  Widget _getFormRowFotPortrait(
      {required String title1, required String title2, required Widget icon}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon,
        const SizedBox(
          width: AppSize.s5,
        ),
        AutoSizeText(
          title1,
          maxLines: 1,
          style: Theme.of(_context).textTheme.subtitle2,
        ),
        Expanded(
          child: AutoSizeText(
            title2,
            maxLines: 2,
            style: Theme.of(_context).textTheme.labelMedium,
          ),
        )
      ],
    );
  }

  Widget getContactContent(HomeViewModel value) {
    return VisibilityDetector(
      key: _contactVisibiltyKey,
      onVisibilityChanged: (info) {
        if (int.tryParse(info.visibleFraction.toString()) == AppFractions.f1 ||
            info.visibleFraction > AppFractions.f0_2) {
          value.setIsContactVisible(true);
          value.setCustomContactFontSize(FontsSize.s20);
        } else {
          value.setIsContactVisible(false);
          value.setCustomContactFontSize(FontsSize.s15);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: value.getContacts
            .map((e) => _getIconRowItem(
                url: e.url, icon: SvgPicture.asset(e.assetPath)))
            .toList(),
      ),
    );
  }
}

class AutoPageView extends StatefulWidget {
  AutoPageView(
      {required this.projectsModel,
      required this.width,
      required this.height,
      required this.mode,
      required this.loadingColor,
      super.key});
  ProjectsModel projectsModel;
  double width;
  double height;
  Mode mode;
  Color loadingColor;

  @override
  State<AutoPageView> createState() => _AutoPageViewState();
}

class _AutoPageViewState extends State<AutoPageView> {
  final PageController _scrollController = PageController();
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: AppDurations.ds4), (timer) {
      if (_scrollController.page == widget.projectsModel.images.length - 1) {
        _scrollController.animateToPage(0,
            duration: const Duration(milliseconds: AppDurations.dm300),
            curve: Curves.linear);
      } else {
        _scrollController.nextPage(
            duration: const Duration(milliseconds: AppDurations.dm300),
            curve: Curves.linear);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.mode == Mode.Landscape
          ? const BorderRadius.only(
              topLeft: Radius.circular(AppSize.s15),
              bottomLeft: Radius.circular(AppSize.s15))
          : const BorderRadius.only(
              topLeft: Radius.circular(AppSize.s15),
              topRight: Radius.circular(AppSize.s15)),
      child: LayoutBuilder(
        builder: (p0, p1) => SizedBox(
          width: widget.width,
          height: widget.height,
          child: PageView(
            controller: _scrollController,
            children: widget.projectsModel.images
                .map(
                  (e) => Image(
                    loadingBuilder: (context, child, loadingProgress) =>
                        LinearProgressIndicator(
                            backgroundColor: widget.loadingColor,
                            color: ColorsManager.blackColor
                                .withOpacity(OpacityValues.op0_2)),
                    fit: BoxFit.fill,
                    image: NetworkImage(e),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

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
    return SizedBox(
      height: AppHeights.h250,
      child: Drawer(
        backgroundColor:
            ColorsManager.primaryColor.withOpacity(OpacityValues.op0_7),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(AppSize.s15),
                bottomRight: Radius.circular(AppSize.s15))),
        child: LayoutBuilder(
          builder: (p0, p1) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<HomeViewModel>(
                builder: (context, value, child) => AppbarAction(
                    fontSize: value.getAboutFontSize,
                    onPressed: () => homeViewFunctions.pressAboutFunction(
                        scrollController, value),
                    onHover: () => homeViewFunctions.hoverAboutFunction(value),
                    title: AppStrings.about),
              ),
              Consumer<HomeViewModel>(
                  builder: (context, value, child) => InkWell(
                      onTap: () {},
                      onHover: (isHovered) {
                        value.setProjectsFontSize();
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
                                  .copyWith(
                                      fontSize: value.getProjectsFontSize),
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
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
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
                    onHover: () => homeViewFunctions.hoverMusicFunction(value),
                    title: AppStrings.music),
              ),
              Consumer<HomeViewModel>(
                builder: (context, value, child) => AppbarAction(
                    fontSize: value.getContactFontSize,
                    onPressed: () => homeViewFunctions.pressContactFunction(
                        scrollController, value),
                    onHover: () =>
                        homeViewFunctions.hoverContactFunction(value),
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
                    child: Icon(
                      value.getIsLiked
                          ? Icons.thumb_up_alt_rounded
                          : Icons.thumb_up_off_alt_outlined,
                      color: ColorsManager.whiteColor,
                      size: value.getLikeSize,
                    ),
                  ),
                ),
              ),
            ],
          ),
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

class MileJourneyVideo extends StatefulWidget {
  MileJourneyVideo(
      {required this.musicVisibiltyKey,
      required this.value,
      required this.widgetKey,
      super.key});
  GlobalKey musicVisibiltyKey;
  GlobalKey widgetKey;

  HomeViewModel value;

  @override
  State<MileJourneyVideo> createState() => _MileJourneyVideoState();
}

class _MileJourneyVideoState extends State<MileJourneyVideo> {
  late final PodPlayerController _controller;

  @override
  void initState() {
    log("Video");

    _controller = PodPlayerController(
      podPlayerConfig: const PodPlayerConfig(
          autoPlay: false, videoQualityPriority: [240, 360, 480, 720, 1080]),
      playVideoFrom: PlayVideoFrom.youtube(AppStrings.mileJourneyUrl),
    )..initialise();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      onVisibilityChanged: (info) {
        if (int.tryParse(info.visibleFraction.toString()) == AppFractions.f1 ||
            info.visibleFraction > AppFractions.f0_2) {
          widget.value.setIsMusicVisible(true);
          widget.value.setCustomMusicFontSize(FontsSize.s20);
        } else {
          widget.value.setIsMusicVisible(false);
          widget.value.setCustomMusicFontSize(FontsSize.s15);
        }
      },
      key: widget.musicVisibiltyKey,
      child: SizedBox(
        key: widget.widgetKey,
        height: AppHeights.h500,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSize.s15),
          child: PodVideoPlayer(
            controller: _controller,
          ),
        ),
      ),
    );
  }
}