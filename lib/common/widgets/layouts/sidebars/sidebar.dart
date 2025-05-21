import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_utils/t_utils.dart';

import '../../../../features/personalization/controllers/settings_controller.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/constants/image_strings.dart';
import 'menu/menu_item.dart';

/// Sidebar widget for navigation menu
class TSidebar extends StatelessWidget {
  const TSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: Container(
        decoration: BoxDecoration(
          color: TColors().darkBackground,
          border: Border(right: BorderSide(width: 1, color: TColors().grey)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              _logoAndName(context),
              SizedBox(height: TSizes().spaceBtwSections),

              /// Menu
              Padding(
                padding: EdgeInsets.symmetric(horizontal: TSizes().defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Section 1
                    Text(
                      'OVERVIEW & MEDIA',
                      style: Theme.of(context).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2, color: TColors().white),
                    ),
                    // Menu Items
                    const TMenuItem(route: TRoutes.dashboard, icon: Iconsax.status, itemName: 'Dashboard'),
                    const TMenuItem(route: TRoutes.media, icon: Iconsax.image, itemName: 'Media'),
                    SizedBox(height: TSizes().spaceBtwSections),

                    /// Section 2
                    Text(
                      'DATA MANAGEMENT',
                      style: Theme.of(context).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2, color: TColors().white),
                    ),
                    const TMenuItem(route: TRoutes.categories, icon: Iconsax.category_2, itemName: 'Categories'),
                    const TMenuItem(route: TRoutes.subCategories, icon: Iconsax.category5, itemName: 'Sub Categories'),
                    const TMenuItem(route: TRoutes.brands, icon: Iconsax.dcube, itemName: 'Brands'),
                    const TMenuItem(route: TRoutes.attributes, icon: Iconsax.activity, itemName: 'Attributes'),
                    const TMenuItem(route: TRoutes.units, icon: Iconsax.unlimited, itemName: 'Units'),
                    SizedBox(height: TSizes().spaceBtwSections),

                    /// Section 3
                    Text(
                      'PRODUCT MANAGEMENT',
                      style: Theme.of(context).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2, color: TColors().white),
                    ),
                    const TMenuItem(route: TRoutes.createProduct, icon: Iconsax.box_add, itemName: 'Add new product'),
                    const TMenuItem(route: TRoutes.products, icon: Iconsax.shopping_cart, itemName: 'Products'),
                    const TMenuItem(
                        route: TRoutes.recommendedProducts, icon: Iconsax.heart_circle, itemName: 'Recommended Products'),
                    const TMenuItem(route: TRoutes.customers, icon: Iconsax.profile_2user, itemName: 'Customers'),
                    const TMenuItem(route: TRoutes.orders, icon: Iconsax.box, itemName: 'Orders'),
                    const TMenuItem(route: TRoutes.reviews, icon: Iconsax.star, itemName: 'Product Reviews'),
                    SizedBox(height: TSizes().spaceBtwSections),

                    /// Section 4
                    Text(
                      'PROMOTION MANAGEMENT',
                      style: Theme.of(context).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2, color: TColors().white),
                    ),
                    const TMenuItem(route: TRoutes.banners, icon: Iconsax.picture_frame, itemName: 'Banners'),
                    // const TMenuItem(route: TRoutes.campaigns, icon: Iconsax.path, itemName: 'Campaigns'),
                    const TMenuItem(route: TRoutes.coupons, icon: Iconsax.discount_shape, itemName: 'Coupons'),
                    // const TMenuItem(route: TRoutes.notifications, icon: Iconsax.notification, itemName: 'Notifications'),
                    SizedBox(height: TSizes().spaceBtwSections),

                    Text(
                      'NOTIFICATION',
                      style: Theme.of(context).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2, color: TColors().white),
                    ),
                    const TMenuItem(route: TRoutes.notifications, icon: Iconsax.notification, itemName: 'Notifications'),
                    SizedBox(height: TSizes().spaceBtwSections),

                    // Support Management
                    Text('SUPPORT MANAGEMENT',
                        style:
                            Theme.of(context).textTheme.labelLarge!.apply(letterSpacingDelta: 1.2, color: TColors().white)),
                    // const TMenuItem(route: TRoutes.supportTickets, icon: Iconsax.message, itemName: 'Support Tickets'),
                    const TMenuItem(route: TRoutes.chats, icon: Iconsax.messages, itemName: 'Chat'),
                    SizedBox(height: TSizes().spaceBtwSections),

                    /// Section 4
                    Text(
                      'CONFIGURATIONS',
                      style: Theme.of(context).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2, color: TColors().white),
                    ),
                    const TMenuItem(route: TRoutes.profile, icon: Iconsax.discount_shape, itemName: 'Profile'),
                    const TMenuItem(route: TRoutes.settings, icon: Iconsax.picture_frame, itemName: 'App Settings'),
                    SizedBox(height: TSizes().spaceBtwSections),
                    const TMenuItem(route: 'logout', icon: Iconsax.logout, itemName: 'Logout'),
                    SizedBox(height: TSizes().defaultSpace),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logoAndName(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(TRoutes.settings),
      child: Row(
        children: [
          Obx(
            () => TImage(
              width: 60,
              height: 60,
              padding: 0,
              margin: TSizes().sm,
              backgroundColor: Colors.transparent,
              imageType: SettingsController.instance.settings.value.appLogo.isNotEmpty ? ImageType.network : ImageType.asset,
              image: SettingsController.instance.settings.value.appLogo.isNotEmpty
                  ? SettingsController.instance.settings.value.appLogo
                  : TImages.darkAppLogo,
            ),
          ),
          Expanded(
            child: Obx(
              () => Text(
                SettingsController.instance.settings.value.appName,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white, // Set text color to white
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
