import 'package:flutter/material.dart';

class FurniColors {
  static const Color black = Color(0xff2D3D49);
  static const Color primary = Color.fromARGB(255, 0, 52, 87);
  static const Color secondary = Color(0xFF90C3EB);
  static const Color lightPrimary = Color.fromARGB(255, 204, 220, 224);
  static const Color background = Colors.white;
  static const Color red = Color(0xffD3546E);
  static const Color grey = Color.fromARGB(255, 196, 203, 209);
  static const Color greyMore = Color(0xFFDDE6ED);
  static const Color textMore = Color(0xFF768895);
  static const Color grayStroke = Color(0xffBCC7CF);
  static const Color anggota = Color.fromARGB(255, 54, 110, 96);
  static const Color shadow = Color.fromARGB(255, 168, 178, 195);
}

class FurniFonts extends FurniColors {
  late BuildContext context;
  late TextStyle appbarTitle;
  late TextStyle actionText;
  late TextStyle hintTextField;
  late TextStyle textField;
  late TextStyle labelTextField;
  late TextStyle textButton;

  TextStyle boldQuicksand({
    double size = 30,
    Color? color,
    double? height,
    double? letterSpacing,
    bool italic = false,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
      fontFamily: 'QuicksandBold',
      fontSize: size,
      fontWeight: fontWeight,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      color: color ?? FurniColors.black,
      letterSpacing: letterSpacing,
    );
  }

  // Quicksand
  TextStyle semiBoldQuicksand({
    double size = 28,
    Color? color,
    double? height,
    double? letterSpacing,
    bool italic = false,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
      fontFamily: 'QuicksandSemiBold',
      fontSize: size,
      fontWeight: fontWeight,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      color: color ?? FurniColors.black,
      letterSpacing: letterSpacing,
    );
  }

  TextStyle regularQuicksand({
    double size = 22,
    Color? color,
    double? height,
    double? letterSpacing,
    bool italic = false,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
      fontFamily: 'QuicksandRegular',
      fontSize: size,
      fontWeight: fontWeight,
      height: height,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      color: color ?? FurniColors.black,
      letterSpacing: letterSpacing,
    );
  }

  TextStyle lightQuicksand({
    double size = 15,
    Color? color,
    double? height,
    double? letterSpacing,
    bool italic = false,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
      fontFamily: 'QuicksandLight',
      fontSize: size,
      fontWeight: fontWeight,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      color: color ?? FurniColors.black,
      letterSpacing: letterSpacing,
    );
  }

  TextStyle mediumQuicksand({
    double size = 14,
    Color? color,
    double? height,
    double? letterSpacing,
    bool italic = false,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
      fontFamily: 'QuicksandMedium',
      fontSize: size,
      fontWeight: fontWeight,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      color: color ?? FurniColors.black,
      letterSpacing: letterSpacing,
    );
  }

  // END Quicksand

  FurniFonts(this.context) {
    textButton = const TextStyle(
      color: FurniColors.primary,
      fontFamily: 'PMedium',
      fontSize: 16,
    );

    appbarTitle = const TextStyle(
      color: FurniColors.primary,
      fontFamily: 'QuicksandBold',
      fontSize: 18,
    );

    actionText = const TextStyle(
      color: FurniColors.primary,
      fontFamily: 'QuicksandLight',
      fontSize: 15,
    );

    hintTextField = const TextStyle(
      color: FurniColors.grey,
      fontWeight: FontWeight.w300,
      fontSize: 14,
      fontFamily: 'QuicksandRegular',
    );

    labelTextField = const TextStyle(
      color: FurniColors.black,
      fontFamily: 'QuicksandMedium',
      fontSize: 15,
    );

    textField = const TextStyle(
      color: FurniColors.black,
      fontWeight: FontWeight.w300,
      fontSize: 14,
    );
  }
}
