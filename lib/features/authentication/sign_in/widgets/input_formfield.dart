part of signin_widgets;

class InputFormField extends StatefulWidget {
  const InputFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.showSuffix,
    this.hidePassword,
    this.isTextBox,
    this.isUnderLine,
    this.isEmail,
    this.enabled = true,
    this.toggleHidePassword,
  });
  final String hintText;
  final TextEditingController controller;
  final bool? showSuffix;
  final bool? hidePassword;
  final VoidCallback? toggleHidePassword;
  final bool? isTextBox;
  final bool? isUnderLine;
  final bool? isEmail;
  final bool? enabled;
  @override
  State<InputFormField> createState() => _InputFormFieldState();
}

class _InputFormFieldState extends State<InputFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      controller: widget.controller,
      obscureText: widget.hidePassword ?? false,
      maxLines: widget.isTextBox != null ? 3 : 1,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        disabledBorder: widget.isUnderLine != null
            ? UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColorLight,
                ),
              )
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
        border: widget.isUnderLine != null
            ? UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColorLight,
                ),
              )
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
        suffixIcon: (widget.showSuffix == null)
            ? null
            : IconButton(
                onPressed: widget.toggleHidePassword,
                splashRadius: 18,
                icon: Icon(
                  !(widget.hidePassword == null || widget.hidePassword == false)
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Theme.of(context).primaryColorDark,
                  size: 18,
                ),
              ),
        contentPadding: widget.isUnderLine != null
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).primaryColorLight,
        ),
      ),
    );
  }
}
