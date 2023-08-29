import 'package:flutter/material.dart';

void navigateTo(context, widget, {fullscreenDialog}) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
      fullscreenDialog: fullscreenDialog ?? true,
    ));

void navigateToReplacement(context, widget, {fullscreenDialog}) =>
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
          fullscreenDialog: fullscreenDialog ?? true,
        ));

void navigateToAndRemoveUntil(context, widget, {fullscreenDialog}) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
          fullscreenDialog: fullscreenDialog ?? true,
        ),
        (Route<dynamic> route) => false);

void pop(context) => Navigator.pop(context);
void maybePop(context) => Navigator.maybePop(context);
