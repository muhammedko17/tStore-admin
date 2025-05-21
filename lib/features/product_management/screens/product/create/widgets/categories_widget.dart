import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_utils/t_utils.dart';

import '../../../../../data_management/controllers/category/category_controller.dart';
import '../../../../controllers/product/create_product_controller.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Get instance of the CategoryController
    final categoriesController = Get.put(CategoryController());

    // Fetch categories if the list is empty
    if (categoriesController.allItems.isEmpty) {
      categoriesController.fetchItems();
    }

    return TContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories label
          const TTextWithIcon(text: 'Product Categories', icon: Iconsax.category_2),
          SizedBox(height: TSizes().spaceBtwItems),
          Obx(() => CreateProductController.instance.selectedCategories.isNotEmpty
              ? Wrap(
                  spacing: TSizes().sm,
                  runSpacing: TSizes().sm,
                  children: CreateProductController.instance.selectedCategories
                      // .where((category) => category.parentId.isEmpty)
                      .map((parentCategory) {
                    return Chip(
                      backgroundColor: Colors.white,
                      label: Text(parentCategory.name),
                      onDeleted: () => CreateProductController.instance.selectedCategories.remove(parentCategory),
                      deleteIcon: const Icon(CupertinoIcons.clear),
                    );
                  }).toList(),
                )
              : const Align(alignment: Alignment.center, child: Text('There are no Categories Selected'))),
          SizedBox(height: TSizes().spaceBtwSections),

          // Button to Add Categories
          Obx(
            () => categoriesController.isLoading.value
                ? const TShimmer(width: double.infinity, height: 50)
                : Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton(onPressed: () => _chooseCategories(context), child: const Text('Add Categories')),
                    ),
                  ),
          ),
          SizedBox(height: TSizes().defaultSpace),
        ],
      ),
    );
  }

  void _chooseCategories(BuildContext context) {
    final categoryController = CategoryController.instance;
    TDialogs.defaultDialog(
      context: context,
      title: 'Choose Categories',
      confirmText: 'Done',
      cancelText: 'Close',
      onConfirm: () => Get.back(),
      onCancel: () => Get.back(),
      content: Obx(
        () {
          if (categoryController.isLoading.value) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TShimmer(width: double.infinity, height: 30, radius: 55),
                SizedBox(height: TSizes().spaceBtwItems / 2),
                TShimmer(width: double.infinity, height: 30, radius: 55),
                SizedBox(height: TSizes().spaceBtwItems / 2),
                TShimmer(width: double.infinity, height: 30, radius: 55),
              ],
            );
          }

          if (categoryController.allItems.isEmpty) return Center(child: Text('No categories found.'));

          return Wrap(
            spacing: TSizes().md,
            direction: Axis.vertical,
            children: categoryController.allItems
                // Step 1: Filter parent categories (where parentId is empty or null)
                .where((category) => category.parentId.isEmpty)
                .map((parentCategory) {
              // Step 2: For each parent category, create a widget with its children
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Parent category chip
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.line_horizontal_3_decrease, size: 14, color: TColors().primary),
                      SizedBox(width: TSizes().spaceBtwItems / 2),
                      TChoiceChip(
                        text: parentCategory.name,
                        selected: CreateProductController.instance.selectedCategories.contains(parentCategory),
                        onSelected: (value) => CreateProductController.instance.toggleCategories(parentCategory),
                      ),
                    ],
                  ),
                  // Step 3: Find child categories (where parentId matches the parent's id)
                  if (categoryController.allItems.any((childCategory) => childCategory.parentId == parentCategory.id))
                    Padding(
                      padding: EdgeInsets.only(left: TSizes().lg, top: TSizes().sm),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(CupertinoIcons.circle, size: 12),
                          SizedBox(width: TSizes().spaceBtwItems / 2),
                          Wrap(
                            spacing: TSizes().sm,
                            children: categoryController.allItems
                                .where((childCategory) => childCategory.parentId == parentCategory.id)
                                .map((childCategory) => TChoiceChip(
                                      text: childCategory.name,
                                      selected: CreateProductController.instance.selectedCategories.contains(childCategory),
                                      onSelected: (value) => CreateProductController.instance.toggleCategories(childCategory),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
    // Get.defaultDialog(
    //   title: 'Choose Categories',
    //   cancel: OutlinedButton(onPressed: () => Get.back(), child: const Text('Close')),
    //   confirm: SizedBox(width: 120, child: ElevatedButton(onPressed: () => Get.back(), child: const Text('Done'))),
    //   content: TContainer(
    //     width: double.infinity,
    //     backgroundColor: Colors.transparent,
    //     child: Obx(
    //       () => categoryController.isLoading.value
    //           ? Column(
    //               children: [
    //                 TShimmer(width: double.infinity, height: 30, radius: 55),
    //                 SizedBox(height: TSizes().spaceBtwItems / 2),
    //                 TShimmer(width: double.infinity, height: 30, radius: 55),
    //                 SizedBox(height: TSizes().spaceBtwItems / 2),
    //                 TShimmer(width: double.infinity, height: 30, radius: 55),
    //               ],
    //             )
    //           : Wrap(
    //               spacing: TSizes().md,
    //               direction: Axis.vertical,
    //               children: categoryController.allItems
    //                   // Step 1: Filter parent categories (where parentId is empty or null)
    //                   .where((category) => category.parentId.isEmpty)
    //                   .map((parentCategory) {
    //                 // Step 2: For each parent category, create a widget with its children
    //                 return Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     // Parent category chip
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         Icon(CupertinoIcons.line_horizontal_3_decrease, size: 14, color: TColors().primary),
    //                         SizedBox(width: TSizes().spaceBtwItems / 2),
    //                         TChoiceChip(
    //                           text: parentCategory.name,
    //                           selected: CreateProductController.instance.selectedCategories.contains(parentCategory),
    //                           onSelected: (value) => CreateProductController.instance.toggleCategories(parentCategory),
    //                         ),
    //                       ],
    //                     ),
    //                     // Step 3: Find child categories (where parentId matches the parent's id)
    //                     if (categoryController.allItems.any((childCategory) => childCategory.parentId == parentCategory.id))
    //                       Padding(
    //                         padding: EdgeInsets.only(left: TSizes().lg, top: TSizes().sm),
    //                         child: Row(
    //                           crossAxisAlignment: CrossAxisAlignment.center,
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             const Icon(CupertinoIcons.circle, size: 12),
    //                             SizedBox(width: TSizes().spaceBtwItems / 2),
    //                             Wrap(
    //                               spacing: TSizes().sm,
    //                               children: categoryController.allItems
    //                                   .where((childCategory) => childCategory.parentId == parentCategory.id)
    //                                   .map((childCategory) => TChoiceChip(
    //                                         text: childCategory.name,
    //                                         selected: CreateProductController.instance.selectedCategories.contains(childCategory),
    //                                         onSelected: (value) => CreateProductController.instance.toggleCategories(childCategory),
    //                                       ))
    //                                   .toList(),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                   ],
    //                 );
    //               }).toList(),
    //             ),
    //     ),
    //   ),
    // );
  }
}
