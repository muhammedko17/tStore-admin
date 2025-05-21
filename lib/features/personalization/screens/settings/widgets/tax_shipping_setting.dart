import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_utils/common/widgets/chips/animated_icon_switch.dart';
import 'package:t_utils/common/widgets/containers/t_container.dart';
import 'package:t_utils/common/widgets/texts/text_with_icon.dart';
import 'package:t_utils/utils/constants/sizes.dart';

import '../../../controllers/settings_controller.dart';

class TaxShippingSettings extends StatelessWidget {
  final SettingsController controller;

  const TaxShippingSettings({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TContainer(
      child: Obx(
        () => Column(
          children: [
            /// **Toggle Switch**
            Row(
              children: [
                Expanded(child: TTextWithIcon(text: 'Enable Tax & Shipping', icon: Iconsax.tag)),
                TIconToggleSwitch(
                  options: [true, false],
                  icons: [Icons.circle, Icons.circle_outlined],
                  current: controller.isTaxShippingEnabled.value,
                  onChanged: controller.toggleTaxShippingSettings,
                ),
              ],
            ),

            /// **Input Fields**
            if (controller.isTaxShippingEnabled.value) ...[
              SizedBox(height: TSizes().spaceBtwSections),
              // CustomTextField(controller: controller.taxController, label: 'Tax Rate (%)', icon: Iconsax.tag),
              // CustomTextField(
              //     controller: controller.shippingController, label: 'Shipping Cost (\$)', icon: Iconsax.ship),
              // CustomTextField(
              //     controller: controller.freeShippingThresholdController,
              //     label: 'Free Shipping Threshold (\$)',
              //     icon: Iconsax.ship),
              TextFormField(
                controller: controller.taxController,
                decoration: const InputDecoration(
                  labelText: 'Tax Rate (%) [e.g., 5% = 0.05]',
                  hintText: 'Enter the tax rate as a decimal (e.g., 5% = 0.05)',
                  helperMaxLines: 3,
                  helperText: 'The tax rate to apply. Example: 0.05 for 5%.',
                  prefixIcon: Icon(Iconsax.tag),
                ),
              ),
              SizedBox(height: TSizes().spaceBtwItems),
              TextFormField(
                controller: controller.shippingController,
                decoration: const InputDecoration(
                  hintText: 'Shipping Cost',
                  label: Text('Shipping Cost (\$)'),
                  helperText: 'The shipping cost applied to the order. Example: \$10.',
                  helperMaxLines: 3,
                  prefixIcon: Icon(Iconsax.ship),
                ),
              ),
              SizedBox(height: TSizes().spaceBtwItems),
              TextFormField(
                controller: controller.freeShippingThresholdController,
                decoration: const InputDecoration(
                  hintText: 'Free Shipping After (\$)',
                  label: Text('Free Shipping Threshold (\$)'),
                  helperText: 'The minimum order amount for free shipping. Example: \$50.',
                  helperMaxLines: 3,
                  prefixIcon: Icon(Iconsax.ship),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
