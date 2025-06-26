import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class SignInAndUpRow extends StatelessWidget {
  final String desc;
  final String action;
  final VoidCallback onClick;

  const SignInAndUpRow({
    super.key,
    required this.desc,
    required this.action,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(desc, style: const TextStyle(fontSize: 12)),
        TextButton(
          onPressed: onClick,
          child: Text(
            action,
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
