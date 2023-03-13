part of analytics_widgets;

class OnboardTile extends StatelessWidget {
  const OnboardTile({
    super.key,
    required this.onboardMessage,
  });

  final String onboardMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFDCF4F0),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: ListTile(
          leading: Container(
            height: 40.h,
            width: 40.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.all(Radius.circular(20.h)),
            ),
          ),
          title: Text(onboardMessage),
          trailing: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
