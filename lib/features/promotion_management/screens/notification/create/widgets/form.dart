import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:t_utils/t_utils.dart';

import '../../../../controllers/notification/create_notification_controller.dart';

class CreateNotificationForm extends StatelessWidget {
  const CreateNotificationForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateNotificationController());
    return TFormContainer(
      isLoading: controller.isLoading.value,
      padding: EdgeInsets.all(TSizes().defaultSpace),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Heading
            SizedBox(height: TSizes().sm),
            const TTextWithIcon(text: 'Create new Notification', icon: Iconsax.notification),
            SizedBox(height: TSizes().spaceBtwSections),

            // Text Field
            TextFormField(
              controller: controller.title,
              validator: (value) => TValidator.validateEmptyText('Notification title', value),
              decoration: const InputDecoration(labelText: 'Notification title', prefixIcon: Icon(Iconsax.subtitle)),
            ),
            SizedBox(height: TSizes().spaceBtwInputFields),

            TextFormField(
              controller: controller.description,
              validator: (value) => TValidator.validateEmptyText('Notification description', value),
              decoration: const InputDecoration(labelText: 'Notification description', prefixIcon: Icon(Iconsax.note)),
            ),

            SizedBox(height: TSizes().spaceBtwInputFields * 2),

            Obx(
              () => AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(onPressed: () => controller.createNotification(), child: const Text('Create')),
                      ),
              ),
            ),
            SizedBox(height: TSizes().spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
