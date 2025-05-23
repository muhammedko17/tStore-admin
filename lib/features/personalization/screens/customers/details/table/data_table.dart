import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:t_utils/t_utils.dart';

import '../../../../controllers/customer_detail_controller.dart';
import 'table_source.dart';

class CustomerOrderTable extends StatelessWidget {
  const CustomerOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailController.instance;
    return Obx(
      () {
        // Customers & Selected Rows are Hidden => Just to update the UI => Obx => [ProductRows]
        Visibility(visible: false, child: Text(controller.filteredCustomerOrders.length.toString()));
        Visibility(visible: false, child: Text(controller.selectedRows.length.toString()));

        // Table
        return TPaginatedDataTable(
          minWidth: 550,
          tableHeight: 640,
          dataRowHeight: kMinInteractiveDimension,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          columns: [
            DataColumn2(label: const Text('Order ID'), onSort: (columnIndex, ascending) => controller.sortById(columnIndex, ascending)),
            const DataColumn2(label: Text('Date')),
            const DataColumn2(label: Text('Items')),
            DataColumn2(label: const Text('Status'), fixedWidth: TDeviceUtils.isMobileScreen(context) ? 100 : null),
            const DataColumn2(label: Text('Amount'), numeric: true),
          ],
          source: CustomerOrdersRows(),
        );
      },
    );
  }
}
