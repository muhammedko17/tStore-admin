import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:t_utils/t_utils.dart';

import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../controllers/customer_controller.dart';
import '../../../../models/user_model.dart';

class CustomerTable extends StatelessWidget {
  const CustomerTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerController());
    return Column(
      children: [
        /// Table Header
        TTableHeader(
          showCreateButton: false,
          searchController: controller.searchTextController,
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
                DataColumn2(label: const Text('Customer'), onSort: (index, asc) => controller.sortByName(index, asc), size: ColumnSize.L),
                const DataColumn2(label: Text('Email'), size: ColumnSize.M),
                const DataColumn2(label: Text('Phone Number'), size: ColumnSize.S),
                const DataColumn2(label: Text('Orders'), size: ColumnSize.S),
                const DataColumn2(label: Text('Points'), size: ColumnSize.S),
                const DataColumn2(label: Text('Register Date'), size: ColumnSize.S),
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

  DataRow buildDataRow(CustomerController controller, int index, UserModel item, BuildContext context) {
    return DataRow(
      selected: controller.selectedRows[index],
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(Text('${index + 1}')),
        DataCell(
          Row(
            children: [
              TImage(
                backgroundColor: TColors().lightBackground,
                imageType: item.profilePicture.isNotEmpty ? ImageType.network : ImageType.asset,
                image: item.profilePicture.isNotEmpty ? item.profilePicture : TImages.user,
              ),
              SizedBox(width: TSizes().sm),
              Expanded(
                child: Text(
                  maxLines: 2,
                  item.fullName,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge!.apply(color: TColors().primary),
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(item.email, style: Theme.of(context).textTheme.bodyLarge)),
        DataCell(Text(item.phoneNumber, style: Theme.of(context).textTheme.bodyLarge)),
        DataCell(CircleAvatar(child: Text(item.orderCount.toString(), style: Theme.of(context).textTheme.bodyLarge))),
        DataCell(CircleAvatar(child: Text(item.points.toString(), style: Theme.of(context).textTheme.bodyLarge))),
        DataCell(Text(item.formattedDate)),
        DataCell(
          TTableActionButtons(
            onDeletePressed: () => controller.confirmAndDeleteItem(item),
            onEditPressed: () => Get.toNamed(TRoutes.customerDetails, arguments: item, parameters: {'id': item.id}),
          ),
        ),
      ],
    );
  }
}
