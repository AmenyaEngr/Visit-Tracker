import 'package:flutter/material.dart';

typedef Validator = String? Function(String? value);

class InputTextFieldWidget extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final String? errorText;
  final TextInputType? inputType;
  final TextEditingController editingController;
  final int minLines;
  final int? maxLines;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final Validator? validator;
  final Widget? prefixIcon;
  final IconData? suffixIcon;

  const InputTextFieldWidget({
    super.key,
    required this.hintText,
    required this.editingController,
    this.labelText,
    this.inputType,
    this.errorText,
    this.minLines = 1,
    this.onTap,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: editingController,
      keyboardType: inputType,
      onTap: onTap,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        hintText: hintText,
        hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
        labelText: labelText,
        errorText: errorText,
      ),
      maxLines: maxLines,
      minLines: minLines,
      style: const TextStyle(fontSize: 14),
      validator: (val) {
        if (validator != null) {
          return validator!(val);
        } else if (errorText?.isNotEmpty == true) {
          return errorText;
        }
        return null;
      },
    );
  }
}

class PasswordTextFieldWidget extends StatefulWidget {
  final String hintText;
  final String labelText;
  final String? errorText;
  final TextEditingController passwordTextEditController;

  const PasswordTextFieldWidget({
    super.key,
    required this.hintText,
    required this.passwordTextEditController,
    required this.labelText,
    this.errorText,
  });

  @override
  State<PasswordTextFieldWidget> createState() =>
      _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  bool showPassword = false;

  void _toggleVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !showPassword,
      controller: widget.passwordTextEditController,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        errorText: widget.errorText,
        hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
        prefixIcon: Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          onPressed: () {
            _toggleVisibility();
          },
          icon:
              showPassword
                  ? const Icon(size: 15, Icons.visibility)
                  : const Icon(size: 15, Icons.visibility_off),
        ),
      ),
      style: const TextStyle(fontSize: 14),
      validator: (val) {
        if (val?.isEmpty == true) {
          return "Please input password";
        }
        return null;
      },
    );
  }
}
