import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:t_utils/t_utils.dart';

import '../../../../controllers/product/edit_product_controller.dart';

class ProductTitleAndDescription extends StatelessWidget {
  const ProductTitleAndDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProductController());

    return TContainer(
      child: Form(
        key: controller.titleDescriptionFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Information Text
            const TTextWithIcon(text: 'Basic Information', icon: Iconsax.receipt_edit),
            SizedBox(height: TSizes().spaceBtwItems),

            // Product Title Input Field
            TextFormField(
              controller: controller.title,
              validator: (value) => TValidator.validateEmptyText('Product Title', value),
              decoration: const InputDecoration(
                labelText: 'Product Title',
                prefixIcon: Icon(Iconsax.text),
              ),
            ),
            SizedBox(height: TSizes().spaceBtwInputFields),

            // Product Description Input Field
            TTextEditor(controller: controller.productDescriptionController),
          ],
        ),
      ),
    );
  }
}
