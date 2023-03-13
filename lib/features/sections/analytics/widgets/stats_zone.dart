part of analytics_widgets;

class StatsZone extends StatelessWidget {
  const StatsZone({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const StatGridTile(
                title: 'Earnings',
                subtitle: 'Total revenue',
                value: 229000,
                percentage: 67,
              ),
              SizedBox(
                width: 10.sp,
              ),
              const StatGridTile(
                title: 'Sales',
                subtitle: 'Total sales',
                value: 89,
                percentage: 55,
              ),
            ],
          ),
          SizedBox(
            height: 10.sp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const StatGridTile(
                title: 'Orders',
                subtitle: 'Total orders',
                value: 14,
                percentage: 18,
              ),
              SizedBox(
                width: 10.sp,
              ),
              const StatGridTile(
                title: 'Customers',
                subtitle: 'Total visited',
                value: 14,
                percentage: 12,
              ),
            ],
          ),
          SizedBox(
            height: 10.sp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const InfoGridTile(
                title: 'Total Products',
                value: 100,
              ),
              SizedBox(
                width: 10.sp,
              ),
              const InfoGridTile(
                title: 'Out of Stock',
                value: 24,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
