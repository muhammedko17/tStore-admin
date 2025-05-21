import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:t_utils/t_utils.dart';







import '../../../../../../routes/routes.dart';

import '../../../../../../utils/constants/image_strings.dart';
import '../../../../controllers/banner/banner_controller.dart';
import '../../../../models/banner_model.dart';

class BannerTable extends StatelessWidget {
  const BannerTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Column(
      children: [
        /// Table Header
        TTableHeader(
          buttonText: 'Create New Banner',
          searchController: controller.searchTextController,
          onCreatePressed: () => Get.toNamed(TRoutes.createBanner),
          onSearchChanged: (value) => controller.searchQuery(value),
        ),
        SizedBox(height: TSizes().spaceBtwSections),

        /// Table
        Obx(
          () {
            return TDataTable(
              minWidth: 700,
              dataRowHeight: 106,
              isLoading: controller.isLoading.value,
              sortAscending: controller.sortAscending.value,
              allItemsFetched: controller.allItemsFetched.value,
              sortColumnIndex: controller.sortColumnIndex.value,
              loadMoreButtonOnPressed: () => controller.fetchData(),
              columns: [
                DataColumn2(label: const Text('Banner'), onSort: (index, asc) => controller.sortByName(index, asc), size: ColumnSize.S),
                const DataColumn2(label: Text('Title'), size: ColumnSize.S),
                const DataColumn2(label: Text('Views'), size: ColumnSize.S),
                const DataColumn2(label: Text('Clicks'), size: ColumnSize.S),
                const DataColumn2(label: Text('Redirect'), size: ColumnSize.S),
                const DataColumn2(label: Text('Active'), size: ColumnSize.S),
                const DataColumn2(label: Text('Featured'), size: ColumnSize.S),
                const DataColumn2(label: Text('Start Date'), size: ColumnSize.S),
                const DataColumn2(label: Text('End Date'), size: ColumnSize.S),
                const DataColumn2(label: Text('Action'), fixedWidth: 100),
              ],
              rows: controller.filteredItems.asMap().entries.map((entry) {
                final index = entry.key;
                final banner = entry.value;
                return buildDataRow(controller, index, banner, context);
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  DataRow buildDataRow(BannerController controller, int index, BannerModel item, BuildContext context) {
    return DataRow(
      selected: controller.selectedRows[index],
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(
          TImage(
            padding: TSizes().sm,
            width: null,
            height: null,
            imageType: item.imageUrl.isNotEmpty ? ImageType.network : ImageType.asset,
            image: item.imageUrl.isNotEmpty ? item.imageUrl : TImages.defaultImage,
          ),
        ),
        DataCell(
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title, style: Theme.of(context).textTheme.bodyLarge),
              Text(item.description, style: Theme.of(context).textTheme.labelMedium),
            ],
          ),
        ),
        DataCell(Text(item.views.toString(), style: Theme.of(context).textTheme.bodyLarge)),
        DataCell(Text(item.clicks.toString(), style: Theme.of(context).textTheme.bodyLarge)),
        DataCell(
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TContainer(
                padding: EdgeInsets.symmetric(vertical: TSizes().sm / 2, horizontal: TSizes().sm),
                backgroundColor: TColors().lightBackground,
                child: Text(
                  item.targetType.name[0].toUpperCase() + item.targetType.name.substring(1),
                  style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors().primary),
                ),
              ),
              Text(item.targetTitle.toString(), style: Theme.of(context).textTheme.bodyLarge)
            ],
          ),
        ),
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
        // Featured Switch
        DataCell(
          Obx(
            () => TAnimatedToggleSwitch(
              current: item.isFeatured,
              loading: controller.featuredToggleSwitchLoaders[index],
              onChanged: (value) async => controller.featuredToggleSwitch(index: index, toggle: value, item: item),
            ),
          ),
        ),
        DataCell(Text(item.startDate == null ? '' : item.formattedStartDate)),
        DataCell(Text(item.endDate == null ? '' : item.formattedEndDate)),
        DataCell(
          TTableActionButtons(
            onDeletePressed: () => controller.confirmAndDeleteItem(item),
            onEditPressed: () => Get.toNamed(TRoutes.editBanner, arguments: item, parameters: {'id': item.id}),
          ),
        ),
      ],
    );
  }
}
