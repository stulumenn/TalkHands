import 'package:talkhands/features/controllers.onboarding/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:talkhands/data/theme/custom_themes/text_theme.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(image: "lib/data/assets/images/communicating-with-sign-language-free-vector.jpg", title: "Welcome To The World Of Languages", subTitle: "This app will help you to communicate without any drawbacks."),
              OnBoardingPage(image: "lib/data/assets/images/hearing-disability-concept-free-vector.jpg", title: "This app is designed for sign language", subTitle: "By just recording yourself you can communicate easily,"),
              OnBoardingPage(image: "lib/data/assets/images/sign-language-tutor-isolated-cartoon-600nw-2248378847.jpg.webp", title: "Come on, Let's start!", subTitle: "Click button to continue."),
            ],
          ),
          const OnBoardingSkip(),
          const OnBoardingNextButton()
        ],
      )
    );
  }
}

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 24.0,
      bottom: kBottomNavigationBarHeight,
      child: ElevatedButton(
          onPressed: () => OnBoardingController.instance.nextPage(),
          style: ElevatedButton.styleFrom(shape: const CircleBorder(), backgroundColor: Colors.white54),
          child: const Icon(Iconsax.arrow_right_3_copy)),
    );
  }
}

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(top: kToolbarHeight,right: 24.0,child: TextButton(onPressed: () => OnBoardingController.instance.skipPage(), child: const Text('Skip')));
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key, required this.image, required this.title, required this.subTitle,
  });

    final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const SizedBox(height: 180.0,),
          Image(image: AssetImage(image)),
          const SizedBox(height: 16.0,),
          Text(title, style: TTextTheme.lightTextTheme.headlineMedium, textAlign: TextAlign.center),
          const SizedBox(height: 16.0,),
          Text(subTitle, style: TTextTheme.lightTextTheme.bodyMedium, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
