part of signin_widgets;

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
    required this.title,
  });

  final VoidCallback onPressed;
  final bool isLoading;
  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.blue,
      minWidth: double.infinity,
      height: 40,
      elevation: 0,
      highlightElevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      disabledElevation: 0,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Wrap(
        children: [
          if (isLoading) ...[
            const SizedBox(
              height: 14,
              width: 14,
              child: CircularProgressIndicator(
                color: Colors.white,
                backgroundColor: Colors.transparent,
                strokeWidth: 2,
              ),
            ),
            const SizedBox(width: 8),
          ] else
            const SizedBox.shrink(),
          Text(
            title,
          ),
        ],
      ),
    );
  }
}
