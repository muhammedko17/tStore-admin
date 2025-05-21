import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_utils/t_utils.dart';

import '../../../../controllers/customer_detail_controller.dart';
import '../../../../models/address_model.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailController.instance;
    WidgetsBinding.instance.addPostFrameCallback((_) async => await controller.getCustomerAddresses());

    return Obx(
      () {
        if (controller.addressesLoading.value) return const TAnimationLoader();

        AddressModel selectedAddress = AddressModel.empty();
        if (controller.customer.value.addresses != null) {
          if (controller.customer.value.addresses!.isNotEmpty) {
            selectedAddress = controller.customer.value.addresses!.firstWhere((element) => element.selectedAddress);
          }
        }

        return TContainer(
          padding: EdgeInsets.all(TSizes().defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TTextWithIcon(text: 'Shipping Address', icon: Iconsax.location),
              SizedBox(height: TSizes().spaceBtwSections),

              // Meta Data
              Row(
                children: [
                  SizedBox(width: 120, child: Text('Name')),
                  const Text(':'),
                  SizedBox(width: TSizes().spaceBtwItems / 2),
                  Expanded(child: Text(selectedAddress.name, style: Theme.of(context).textTheme.titleMedium)),
                ],
              ),
              SizedBox(height: TSizes().spaceBtwItems),
              Row(
                children: [
                  SizedBox(width: 120, child: Text('Country')),
                  const Text(':'),
                  SizedBox(width: TSizes().spaceBtwItems / 2),
                  Expanded(child: Text(selectedAddress.country, style: Theme.of(context).textTheme.titleMedium)),
                ],
              ),
              SizedBox(height: TSizes().spaceBtwItems),
              Row(
                children: [
                  SizedBox(width: 120, child: Text('Phone Number')),
                  const Text(':'),
                  SizedBox(width: TSizes().spaceBtwItems / 2),
                  Expanded(child: Text(selectedAddress.phoneNumber, style: Theme.of(context).textTheme.titleMedium)),
                ],
              ),
              SizedBox(height: TSizes().spaceBtwItems),
              Row(
                children: [
                  SizedBox(width: 120, child: Text('Address')),
                  const Text(':'),
                  SizedBox(width: TSizes().spaceBtwItems / 2),
                  Expanded(child: Text(selectedAddress.id.isNotEmpty ? selectedAddress.toString() : '', style: Theme.of(context).textTheme.titleMedium)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
