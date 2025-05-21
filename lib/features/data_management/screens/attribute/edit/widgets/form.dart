import 'package:cwt_ecommerce_admin_panel/features/data_management/screens/attribute/edit/widgets/color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:t_utils/t_utils.dart';

import '../../../../controllers/attribute/edit_attribute_controller.dart';

class EditAttributeForm extends StatelessWidget {
  const EditAttributeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditAttributeController());

    return Obx(
      () => TFormContainer(
        isLoading: controller.isLoading.value,
        padding: EdgeInsets.all(TSizes().defaultSpace),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              SizedBox(height: TSizes().sm),

              /// Heading
              const TTextWithIcon(text: 'Update Attribute', icon: Iconsax.activity),
              SizedBox(height: TSizes().spaceBtwSections),

              // Name Text Field
              TextFormField(
                controller: controller.name,
                validator: (value) => TValidator.validateEmptyText('Name', value),
                decoration: const InputDecoration(
                  labelText: 'Attribute Name',
                  prefixIcon: Icon(Iconsax.category),
                  suffixIcon: Tooltip(
                    message:
                        'Specify the name of the attribute, such as \'Size\', \'Color\', or \'Material\'. This helps categorize and organize your product options effectively.',
                    child: Icon(Iconsax.info_circle, color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: TSizes().spaceBtwInputFields),

              /// Checkbox to toggle Color Field mode
              Obx(
                () => CheckboxMenuButton(
                  value: controller.isColorAttribute.value,
                  onChanged: (value) => controller.isColorAttribute.value = value ?? false,
                  trailingIcon: Tooltip(
                    message: 'If you want to add colors then choose this option to add colors.',
                    child: Icon(Iconsax.info_circle, color: Colors.grey),
                  ),
                  child: const Text('Is this a Color Field?'),
                ),
              ),
              SizedBox(height: TSizes().spaceBtwInputFields),

              // Categories
              Text('Attribute Values', style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: TSizes().spaceBtwInputFields / 2),
              Obx(() {
                if (controller.isColorAttribute.value) {
                  return ColorPickerEdit();
                } else {
                  return SizedBox(
                    height: 80,
                    child: TextFormField(
                      expands: true,
                      maxLines: null,
                      textAlign: TextAlign.start,
                      controller: controller.attributeValues,
                      keyboardType: TextInputType.multiline,
                      textAlignVertical: TextAlignVertical.top,
                      validator: (value) => TValidator.validateEmptyText('Models Field', value),
                      decoration: const InputDecoration(
                        labelText: 'Attribute Values',
                        hintText: 'Add attributes separated by |  Example: Small | Medium | Large',
                        alignLabelWithHint: true,
                        suffixIcon: Tooltip(
                          message:
                              'List the possible values for this attribute, separated by \' | \'. For example: \'Small | Medium | Large\' or \'Red | Blue | Green\'.',
                          child: Icon(Iconsax.info_circle, color: Colors.grey),
                        ),
                      ),
                    ),
                  );
                }
              }),

              SizedBox(height: TSizes().spaceBtwInputFields),
              // Checkbox
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => CheckboxMenuButton(
                        value: controller.isSearchable.value,
                        onChanged: (value) => controller.isSearchable.value = value ?? false,
                        trailingIcon: Tooltip(
                          message:
                              'Mark this attribute as searchable, allowing users to filter products based on this attribute. For example, enabling this let users search by attribute name.',
                          child: Icon(Iconsax.info_circle, color: Colors.grey),
                        ),
                        child: const Text('Searchable'),
                      ),
                    ),
                  ),

                  SizedBox(width: TSizes().spaceBtwInputFields),

                  // Checkbox
                  Expanded(
                    child: Obx(
                      () => CheckboxMenuButton(
                        value: controller.isFilterable.value,
                        onChanged: (value) => controller.isFilterable.value = value ?? false,
                        trailingIcon: Tooltip(
                          message:
                              'If you want products to be sorted by this attribute (e.g., by price, size, or color), enable this option to let customers sort items accordingly.',
                          child: Icon(Iconsax.info_circle, color: Colors.grey),
                        ),
                        child: const Text('Sortable'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: TSizes().spaceBtwInputFields),
              Obx(
                () => AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  child: controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () => controller.updateAttribute(controller.attribute.value), child: const Text('Update')),
                        ),
                ),
              ),
              SizedBox(height: TSizes().spaceBtwInputFields * 2),
            ],
          ),
        ),
      ),
    );
  }
}
