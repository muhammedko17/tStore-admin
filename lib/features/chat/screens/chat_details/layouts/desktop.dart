import 'package:flutter/material.dart';
import 'package:t_utils/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:t_utils/utils/constants/sizes.dart';
import '../chat/messages_screen.dart';

class ChatDesktop extends StatelessWidget {
  const ChatDesktop({super.key});

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
              const TBreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: 'All Messages',
                breadcrumbItems: ['All Messages'],
              ),
              SizedBox(height: TSizes().spaceBtwSections),

              // Form
              MessagesScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
