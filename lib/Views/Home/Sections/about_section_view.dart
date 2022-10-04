// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:portfolio/Data%20Managers/assets_manager.dart';
import 'package:portfolio/Data%20Managers/colors_manager.dart';
import 'package:portfolio/Data%20Managers/fonts_manager.dart';
import 'package:portfolio/Data%20Managers/strings_manager.dart';
import 'package:portfolio/Data%20Managers/values_manager.dart';
import 'package:portfolio/View%20Models/home_view_model.dart';
import 'package:provider/provider.dart';

import 'package:visibility_detector/visibility_detector.dart';

class AboutSection extends StatelessWidget {
  AboutSection({super.key});
  final GlobalKey _profileVisibiltyKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
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
                    ? _getLandscapeMode(context: context, value: value)
                    : _getPortraitMode(context: context, value: value),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getFormRow(
      {required String title1,
      required String title2,
      required Widget icon,
      required BuildContext context}) {
    return Row(
      children: [
        icon,
        const SizedBox(
          width: AppSize.s5,
        ),
        AutoSizeText(
          title1,
          maxLines: 1,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        Expanded(
          child: AutoSizeText(
            title2,
            maxLines: 1,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        )
      ],
    );
  }

  Widget _getPortraitMode(
      {required BuildContext context, required HomeViewModel value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: CircleAvatar(
            backgroundImage: AssetImage(AssetsManager.profileImg),
            radius: AppSize.s80,
          ),
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
            context: context),
        _formSpace(),
        _getFormRowFotPortrait(
            title1: AppStrings.educationTitle,
            title2: value.getPersonalInfo.education,
            icon: Image.asset(
              AssetsManager.educationIcon,
              width: AppSize.s25,
              height: AppSize.s25,
              color: ColorsManager.greyColor,
            ),
            context: context),
        _formSpace(),
        _getFormRowFotPortrait(
            title1: AppStrings.locationTitle,
            title2: value.getPersonalInfo.location,
            icon: const Icon(
              Icons.location_on_outlined,
              color: ColorsManager.greyColor,
            ),
            context: context),
        _formSpace(),
        _getFormRowFotPortrait(
            title1: AppStrings.phoneTitle,
            title2: value.getPersonalInfo.phoneNumber,
            icon: const Icon(
              Icons.phone_outlined,
              color: ColorsManager.greyColor,
            ),
            context: context),
        _formSpace(),
        _getFormRowFotPortrait(
            title1: AppStrings.emailTitle,
            title2: value.getPersonalInfo.email,
            icon: const Icon(
              Icons.email_outlined,
              color: ColorsManager.greyColor,
            ),
            context: context)
      ],
    );
  }

  Widget _getLandscapeMode(
      {required BuildContext context, required HomeViewModel value}) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage(AssetsManager.profileImg),
          radius: AppSize.s80,
        ),
        const SizedBox(
          width: AppSize.s20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _getFormRow(
                  title1: AppStrings.nameTitle,
                  title2: AppStrings.name,
                  icon: const Icon(
                    Icons.person_outline,
                    color: ColorsManager.greyColor,
                  ),
                  context: context),
              _formSpace(),
              _getFormRow(
                  title1: AppStrings.educationTitle,
                  title2: value.getPersonalInfo.education,
                  icon: Image.asset(
                    AssetsManager.educationIcon,
                    width: AppSize.s25,
                    height: AppSize.s25,
                    color: ColorsManager.greyColor,
                  ),
                  context: context),
              _formSpace(),
              _getFormRow(
                  title1: AppStrings.locationTitle,
                  title2: value.getPersonalInfo.location,
                  icon: const Icon(
                    Icons.location_on_outlined,
                    color: ColorsManager.greyColor,
                  ),
                  context: context),
              _formSpace(),
              _getFormRow(
                  title1: AppStrings.phoneTitle,
                  title2: value.getPersonalInfo.phoneNumber,
                  icon: const Icon(
                    Icons.phone_outlined,
                    color: ColorsManager.greyColor,
                  ),
                  context: context),
              _formSpace(),
              _getFormRow(
                  title1: AppStrings.emailTitle,
                  title2: value.getPersonalInfo.email,
                  icon: const Icon(
                    Icons.email_outlined,
                    color: ColorsManager.greyColor,
                  ),
                  context: context)
            ],
          ),
        )
      ],
    );
  }

  Widget _getFormRowFotPortrait(
      {required String title1,
      required String title2,
      required Widget icon,
      required BuildContext context}) {
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
          style: Theme.of(context).textTheme.subtitle2,
        ),
        Expanded(
          child: Text(
            title2,
            maxLines: 10,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        )
      ],
    );
  }

  Widget _formSpace() {
    return const SizedBox(height: AppSize.s15);
  }
}
