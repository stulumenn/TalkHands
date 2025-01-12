import 'package:talkhands/features/screens/signup/appbar.dart';
import 'package:flutter/material.dart';
import 'package:talkhands/features/screens/home.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:talkhands/data/theme/custom_themes/text_theme.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: TCustomCurvedEdges(),
              child: Container(
                color: Colors.blue,
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 190,
                  child: Stack(
                    children: [
                      TAppBar(title: Center(child: Text("Account", style: TTextTheme.lightTextTheme.headlineMedium!.apply(color: Colors.white),),)),
                      Positioned(left: 24.0, bottom: kBottomNavigationBarHeight, child: IconButton(onPressed: () => Get.to(const HomeScreen()), icon: const Icon(Iconsax.arrow_left_2_copy))),
                      Positioned(top: -140,right: -250, child: TCircularContainer(backgroundColor: Colors.blueGrey.withOpacity(0.2))),
                      Positioned(top: 100,right: -300, child: TCircularContainer(backgroundColor: Colors.blueGrey.withOpacity(0.1))),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Iconsax.language_circle_copy, size: 20, color: Colors.black),
                      title: const Text("English"),
                      subtitle: const Text("Change language"),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Iconsax.notification_copy, size: 20, color: Colors.black),
                      title: const Text("Notifications"),
                      subtitle: const Text("Set any kind of notifications message"),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Iconsax.security_card_copy, size: 20, color: Colors.black),
                      title: const Text("Account Privacy"),
                      subtitle: const Text("Manage data usage and connected accounts"),
                      onTap: () {},
                    ),
                    const SizedBox(height: 350,),
                    Text("Help Center", style: TTextTheme.lightTextTheme.bodyMedium!.apply(color: Colors.black.withOpacity(0.5)),),
                    const SizedBox(height: 20,),
                    Text("Frequently Asked Questions", style: TTextTheme.lightTextTheme.bodyMedium!.apply(color: Colors.black.withOpacity(0.5)))
                  ],
                ),
            )
          ],
        ),
      ),
    );
  }
}
