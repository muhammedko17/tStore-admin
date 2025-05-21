import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:t_utils/t_utils.dart';






import '../../../../../../routes/routes.dart';

import '../../../../../../utils/constants/enums.dart';
import '../../../../controllers/coupon/coupon_controller.dart';
import '../../../../models/coupon_model.dart';

class CouponTable extends StatelessWidget {
  const CouponTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CouponController());
    return Column(
      children: [
        /// Table Header
        TTableHeader(
          buttonText: 'Create New Coupon',
          searchController: controller.searchTextController,
          onCreatePressed: () => Get.toNamed(TRoutes.createCoupon),
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
                DataColumn2(label: const Text('Coupon'), onSort: (index, asc) => controller.sortByName(index, asc), size: ColumnSize.S),
                const DataColumn2(label: Text('Discount Value'), size: ColumnSize.L),
                const DataColumn2(label: Text('Type'), size: ColumnSize.L),
                const DataColumn2(label: Text('Description'), size: ColumnSize.S),
                const DataColumn2(label: Text('Active'), size: ColumnSize.S),
                const DataColumn2(label: Text('Start Date'), size: ColumnSize.S),
                const DataColumn2(label: Text('End Date'), size: ColumnSize.S),
                const DataColumn2(label: Text('Action'), fixedWidth: 100),
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

  DataRow buildDataRow(CouponController controller, int index, CouponModel item, BuildContext context) {
    return DataRow(
      selected: controller.selectedRows[index],
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(Text('${index + 1}')),
        DataCell(Text(item.code, style: Theme.of(context).textTheme.titleLarge!.apply(color: TColors().primary))),
        DataCell(Text(item.discountValue.toString())),
        DataCell(TContainer(
          backgroundColor: item.discountType == DiscountType.percentage ? Colors.green.withValues(alpha: 0.1) : Colors.blue.withValues(alpha: 0.1),
          padding: EdgeInsets.symmetric(horizontal: TSizes().sm, vertical: TSizes().sm / 2),
          child: Text(item.discountType.name.toUpperCase()),
        ),),
        DataCell(Text(item.description, style: Theme.of(context).textTheme.bodyLarge)),
        // Active Switch
        DataCell(
          Obx(
            () => TAnimatedToggleSwitch(
              current: item.isActive,
              loading: controller.statusToggleSwitchLoaders[index],
              onChanged: (value) async => controller.statusToggleSwitch(index: index, toggle: value, item: item),
            ),
          ),
        ),
        DataCell(Text(item.startDate == null ? '' : item.formattedStartDate)),
        DataCell(Text(item.endDate == null ? '' : item.formattedEndDate)),
        DataCell(
          TTableActionButtons(
            onDeletePressed: () => controller.confirmAndDeleteItem(item),
            onEditPressed: () => Get.toNamed(TRoutes.editCoupon, arguments: item, parameters: {'id': item.id}),
          ),
        ),
      ],
    );
  }
}
