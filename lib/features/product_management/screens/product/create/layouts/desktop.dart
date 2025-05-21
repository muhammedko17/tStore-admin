import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:t_utils/t_utils.dart';

import '../../../../../../routes/routes.dart';
import '../../edit/widgets/tags_widget.dart';
import '../widgets/additional_images.dart';
import '../widgets/attributes_widget.dart';
import '../widgets/bottom_navigation_widget.dart';
import '../widgets/brand_widget.dart';
import '../widgets/categories_widget.dart';
import '../widgets/product_type_widget.dart';
import '../widgets/stock_pricing_widget.dart';
import '../widgets/thumbnail_widget.dart';
import '../widgets/title_description.dart';
import '../widgets/variations_widget.dart';
import '../widgets/visibility_widget.dart';

class DesktopScreen extends StatelessWidget {
  const DesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const ProductBottomNavigationButtons(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: TSizes().defaultSpace,
            left: TSizes().defaultSpace,
            right: TSizes().defaultSpace,
            bottom: TSizes().defaultSpace * 2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: 'Create Product',
                breadcrumbItems: [TRoutes.products, 'Create Product'],
              ),
              SizedBox(height: TSizes().spaceBtwSections),

              // Create Product
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: TDeviceUtils.isTabletScreen(context) ? 2 : 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Basic Information
                        const ProductTitleAndDescription(),
                        SizedBox(height: TSizes().spaceBtwSections),

                        // Stock & Pricing
                        TContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Heading
                              const TTextWithIcon(text: 'Product Configuration & Management', icon: Iconsax.setting),
                              Divider(color: TColors().grey),
                              SizedBox(height: TSizes().spaceBtwItems),

                              // Product Type
                              const ProductTypeWidget(),
                              SizedBox(height: TSizes().spaceBtwInputFields),

                              // Stock
                              const ProductStockAndPricing(),
                              SizedBox(height: TSizes().spaceBtwSections),

                              // Attributes
                              ProductAttributes(),
                              SizedBox(height: TSizes().spaceBtwSections),
                            ],
                          ),
                        ),
                        SizedBox(height: TSizes().spaceBtwSections),

                        // Variations
                        const ProductVariations(),
                      ],
                    ),
                  ),
                  SizedBox(width: TSizes().spaceBtwSections),

                  // Sidebar
                  Expanded(
                    child: Column(
                      children: [
                        // Product Visibility
                        ProductVisibilityWidget(),
                        SizedBox(height: TSizes().spaceBtwSections),

                        // Product Thumbnail
                        ProductThumbnailImage(),
                        SizedBox(height: TSizes().spaceBtwSections),

                        // Product Images
                        ProductAdditionalImages(),
                        SizedBox(height: TSizes().spaceBtwSections),

                        // Product Brand
                        ProductBrand(),
                        SizedBox(height: TSizes().spaceBtwSections),

                        // Product Categories
                        ProductCategories(),
                        SizedBox(height: TSizes().spaceBtwSections),

                        // Product Brand
                        ProductTag(),
                        SizedBox(height: TSizes().spaceBtwSections),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
