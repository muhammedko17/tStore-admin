import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:t_utils/t_utils.dart';




import '../../../../../../routes/routes.dart';

import '../../../../controllers/attribute/attribute_controller.dart';
import '../../../../models/attribute_model.dart';

class AttributeTable extends StatelessWidget {
  const AttributeTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AttributeController());
    return Column(
      children: [
        /// Table Header
        TTableHeader(
          buttonText: 'Create New Attribute',
          searchController: controller.searchTextController,
          onCreatePressed: () => Get.toNamed(TRoutes.createAttribute),
          onSearchChanged: (value) => controller.searchQuery(value),
        ),
        SizedBox(height: TSizes().spaceBtwSections),

        /// Table
        Obx(
          () {
            return TDataTable(
              minWidth: 700,
              isLoading: controller.isLoading.value,
              sortAscending: controller.sortAscending.value,
              allItemsFetched: controller.allItemsFetched.value,
              sortColumnIndex: controller.sortColumnIndex.value,
              loadMoreButtonOnPressed: () => controller.fetchData(),
              columns: [
                const DataColumn2(label: Text('Ser'), fixedWidth: 40),
                DataColumn2(label: const Text('Attribute'), onSort: (index, asc) => controller.sortByName(index, asc), size: ColumnSize.S),
                const DataColumn2(label: Text('Values'), size: ColumnSize.L),
                const DataColumn2(label: Text('Status'), size: ColumnSize.S),
                const DataColumn2(label: Text('Date'), size: ColumnSize.S),
                const DataColumn2(label: Text('Action'), fixedWidth: 100),
              ],
              rows: controller.filteredItems.asMap().entries.map((entry) {
                final index = entry.key;
                final attribute = entry.value;
                return buildDataRow(controller, index, attribute, context);
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  DataRow buildDataRow(AttributeController controller, int index, AttributeModel item, BuildContext context) {
    return DataRow(
      selected: controller.selectedRows[index],
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(Text('${index + 1}')),
        DataCell(Text(item.name.capitalize.toString(), style: Theme.of(context).textTheme.titleLarge!.apply(color: TColors().primary))),
        DataCell(
          item.isColorAttribute
              ? ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 48.0, // Minimum height of the row
                    maxHeight: double.infinity, // Allow it to expand
                  ),
                  child: Wrap(
                    spacing: -15,
                    children: controller
                        .convertStringsToColors(item.attributeValues)
                        .map((color) => Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black, width: 1),
                              ),
                            ))
                        .toList(),
                  ),
                )
              : Text(item.attributeValues.map((v) => v).join(', '), style: Theme.of(context).textTheme.bodyLarge),
        ),
        // Active Switch
        DataCell(
          TAnimatedToggleSwitch(
            current: item.isActive,
            loading: controller.statusToggleSwitchLoaders[index],
            onChanged: (value) async => controller.statusToggleSwitch(index: index, toggle: value, item: item),
          ),
        ),
        DataCell(Text(item.createdAt == null ? '' : item.formattedDate)),
        DataCell(
          TTableActionButtons(
            onDeletePressed: () => controller.confirmAndDeleteItem(item),
            onEditPressed: () => Get.toNamed(TRoutes.editAttribute, arguments: item, parameters: {'id': item.id}),
          ),
        ),
      ],
    );
  }
}
