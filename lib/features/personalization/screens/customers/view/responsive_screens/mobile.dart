import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


import 'package:t_utils/t_utils.dart';

import '../widgets/table.dart';

class CustomersMobileScreen extends StatelessWidget {
  const CustomersMobileScreen({super.key});

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
              TBreadcrumbsWithHeading(iconData: Iconsax.user_octagon, heading: 'All Customers', breadcrumbItems: ['All Customers']),
              SizedBox(height: TSizes().spaceBtwSections),

              // Body
              CustomerTable(),
            ],
          ),
        ),
      ),
    );
  }
}
