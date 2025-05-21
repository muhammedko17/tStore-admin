import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


import 'package:t_utils/t_utils.dart';

import '../widgets/table.dart';

class OrdersDesktopScreen extends StatelessWidget {
  const OrdersDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes().defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              TBreadcrumbsWithHeading(iconData: Iconsax.box, heading: 'All Orders', breadcrumbItems: ['All Orders']),
              SizedBox(height: TSizes().spaceBtwSections),

              // Body
              OrderTable(),
            ],
          ),
        ),
      ),
    );
  }
}
