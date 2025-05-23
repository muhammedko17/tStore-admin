import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


import 'package:t_utils/t_utils.dart';

import '../widgets/table.dart';

class AttributesDesktopScreen extends StatelessWidget {
  const AttributesDesktopScreen({super.key});

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
              TBreadcrumbsWithHeading(iconData: Iconsax.activity, heading: 'All Attributes', breadcrumbItems: ['All Attributes']),
              SizedBox(height: TSizes().spaceBtwSections),

              // Body
              AttributeTable(),
            ],
          ),
        ),
      ),
    );
  }
}
