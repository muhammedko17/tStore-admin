import 'package:flutter/material.dart';

import 'package:t_utils/t_utils.dart';

import '../../../../controllers/product/edit_product_controller.dart';

class ProductBottomNavigationButtons extends StatelessWidget {
  const ProductBottomNavigationButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Discard button
          OutlinedButton(
            onPressed: () {
              // Add functionality to discard changes if needed
            },
            child: const Text('Discard'),
          ),
          SizedBox(width: TSizes().spaceBtwItems / 2),

          // Save Changes button
          SizedBox(
            width: 160,
            child: ElevatedButton(
              onPressed: () => EditProductController.instance.updateProduct(),
              child: const Text('Save Changes'),
            ),
          ),
        ],
      ),
    );
  }
}
