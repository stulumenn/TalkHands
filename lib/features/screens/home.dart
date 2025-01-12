import 'package:talkhands/features/controllers.onboarding/login_controller.dart';
import 'package:talkhands/features/screens/settings/profile_page.dart';
import 'package:talkhands/features/screens/settings/settings.dart';
import 'package:talkhands/features/screens/signup/appbar.dart';
import 'package:talkhands/data/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: TCustomCurvedEdges(),
              child: Container(
                color: Colors.blue,
                padding: const EdgeInsets.only(top: 30),
                child: SizedBox(
                  height: 170,
                  child: Stack(
                    children: [
                      Positioned(top: -140,right: -250, child: TCircularContainer(backgroundColor: Colors.blueGrey.withOpacity(0.2))),
                      Positioned(top: 100,right: -300, child: TCircularContainer(backgroundColor: Colors.blueGrey.withOpacity(0.1))),
                      TAppBar(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => Get.to(() => const ProfilePage()),
                                  child: const Image(image: AssetImage("lib/data/assets/images/woman.png"), width: 55),
                                ),
                                const SizedBox(width: 15),
                                Column(
                                  children: [
                                    Text("Hello", style: TTextTheme.lightTextTheme.headlineMedium!.apply(color: Colors.white)),
                                    Text(controller.user.value.firstName, style: TTextTheme.lightTextTheme.headlineSmall!.apply(color: Colors.white)),
                                  ],
                                ),
                                const SizedBox(width: 160,),
                                IconButton(onPressed: () => Get.to(() => const SettingsScreen()), icon: const Icon(Iconsax.setting_copy, color: Colors.white, size: 35,)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 200),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(60),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.blueGrey,
                    elevation: 8
                  ),
                  child: const Icon(Iconsax.play_copy, color: Colors.white, size: 50),
                ),
                const SizedBox(height: 40),
                Text("Click to Start Recording", style: TTextTheme.lightTextTheme.headlineSmall)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TCircularContainer extends StatelessWidget {
  const TCircularContainer({
    super.key,
    this.child,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
    this.padding = 0,
    this.backgroundColor = Colors.white,
  });

  final double? width;
  final double? height;
  final double radius;
  final double padding;
  final Widget? child;
  final Color backgroundColor;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}

class TCustomCurvedEdges extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    final firstCurve = Offset(0, size.height - 20);
    final lastCurve = Offset(30, size.height - 20);
    path.quadraticBezierTo(firstCurve.dx, firstCurve.dy, lastCurve.dx, lastCurve.dy);

    final secondFirstCurve = Offset(0, size.height - 20);
    final secondLastCurve = Offset(size.width-30, size.height - 20);
    path.quadraticBezierTo(secondFirstCurve.dx, secondFirstCurve.dy, secondLastCurve.dx, secondLastCurve.dy);

    final thirdFirstCurve = Offset(size.width, size.height - 20);
    final thirdLastCurve = Offset(size.width, size.height);
    path.quadraticBezierTo(thirdFirstCurve.dx, thirdFirstCurve.dy, thirdLastCurve.dx, thirdLastCurve.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}