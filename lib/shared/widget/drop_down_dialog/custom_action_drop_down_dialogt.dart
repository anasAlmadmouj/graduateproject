import 'package:flutter/material.dart';
import 'package:graduateproject/app_layout/app_layout_imports.dart';

class CustomActionDropDownDialog extends StatelessWidget {
  final String title;
  final FontWeight fontWeight;
  final VoidCallback onTap;
  final IconData? iconData;

  const CustomActionDropDownDialog({
    Key? key,
    required this.title,
    required this.fontWeight,
    required this.onTap,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: ListTile(

            leading: iconData != null
                ? Icon(
              iconData,
              size: 40,
            )
                : null,
            horizontalTitleGap: 8,
            minVerticalPadding: 16,
            title: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            onTap: () {
              onTap();
              maybePop(context);
            },
          ),
        ),
        // const Divider(),
      ],
    );
  }
}
