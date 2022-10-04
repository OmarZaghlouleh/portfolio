import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:portfolio/Data%20Managers/colors_manager.dart';
import 'package:portfolio/Data%20Managers/enums_manager.dart';
import 'package:portfolio/Data%20Managers/fonts_manager.dart';
import 'package:portfolio/Data%20Managers/strings_manager.dart';
import 'package:portfolio/Data%20Managers/values_manager.dart';
import 'package:portfolio/Models/project_model.dart';
import 'package:portfolio/View%20Models/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ProjectsSection extends StatefulWidget {
  ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  final GlobalKey _projectsVisibiltyKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
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
                          if (p1.maxWidth > 600) {
                            return Container(
                              child: LandscapeProject(
                                  e: e, context: context, p1: p1),
                            );
                          } else {
                            return ProtraitProject(
                                e: e, context: context, p1: p1);
                          }
                        }))
                    .toList(),
              ),
            ));
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
                  (e) =>
                      //HtmlElementView(viewType: e)
                      Image(
                    loadingBuilder: (context, child, loadingProgress) =>
                        loadingProgress == null
                            ? child
                            : LinearProgressIndicator(
                                backgroundColor: widget.loadingColor,
                                color: ColorsManager.blackColor
                                    .withOpacity(OpacityValues.op0_2),
                              ),
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

class ProtraitProject extends StatefulWidget {
  ProtraitProject(
      {required this.e, required this.context, required this.p1, super.key});
  ProjectsModel e;
  BuildContext context;
  BoxConstraints p1;

  @override
  State<ProtraitProject> createState() => _ProtraitProjectState();
}

class _ProtraitProjectState extends State<ProtraitProject> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      onHover: (hover) {
        setState(() {
          _isHovered = hover;
        });
      },
      child: Container(
        key: widget.e.key,
        alignment: Alignment.centerLeft,
        height: AppHeights.h1100,
        width: widget.p1.maxWidth,
        margin: const EdgeInsets.all(AppPadding.p25),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              // colors: ColorsManager.gradientColors2,
              colors: widget.e.colors
                  .map((e) => Color(int.tryParse(e) ?? 0xffffff))
                  .toList()),
          borderRadius: BorderRadius.circular(AppSize.s15),
          border:
              Border.all(color: ColorsManager.primaryColor, width: AppSize.s1),
          boxShadow: _isHovered
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
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (widget.e.images.isNotEmpty || widget.e.videos.isNotEmpty)
              AutoPageView(
                projectsModel: widget.e,
                width: double.infinity,
                height: AppHeights.h700,
                mode: Mode.Portrait,
                loadingColor:
                    Color(int.tryParse(widget.e.colors[0]) ?? 0xffffff),
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
                        widget.e.name,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppPadding.p4),
                        child: Text(
                          widget.e.description,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                      const SizedBox(height: AppHeights.h20),
                      if (widget.e.features.isNotEmpty)
                        Text(
                          AppStrings.featuresTitle,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ListBody(
                        children: widget.e.features
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
                      if (widget.e.upComingFeatures.isNotEmpty)
                        Text(
                          AppStrings.upComingFeaturesTitle,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ListBody(
                        children: widget.e.upComingFeatures
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
      ),
    );
  }
}

class LandscapeProject extends StatefulWidget {
  LandscapeProject(
      {required this.e, required this.context, required this.p1, super.key});
  ProjectsModel e;
  BuildContext context;
  BoxConstraints p1;

  @override
  State<LandscapeProject> createState() => _LandscapeProjectState();
}

class _LandscapeProjectState extends State<LandscapeProject> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      onHover: (hover) {
        setState(() {
          _isHovered = hover;
        });
      },
      child: Container(
        key: widget.e.key,
        alignment: Alignment.centerLeft,
        height: AppHeights.h500,
        width: widget.p1.maxWidth,
        margin: const EdgeInsets.all(AppPadding.p25),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              //colors: ColorsManager.gradientColors2,
              colors: widget.e.colors
                  .map((e) => Color(int.tryParse(e) ?? 0xffffff))
                  .toList()),
          borderRadius: BorderRadius.circular(AppSize.s15),
          border:
              Border.all(color: ColorsManager.primaryColor, width: AppSize.s1),
          boxShadow: _isHovered
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
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AutoPageView(
              width: AppWidth.w300,
              height: AppHeights.h500,
              projectsModel: widget.e,
              mode: Mode.Landscape,
              loadingColor: Color(int.tryParse(widget.e.colors[0]) ?? 0xffffff),
            ),
            const SizedBox(width: AppWidth.w30),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.e.name,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppPadding.p4),
                      child: Text(
                        widget.e.description,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                    const SizedBox(height: AppHeights.h20),
                    if (widget.e.features.isNotEmpty)
                      Text(
                        AppStrings.featuresTitle,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ListBody(
                      children: widget.e.features
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
                    if (widget.e.upComingFeatures.isNotEmpty)
                      Text(
                        AppStrings.upComingFeaturesTitle,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ListBody(
                      children: widget.e.upComingFeatures
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
      ),
    );
  }
}
