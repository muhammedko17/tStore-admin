import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_utils/t_utils.dart';

import '../../../../../../utils/constants/image_strings.dart';
import '../../../../controllers/customer_detail_controller.dart';
import '../table/data_table.dart';

class CustomerOrders extends StatelessWidget {
  const CustomerOrders({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailController.instance;
    return TContainer(
      padding: EdgeInsets.all(TSizes().defaultSpace),
      child: Column(
        children: [
          /// Header
          Obx(
            () {
              final totalAmount = controller.allCustomerOrders.fold<double>(0, (previous, order) => previous + order.calculateGrandTotal());
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: TTextWithIcon(text: 'Orders', icon: Iconsax.shop)),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: 'Total Spent '),
                        TextSpan(
                          text: '\$${totalAmount.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors().primary),
                        ),
                        TextSpan(
                          text: ' on ${controller.allCustomerOrders.length} Orders',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          SizedBox(height: TSizes().spaceBtwSections),
          TextFormField(
            controller: controller.searchTextController,
            onChanged: (query) => controller.searchQuery(query),
            decoration: const InputDecoration(hintText: 'Search Orders', prefixIcon: Icon(Iconsax.search_normal)),
          ),

          /// Body
          Obx(
            () {
              if (controller.ordersLoading.value) return const TAnimationLoader();
              if (controller.allCustomerOrders.isEmpty) {
                return TAnimationLoader(message: Text('No Orders Found'), animation: TImages.dashboardIllustration);
              }
              return const CustomerOrderTable();
            },
          ),
        ],
      ),
    );
  }
}
