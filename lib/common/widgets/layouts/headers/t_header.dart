import 'package:cwt_ecommerce_admin_panel/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_utils/common/widgets/layouts/headers/header.dart';
import 'package:t_utils/utils/device/device_utility.dart';

import '../../../../features/personalization/controllers/user_controller.dart';

class THeader extends StatelessWidget implements PreferredSizeWidget {
  const THeader({
    super.key,
    required this.scaffoldKey,
  });

  /// GlobalKey to access the Scaffold state for mobile drawer management.
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Obx(
          () =>
          TAdminHeader(
            scaffoldKey: scaffoldKey,
            showNotificationIcon: false,
            loading: controller.loading.value,
            profileEmail: controller.user.value.email,
            profileName: controller.user.value.fullName,
            profileImage: controller.user.value.profilePicture,
            profileOnTap: () => Get.toNamed(TRoutes.profile),
            onOrderPressed: () => Get.toNamed(TRoutes.orders),
            onSettingsPressed: () => Get.toNamed(TRoutes.settings),
          ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight() + 15);
}
