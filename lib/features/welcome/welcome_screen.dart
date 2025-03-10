import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sampark_app/config/colors.dart';
import 'package:sampark_app/config/images.dart';
import 'package:sampark_app/widgets/welcome_heading.dart';
import 'package:slide_to_act/slide_to_act.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: 30),
              WelcomeHeading(),
              SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AssetsImage.boyPic),
                  SvgPicture.asset(AssetsImage.connectSVG),
                  Image.asset(AssetsImage.girlPic)
                ],
              ),
              SizedBox(height: 30),
              Text(
                "Now You Are",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                "Connected",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: dSecondaryColor,
                    ),
              ),
              SizedBox(height: 10),
              Text(
                "Perfect Solution to connect with Anyone and Anywhere Easily",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              SizedBox(height: 70),
              SlideAction(
                onSubmit: () {
                  Get.offAllNamed('/auth-screen');
                  return;
                },
                sliderButtonIcon: SvgPicture.asset(
                  AssetsImage.plugSVG,
                  width: 20,
                ),
                submittedIcon: SvgPicture.asset(
                  AssetsImage.connectSVG,
                  width: 20,
                ),
                text: 'Slide to Login',
                textStyle: Theme.of(context).textTheme.labelLarge,
                animationDuration: Duration(milliseconds: 200),
                innerColor: Theme.of(context).colorScheme.primary,
                outerColor: Theme.of(context).colorScheme.primaryContainer,
              )
            ],
          ),
        ),
      ),
    );
  }
}
