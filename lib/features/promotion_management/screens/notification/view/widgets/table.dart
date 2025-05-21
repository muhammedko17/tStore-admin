import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:t_utils/t_utils.dart';





import '../../../../../../data/services/notification/notification_model.dart';
import '../../../../../../routes/routes.dart';

import '../../../../controllers/notification/notification_controller.dart';

class NotificationTable extends StatelessWidget {
  const NotificationTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());
    return Column(
      children: [
        /// Table Header
        TTableHeader(
          buttonText: 'Create New Notification',
          searchController: controller.searchTextController,
          onCreatePressed: () => Get.toNamed(TRoutes.createNotification),
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
                DataColumn2(
                    label: const Text('Notification'), onSort: (index, asc) => controller.sortByName(index, asc), size: ColumnSize.L),
                const DataColumn2(label: Text('Type'), size: ColumnSize.S),
                const DataColumn2(label: Text('Sent'), size: ColumnSize.S),
                const DataColumn2(label: Text('Date'), size: ColumnSize.S),
                const DataColumn2(label: Text('Action'), fixedWidth: 70),
              ],
              rows: controller.filteredItems.asMap().entries.map((entry) {
                final index = entry.key;
                final coupon = entry.value;
                return buildDataRow(controller, index, coupon, context);
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  DataRow buildDataRow(NotificationController controller, int index, NotificationModel item, BuildContext context) {
    return DataRow(
      selected: controller.selectedRows[index],
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(Text('${index + 1}')),
        DataCell(
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title, style: Theme.of(context).textTheme.titleSmall!.apply(color: TColors().primary), maxLines: 1),
              Text(item.body, style: Theme.of(context).textTheme.bodyMedium, maxLines: 2),
            ],
          ),
        ),
        DataCell(
          TContainer(
            backgroundColor: TColors().primary.withValues(alpha: 0.1),
            padding: EdgeInsets.symmetric(vertical: TSizes().sm / 2, horizontal: TSizes().sm),
            child: Text(item.type, style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors().primary)),
          ),
        ),
        DataCell(Text(item.formattedSentDate)),
        DataCell(Text(item.formattedDate)),
        DataCell(
          TTableActionButtons(
            edit: false,
            onDeletePressed: () => controller.confirmAndDeleteItem(item),
          ),
        ),
      ],
    );
  }
}
