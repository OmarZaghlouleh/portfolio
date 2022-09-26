// ignore_for_file: use_build_context_synchronously

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/Animations/ripple_animation.dart';
import 'package:portfolio/Data%20Managers/colors_manager.dart';
import 'package:portfolio/Data%20Managers/routes_manager.dart';
import 'package:portfolio/Data%20Managers/strings_manager.dart';
import 'package:portfolio/View%20Models/home_view_model.dart';
import 'package:portfolio/View%20Models/splash_view_model.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';
import 'package:provider/provider.dart';
import '../../Data Managers/values_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late DeviceSize _deviceSize;
  late RippleAnimation _rippleAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _deviceSize = DeviceSize(context);
    _rippleAnimation = RippleAnimation(this);
  }

  @override
  void dispose() {
    _rippleAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PositionedTapDetector2(
      onTap: (position) async {
        if (!Provider.of<SplashViewModel>(context, listen: false)
            .getAnimation) {
          Provider.of<SplashViewModel>(context, listen: false)
              .setAnimation(true);
          _rippleAnimation.startAnimaton();
        }
        Future.delayed(const Duration(milliseconds: AppDurations.dm350))
            .then((value) {
          Provider.of<SplashViewModel>(context, listen: false)
              .setAnimation(false);
          _rippleAnimation.stopAnimation();
        });
        Provider.of<SplashViewModel>(context, listen: false)
            .setAnimationPosition(
                Vector2(position.relative!.dx, position.relative!.dy));
      },
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: ColorsManager.gradientColors),
            ),
            child: Scaffold(
              //appBar: AppBar(),
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Consumer<HomeViewModel>(
                      builder: (context, value, child) => AnimatedTextKit(
                        pause: const Duration(milliseconds: AppDurations.d0),
                        onNextBeforePause: (_, a) {
                          value.setTextfinished(true);
                        },
                        animatedTexts: [
                          TypewriterAnimatedText(AppStrings.name,
                              textStyle: Theme.of(context).textTheme.headline2!,
                              speed: const Duration(
                                  milliseconds: AppDurations.dm150)),
                        ],
                        isRepeatingAnimation: false,
                        repeatForever: false,
                        stopPauseOnTap: true,
                        displayFullTextOnTap: true,
                      ),
                    )),
                    const SizedBox(height: AppSize.s10),
                    Consumer<HomeViewModel>(
                      builder: (context, value, child) => value.getTextFinished
                          ? AnimatedTextKit(
                              pause:
                                  const Duration(milliseconds: AppDurations.d0),
                              onFinished: () async {
                                await Provider.of<HomeViewModel>(context,
                                        listen: false)
                                    .setPersonalInfo();
                                await Provider.of<HomeViewModel>(context,
                                        listen: false)
                                    .setContacts();
                                await Provider.of<HomeViewModel>(context,
                                        listen: false)
                                    .checkLike();
                                await Provider.of<HomeViewModel>(context,
                                        listen: false)
                                    .setProjects()
                                    .then((value) {
                                  Navigator.pushReplacementNamed(
                                      context, RoutesName.home);
                                });
                              },
                              animatedTexts: [
                                TypewriterAnimatedText(AppStrings.portfolio,
                                    textStyle:
                                        Theme.of(context).textTheme.subtitle2,
                                    speed: const Duration(
                                        milliseconds: AppDurations.dm100)),
                              ],
                              isRepeatingAnimation: false,
                              repeatForever: false,
                              stopPauseOnTap: true,
                              displayFullTextOnTap: true,
                            )
                          : const Text(''),
                    ),
                    const SizedBox(height: AppSize.s30),
                    // SizedBox(
                    //   width: _deviceSize.getQurterWidth,
                    //   height: AppSize.s1,
                    //   child: const LinearProgressIndicator(
                    //     color: ColorsManager.whiteColor,
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ),
          Consumer<SplashViewModel>(
            builder: (context, value, child) => value.getAnimation
                ? Positioned(
                    left: value.getAnimationPosition.x - CirclePositionDif.x,
                    top: value.getAnimationPosition.y - CirclePositionDif.y,
                    child: ScaleTransition(
                      scale: _rippleAnimation.getAnimation,
                      child: Container(
                        width: AppSize.s30,
                        height: AppSize.s30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorsManager.accentColor
                                .withOpacity(OpacityValues.op0_1)),
                      ),
                    ),
                  )
                : const Text(''),
          ),
        ],
      ),
    );
  }
}
