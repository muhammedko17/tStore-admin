import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../utils/constants/enums.dart';


import '../../../../controllers/product/create_product_controller.dart';


import 'package:t_utils/t_utils.dart';

class ProductStockAndPricing extends StatelessWidget {
  const ProductStockAndPricing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = CreateProductController.instance;

    return Obx(
      () => controller.productType.value == ProductType.simple
          ? Form(
              key: controller.stockPriceFormKey,
              child: Row(
                children: [
                  // Stock
                  Expanded(
                    child: TextFormField(
                      controller: controller.stock,
                      decoration: const InputDecoration(
                          labelText: 'Stock', hintText: 'Add Stock, only numbers are allowed', prefixIcon: Icon(Iconsax.unlimited)),
                      validator: (value) => TValidator.validateEmptyText('Stock', value),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                  SizedBox(width: TSizes().spaceBtwItems),
                  // SKU
                  Expanded(
                    child: TextFormField(
                      controller: controller.sku,
                      decoration:
                          const InputDecoration(labelText: 'SKU', hintText: 'Add Stock Keeping Unit', prefixIcon: Icon(Iconsax.note_add)),
                    ),
                  ),
                  SizedBox(width: TSizes().spaceBtwItems),
                  // Price
                  Expanded(
                    child: TextFormField(
                      controller: controller.price,
                      decoration: const InputDecoration(
                          labelText: 'Price', hintText: 'Price with up-to 2 decimals', prefixIcon: Icon(Iconsax.money_send)),
                      validator: (value) => TValidator.validateEmptyText('Price', value),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                      ],
                    ),
                  ),
                  SizedBox(width: TSizes().spaceBtwItems),

                  // Sale Price
                  Expanded(
                    child: TextFormField(
                      controller: controller.salePrice,
                      decoration: const InputDecoration(
                        labelText: 'Discounted Price',
                        hintText: 'Price with up-to 2 decimals',
                        prefixIcon: Icon(Iconsax.discount_circle),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : SizedBox.shrink(),
    );
  }
}
