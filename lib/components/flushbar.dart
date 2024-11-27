import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:furnitur/utils/theme.dart';

Widget alert(context, {String? text, IconData? icon, Color? color}) {
  return Flushbar(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    isDismissible: true,
    borderRadius: BorderRadius.circular(5),
    message: text.toString(),
    icon: Icon(
      icon ?? Icons.info_outline,
      size: 28.0,
      color: color ?? FurniColors.red,
    ),
    duration: const Duration(seconds: 2),
  )..show(context);
}
