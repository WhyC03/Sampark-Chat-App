import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sampark_app/config/colors.dart';
import 'package:sampark_app/config/images.dart';

class WelcomeHeading extends StatelessWidget {
  const WelcomeHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AssetsImage.appIconSVG),
          ],
        ),
        SizedBox(height: 20),
        Text(
          "SAMPARK",
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(color: dSecondaryColor),
        ),
      ],
    );
  }
}
