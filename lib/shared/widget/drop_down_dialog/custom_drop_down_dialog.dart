import 'package:flutter/material.dart';

class CustomDropDownDialog extends StatelessWidget {
  const CustomDropDownDialog({
    Key? key,
    // required this.title,
    required this.actionDropDownList,
    this.onTapTitle,
    this.height,
    this.titleIconData,
  }) : super(key: key);

  // final String title;
  final double? height;
  final List<Widget> actionDropDownList;
  final Function? onTapTitle;
  final IconData? titleIconData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          // shrinkWrap: true,
          children: actionDropDownList,
        ),
      ),
    );
  }
}
