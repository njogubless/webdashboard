part of analytics_widgets;

class DashboardAppBar extends StatelessWidget with PreferredSizeWidget {
  const DashboardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Hello, Musa Abubakar'),
          Text("Here's how your shop's doing"),
        ],
      ),
      actions: [
        SvgPicture.asset(
          'assets/icons/profile.svg',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
