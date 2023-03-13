part of analytics_widgets;

class OnboardArea extends StatelessWidget {
  const OnboardArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Your Store is 20% complete'),
          const SizedBox(
            height: 8,
          ),
          LinearProgressIndicator(
            value: 0.2,
            minHeight: 5.h,
          ),
          const SizedBox(
            height: 8,
          ),
          const OnboardTile(
            onboardMessage:
                "Now that you've created an account, set up a store!",
          ),
          const SizedBox(
            height: 8,
          ),
          const OnboardTile(
            onboardMessage: 'Set up a payment option',
          ),
          const SizedBox(
            height: 8,
          ),
          const OnboardTile(
            onboardMessage: 'Add products to your shop',
          ),
        ],
      ),
    );
  }
}
