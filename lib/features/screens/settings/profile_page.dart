import 'package:talkhands/data/repositories/authentication_repository.dart';
import 'package:talkhands/features/controllers.onboarding/login_controller.dart';
import 'package:talkhands/features/screens/settings/change_name.dart';
import 'package:talkhands/features/screens/settings/re_authenticate_user_login_form.dart';
import 'package:talkhands/data/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../signup/appbar.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const Image(image: AssetImage("assets/images/woman.png"), width: 55),
                    TextButton(onPressed: () {}, child: const Text("Change Profile Picture"))
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              const Divider(),
              const SizedBox(height: 16.0),
              const Text("Profile Information"),
              const SizedBox(height: 16.0),

              TProfileMenu(title: "Name", value: controller.user.value.fullName, onPressed: () => Get.to(const ChangeName())),
              TProfileMenu(title: "Username", value: controller.user.value.username, onPressed: () {}),

              const SizedBox(height: 16.0),
              const Divider(),
              const SizedBox(height: 16.0),
              const Text("Personal Information"),
              const SizedBox(height: 16.0),

              TProfileMenu(title: "User ID", value: controller.user.value.id, icon: Iconsax.copy_copy, onPressed: () {
                Clipboard.setData(ClipboardData(text: controller.user.value.id));
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User ID copied to clipboard')));
              }),
              TProfileMenu(title: "E-mail", value: controller.user.value.email, onPressed: () {}),
              TProfileMenu(title: "Phone Number", value: controller.user.value.phoneNumber, onPressed: () {}),
              TProfileMenu(title: "Gender", value: "Female", onPressed: () {}),
              TProfileMenu(title: "Date of Birth", value: "01.01.2002", onPressed: () {}),
              const SizedBox(height: 16.0),
              const Divider(),
              const SizedBox(height: 16.0),

              Center(
                child: TextButton(
                  onPressed: () => Get.to(() => const ReAuthLoginForm()),
                  child: const Text("Delete Account", style: TextStyle(color: Colors.red)),
                ),
              ),

              Center(
                child: ElevatedButton(
                  onPressed: () => AuthenticationRepository.instance.logout(),
                  child: const Text("Logout"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class TProfileMenu extends StatelessWidget {
  const TProfileMenu({
    super.key,
    required this.onPressed,
    required this.title,
    required this.value,
    this.icon = Iconsax.arrow_right_3_copy,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Expanded(flex: 3, child: Text(title, style: TTextTheme.lightTextTheme.bodySmall, overflow: TextOverflow.ellipsis,)),
            Expanded(flex: 5, child: Text(value, style: TTextTheme.lightTextTheme.bodyMedium, overflow: TextOverflow.ellipsis,)),
            Expanded (child: Icon(icon, size: 18))
          ],
        ),
      ),

    );
  }
}
