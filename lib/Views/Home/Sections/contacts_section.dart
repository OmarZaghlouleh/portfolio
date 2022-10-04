import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:portfolio/Data%20Managers/fonts_manager.dart';
import 'package:portfolio/Data%20Managers/values_manager.dart';
import 'package:portfolio/View%20Models/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ContactSection extends StatelessWidget {
  ContactSection({super.key});

  final GlobalKey _contactVisibiltyKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: VisibilityDetector(
          key: _contactVisibiltyKey,
          onVisibilityChanged: (info) {
            if (int.tryParse(info.visibleFraction.toString()) ==
                    AppFractions.f1 ||
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
                    url: e.url,
                    icon: Image.asset(e.assetPath),
                    context: context))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _getIconRowItem(
      {required String url,
      required Widget icon,
      required BuildContext context}) {
    return IconButton(
        onPressed: () {
          try {
            launchUrl(Uri.parse(url));
          } catch (e) {}
        },
        icon: icon);
  }
}
