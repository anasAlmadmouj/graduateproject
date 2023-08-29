import 'package:flutter/material.dart';
import 'package:graduateproject/shared/network/local/navigator_helper.dart';

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
      height: 600,
      child: SingleChildScrollView(
        child: Column(
          // shrinkWrap: true,
          children: actionDropDownList,
        ),
      ),
    );
    // return Container(
    //   margin: EdgeInsets.symmetric(
    //     vertical: MediaQuery.of(context).size.height / 1.5,
    //     horizontal: MediaQuery.of(context).size.width / 1.7,
    //   ),
    //   decoration: BoxDecoration(
    //     color: Theme.of(context).cardColor,
    //     borderRadius: BorderRadius.circular(30),
    //   ),
    //   alignment: Alignment.bottomRight,
    //   clipBehavior: Clip.antiAliasWithSaveLayer,
    //   width: MediaQuery.of(context).size.width / 2,
    //   height: height ?? MediaQuery.of(context).size.height / 2,
    //   child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       mainAxisAlignment: MainAxisAlignment.end,
    //       children: [
    //         const SizedBox(
    //           height: 16,
    //         ),
    //         ListTile(
    //           leading: titleIconData != null ? Icon(titleIconData) : null,
    //           trailing: const Icon(Icons.keyboard_arrow_down),
    //           horizontalTitleGap: 8,
    //           title: Text(
    //             title,
    //             style: Theme.of(context).textTheme.bodyLarge,
    //           ),
    //           onTap: () {
    //             if (onTapTitle != null) {
    //               onTapTitle!();
    //             }
    //             FocusManager.instance.primaryFocus?.unfocus();
    //             pop(context);
    //           },
    //         ),
    //         const Divider(),
    //         Expanded(
    //           child: actionDropDownList.isEmpty
    //               ? const Center(
    //                   child: Text('Not Found'),
    //                 )
    //               : ListView(
    //                   shrinkWrap: true,
    //                   children: actionDropDownList,
    //                 ),
    //         ),
    //         const SizedBox(
    //           height: 16,
    //         ),
    //       ]),
    // );
  }
}
