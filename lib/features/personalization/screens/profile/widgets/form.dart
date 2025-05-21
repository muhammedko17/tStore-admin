import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_utils/t_utils.dart';

import '../../../controllers/user_controller.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TTextWithIcon(text: 'Profile Details', icon: Iconsax.user),
        SizedBox(height: TSizes().spaceBtwSections),

        // First and Last Name
        Form(
          key: controller.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.firstNameController,
                decoration: const InputDecoration(
                  hintText: 'First Name',
                  label: Text('First Name'),
                  prefixIcon: Icon(Iconsax.user),
                ),
                validator: (value) => TValidator.validateEmptyText('First Name', value),
              ),

              SizedBox(height: TSizes().spaceBtwInputFields),

              TextFormField(
                controller: controller.lastNameController,
                decoration: const InputDecoration(
                  hintText: 'Last Name',
                  label: Text('Last Name'),
                  prefixIcon: Icon(Iconsax.user),
                ),
                validator: (value) => TValidator.validateEmptyText('Last Name', value),
              ),

              SizedBox(height: TSizes().spaceBtwInputFields),

              // Email and Phone
              TextFormField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                    hintText: 'Email', label: Text('Email'), prefixIcon: Icon(Iconsax.forward), enabled: false),
              ),

              SizedBox(height: TSizes().spaceBtwItems),

              // Last Name
              TextFormField(
                controller: controller.phoneController,
                decoration: const InputDecoration(
                  hintText: 'Phone Number',
                  label: Text('Phone Number'),
                  prefixIcon: Icon(Iconsax.mobile),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: TSizes().spaceBtwSections),

        SizedBox(
          width: double.infinity,
          child: Obx(
            () => ElevatedButton(
              onPressed: () => controller.loading.value ? () {} : controller.updateUserInformation(),
              child: controller.loading.value
                  ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                  : const Text('Update Profile'),
            ),
          ),
        ),
      ],
    );
  }
}
