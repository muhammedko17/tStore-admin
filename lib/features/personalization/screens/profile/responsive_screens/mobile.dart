import 'package:flutter/material.dart';
import 'package:t_utils/t_utils.dart';

import '../widgets/form.dart';
import '../widgets/image_meta.dart';

class ProfileMobileScreen extends StatelessWidget {
  const ProfileMobileScreen({super.key});

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
              TBreadcrumbsWithHeading(heading: 'Profile', breadcrumbItems: ['Profile']),
              SizedBox(height: TSizes().spaceBtwSections),

              TFormContainer(
                child: Column(
                  children: [
                    ImageAndMeta(),
                    SizedBox(height: TSizes().spaceBtwSections),

                    // Form
                    ProfileForm(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
