import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduateproject/shared/styles/colors.dart';

Widget defaultTextButton({VoidCallback? function, String? text}) => TextButton(
      onPressed: function,
      child: Text("$text".toUpperCase()),
    );

PreferredSizeWidget customizedAppBar({
  required VoidCallback? function,
  IconData? icon = Icons.arrow_back_ios_new_outlined,
  required String? title,
}) =>
    AppBar(
      backgroundColor: scaffoldColor,
      leading: IconButton(
        onPressed: function,
        icon: Icon(
          icon,
          color: defaultColorGreen,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            '$title',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: defaultColorGreen,
              fontSize: 20,
            ),
          ),
        ),
      ],
      elevation: 0,
    );

Widget defaultElevatedButton({
  Color? backGroundColor,
  double? height = 50.0,
  double? width = double.infinity,
  VoidCallback? function,
  String? text,
  double? borderRadius = 0.0,
  double? fontSize = 18.0,
  Color? colorText = Colors.white,
}) =>
    SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(backGroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
            ),
          ),
        ),
        onPressed: function,
        child: Text(
          "$text".toUpperCase(),
          style: TextStyle(
            color: colorText,
            fontSize: fontSize,
          ),
        ),
      ),
    );

Widget defaultElevatedButtonWithIcon({
  double? height = 45.0,
  double? width = 200.0,
  VoidCallback? function,
  Color? backgroundColor = Colors.blue,
  String? text,
  double? borderRadius = 15.0,
  Color? colorText = Colors.white,
  IconData? icon,
}) =>
    SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            backgroundColor!,
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            colorText!,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
            ),
          ),
        ),
        onPressed: function,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "$text".toUpperCase(),
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Icon(
              icon,
              size: 24.0,
            ),
          ],
        ),
      ),
    );

Widget defaultTextFormField({
  var controller,
  var onSubmit,
  bool obscureText = false,
  TextInputType? keyboardType,
  TextInputAction? action,
  String? labelText,
  String? hintText = "",
  IconData? prefixIcon,
  IconData? suffixIcon,
  VoidCallback? suffixPressed,
  FormFieldValidator<String>? validation,
  context,
}) =>
    TextFormField(
      onFieldSubmitted: onSubmit,
      obscureText: obscureText,
      keyboardType: keyboardType,
      controller: controller,
      textInputAction: action,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: Padding(
          padding: EdgeInsetsDirectional.only(end: 10.0),
          child: IconButton(
            onPressed: suffixPressed,
            icon: Icon(suffixIcon),
          ),
        ),
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(15.0),
        // ),
      ),
      validator: validation,
    );

void showToast({
  required String message,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates {
  SUCCESS,
  ERROR,
  WARNING,
}

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    default:
      return Colors.amber;
  }
  return color;
}
