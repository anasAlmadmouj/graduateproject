import 'package:flutter/material.dart';
import 'package:graduateproject/app_layout/app_layout_imports.dart';

showCustomDropDownDialog({
  required BuildContext context,
  required Widget child,
  required String title,
  required VoidCallback? iconFunction,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          IconButton(
            onPressed: iconFunction,
            icon: const Icon(Icons.arrow_back_outlined),
            color: defaultColorGreen,
          ),
          Expanded(child: Text(title)),
        ],
      ),
      content: child,
    ),
  );
}
