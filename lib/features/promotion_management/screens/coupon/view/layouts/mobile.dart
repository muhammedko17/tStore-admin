import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


import 'package:t_utils/t_utils.dart';

import '../widgets/table.dart';

class CouponsMobileScreen extends StatelessWidget {
  const CouponsMobileScreen({super.key});

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
              TBreadcrumbsWithHeading(iconData: Iconsax.discount_circle, heading: 'All Coupons', breadcrumbItems: ['All Coupons']),
              SizedBox(height: TSizes().spaceBtwSections),

              // Body
              CouponTable(),
            ],
          ),
        ),
      ),
    );
  }
}
