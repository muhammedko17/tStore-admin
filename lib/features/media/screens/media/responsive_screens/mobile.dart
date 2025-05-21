import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:t_utils/t_utils.dart';

import '../../../controllers/media_controller.dart';
import '../widgets/media_content.dart';
import '../widgets/media_uploader.dart';

class MediaMobileScreen extends StatelessWidget {
  const MediaMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: TDeviceUtils.getScreenHeight(context),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(TSizes().defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Header
                    const TBreadcrumbsWithHeading(heading: 'Media Manager', breadcrumbItems: ['Media']),
                    SizedBox(height: TSizes().spaceBtwItems),
                    SizedBox(
                      width: TSizes().buttonWidth * 1.5,
                      child: ElevatedButton.icon(
                        label: const Text('Upload Images'),
                        icon: const Icon(Iconsax.cloud_add),
                        onPressed: () => controller.showImagesUploaderSection.value = !controller.showImagesUploaderSection.value,
                      ),
                    ),
                    SizedBox(height: TSizes().spaceBtwSections),

                    /// Media
                    MediaContent(),
                  ],
                ),
              ),
            ),
          ),

          /// Upload Area
          Obx(
            () => AnimatedPositioned(
              bottom: 0,
              height: TDeviceUtils.getScreenHeight(context),
              right: controller.showImagesUploaderSection.value ? 0 : -TDeviceUtils.getScreenWidth(context),
              duration: const Duration(milliseconds: 200),
              child: const MediaUploader(isSideBar: true),
            ),
          ),
        ],
      ),
    );
  }
}
