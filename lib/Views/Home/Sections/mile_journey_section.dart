import 'package:flutter/material.dart';
import 'package:portfolio/Data%20Managers/assets_manager.dart';
import 'package:portfolio/Data%20Managers/colors_manager.dart';
import 'package:portfolio/Data%20Managers/fonts_manager.dart';
import 'package:portfolio/Data%20Managers/strings_manager.dart';
import 'package:portfolio/Data%20Managers/values_manager.dart';
import 'package:portfolio/View%20Models/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MileJourneyVideo extends StatefulWidget {
  MileJourneyVideo({required this.widgetKey, super.key});

  final GlobalKey _musicVisibiltyKey = GlobalKey();
  GlobalKey widgetKey;
  @override
  State<MileJourneyVideo> createState() => _MileJourneyVideoState();
}

class _MileJourneyVideoState extends State<MileJourneyVideo> {
  late final VideoPlayerController _controller;
  bool _isHovered = true;
  String _icon = AssetsManager.play;

  @override
  void initState() {
    _controller =
        VideoPlayerController.network(AppStrings.mileJourneyDataSourceURL);

    _controller.addListener(() {
      if (!_controller.value.isPlaying) {
        setState(() {
          _icon = AssetsManager.play;
          _isHovered = true;
        });
      } else {
        _icon = AssetsManager.pause;
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, value, child) => VisibilityDetector(
        onVisibilityChanged: (info) {
          if (int.tryParse(info.visibleFraction.toString()) ==
                  AppFractions.f1 ||
              info.visibleFraction > AppFractions.f0_2) {
            value.setIsMusicVisible(true);
            value.setCustomMusicFontSize(FontsSize.s20);
          } else {
            value.setIsMusicVisible(false);
            value.setCustomMusicFontSize(FontsSize.s15);
          }
        },
        key: widget._musicVisibiltyKey,
        child: LayoutBuilder(builder: (p0, p1) {
          return InkWell(
            key: widget.widgetKey,
            onTap: () {
              if (_controller.value.isPlaying) {
                setState(() {
                  _isHovered = !_isHovered;
                });
              }
            },
            onHover: (hover) {
              if (_controller.value.isPlaying) {
                setState(() {
                  _isHovered = hover;
                });
              }
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: AppHeights.h500,
                      // aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(
                        _controller,
                      ),
                    ),
                    Row(
                      children: [
                        if (p1.maxWidth < 500)
                          IconButton(
                              onPressed: () {
                                if (!_controller.value.isInitialized) {
                                  _controller.initialize().then((_) {
                                    setState(() {});
                                  });
                                  if (_controller.value.isPlaying) {
                                    _controller.pause();
                                  } else {
                                    _controller.play();
                                  }
                                } else {
                                  if (_controller.value.isPlaying) {
                                    _controller.pause();
                                  } else {
                                    _controller.play();
                                  }
                                }
                              },
                              icon: Image(
                                width: AppWidth.w30,
                                image: AssetImage(
                                  _icon,
                                ),
                                color: ColorsManager.accentColor,
                              )),
                        Expanded(
                          child: VideoProgressIndicator(
                            _controller,
                            padding: EdgeInsets.zero,
                            allowScrubbing: true,
                            colors: const VideoProgressColors(
                                playedColor: ColorsManager.accentColor),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                if (_isHovered)
                  Container(
                    width: AppWidth.w75,
                    decoration: BoxDecoration(
                        color: ColorsManager.blackColor
                            .withOpacity(OpacityValues.op0_8),
                        borderRadius: BorderRadius.circular(AppSize.s1000),
                        border: Border.all(color: ColorsManager.primaryColor)),
                    child: Center(
                      child: IconButton(
                          onPressed: () {
                            if (!_controller.value.isInitialized) {
                              _controller.initialize().then((_) {
                                setState(() {});
                              });
                              if (_controller.value.isPlaying) {
                                _controller.pause();
                                setState(() {
                                  _isHovered = true;
                                  //_icon = Icons.play_arrow_rounded;
                                });
                              } else {
                                _controller.play();
                                setState(() {
                                  _isHovered = false;
                                  //_icon = Icons.pause_rounded;
                                });
                              }
                            } else {
                              if (_controller.value.isPlaying) {
                                _controller.pause();
                                setState(() {
                                  _isHovered = true;
                                  //_icon = Icons.play_arrow_rounded;
                                });
                              } else {
                                _controller.play();
                                setState(() {
                                  _isHovered = false;
                                  //_icon = Icons.pause_rounded;
                                });
                              }
                            }
                          },
                          icon: Image(
                            width: AppWidth.w100,
                            image: AssetImage(
                              _icon,
                            ),
                            color: ColorsManager.accentColor,
                          )),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
