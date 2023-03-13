import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webdashboard/features/sections/analytics/widgets/_index.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const DashboardAppBar(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: Row(
                      children: const [
                        Text('Today'),
                        Icon(Icons.arrow_drop_up)
                      ],
                    ),
                  ),
                  TextButton(
                    child: const Text(
                      'View Reports',
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const OnboardArea(),
            SizedBox(height: 10.sp),
            const StatsZone(),
            SizedBox(height: 10.sp),
          ],
        ),
      ),
    );
  }
}
