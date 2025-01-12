import 'package:talkhands/features/controllers.onboarding/update_name_controller.dart';
import 'package:talkhands/data/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:get/get.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Use real name for easy verification. This name will appear on several pages.',
              style: TTextTheme.lightTextTheme.labelMedium,
            ),
            const SizedBox(height: 16.0),

            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: "First Name",
                      prefixIcon: Icon(Iconsax.user_copy),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  TextFormField(
                    controller: controller.lastName,
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: "Last Name",
                      prefixIcon: Icon(Iconsax.user_copy),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32.0),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateUserName(),
                child: const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
