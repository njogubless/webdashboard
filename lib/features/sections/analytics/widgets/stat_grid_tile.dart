part of analytics_widgets;

class StatGridTile extends StatelessWidget {
  const StatGridTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.percentage,
  });

  final String title;
  final String subtitle;
  final int value;
  final int percentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      width: 160.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFF5F5F5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(subtitle),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text('${title == 'Earnings' ? r'$ ' : ''}$value'),
                  ],
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: 50.h,
                      width: 50.h,
                      child: FittedBox(
                        child: CircularProgressIndicator(
                          value: percentage / 100,
                          strokeWidth: 1.5,
                        ),
                      ),
                    ),
                    Positioned(
                      height: 50.h,
                      width: 50.h,
                      child: Align(
                        child: Text(
                          '$percentage%',
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
