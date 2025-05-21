import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_utils/common/widgets/chips/animated_icon_switch.dart';
import 'package:t_utils/common/widgets/containers/t_container.dart';
import 'package:t_utils/common/widgets/texts/text_with_icon.dart';
import 'package:t_utils/utils/constants/sizes.dart';

import '../../../controllers/settings_controller.dart';

class PointBaseSettings extends StatelessWidget {
  final SettingsController controller;

  const PointBaseSettings({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TContainer(
      child: Obx(
        () => Column(
          children: [
            /// **Toggle Switch**
            Row(
              children: [

                Expanded(child: TTextWithIcon(text: 'Enable Points System', icon: Iconsax.discount_shape)),
                TIconToggleSwitch(
                  options: [true, false],
                  icons: [Icons.circle, Icons.circle_outlined],
                  current: controller.isPointBaseEnabled.value,
                  onChanged: controller.togglePointBaseSettings,
                ),
              ],
            ),
      
            /// **Input Fields**
            if (controller.isPointBaseEnabled.value) ...[
              SizedBox(height: TSizes().spaceBtwSections),
              // CustomTextField(
              //     controller: controller.purchasePointsController,
              //     label: 'Points per Dollar Spent',
              //     icon: Iconsax.shopping_bag),
              // CustomTextField(
              //     controller: controller.pointsToDollarController,
              //     label: 'Points to Dollar Conversion',
              //     icon: Iconsax.money_recive),
              // CustomTextField(
              //     controller: controller.ratingPointsController, label: 'Points per Rating', icon: Iconsax.star),
              // CustomTextField(
              //     controller: controller.reviewPointsController, label: 'Points per Review', icon: Iconsax.text_block),

              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.purchasePointsController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Points per Dollar Spent',
                            hintText: 'Enter points awarded for each dollar spent on purchases',
                            helperText: 'How many points the customer earns for every dollar spent. Example: 10 points per \$1.',
                            helperMaxLines: 4,
                            prefixIcon: Icon(CupertinoIcons.money_rubl_circle),
                          ),
                        ),
                      ),
                      SizedBox(width: TSizes().spaceBtwItems),
                      Expanded(
                        child: TextFormField(
                          controller: controller.pointsToDollarController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Points to Dollar Conversion',
                            hintText: 'Enter points required to convert to 1\$ dollar',
                            helperText: 'How many points are needed to redeem 1 dollar. Example: 100 points = \$1.',
                            helperMaxLines: 4,
                            prefixIcon: Icon(CupertinoIcons.money_dollar_circle),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: TSizes().spaceBtwItems),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.ratingPointsController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Points per Rating',
                            hintText: 'Enter points for each rating',
                            helperText: 'How many points the customer earns for each rating they give. Example: 5 points per rating.',
                            helperMaxLines: 4,
                            prefixIcon: Icon(Iconsax.star),
                          ),
                        ),
                      ),
                      SizedBox(width: TSizes().spaceBtwItems),
                      Expanded(
                        child: TextFormField(
                          controller: controller.reviewPointsController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Points per Review',
                            hintText: 'Enter points for each review',
                            helperText: 'How many points the customer earns for each review they write. Example: 20 points per review.',
                            helperMaxLines: 4,
                            prefixIcon: Icon(Iconsax.text_block),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }
}
