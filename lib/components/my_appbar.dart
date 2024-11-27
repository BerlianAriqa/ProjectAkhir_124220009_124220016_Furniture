import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnitur/utils/theme.dart';

AppBar myAppBar(
  BuildContext context, {
  String? username, // Menambahkan parameter username
  String title = '', // Menambahkan parameter title
  List<Widget>? action,
  bool leading = false,
  VoidCallback? leadingAction,
  ImageProvider? image,
  bool automaticImplyLeading = true,
}) {
  return AppBar(
    centerTitle: true,
    title: Text(
      username != null ? 'Welcome, $username!' : title, // Menampilkan pesan sambutan atau title
      style: FurniFonts(context).appbarTitle,
    ),
    actions: action,
    elevation: 0,
    automaticallyImplyLeading: automaticImplyLeading,
    backgroundColor: Colors.transparent,
    leading: leading
        ? CupertinoButton(
            padding: EdgeInsets.zero, // Remove padding for a flat button style
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(
              CupertinoIcons.back,
              color: FurniColors.primary, // Use your defined primary color
            ),
          )
        : null,
  );
}