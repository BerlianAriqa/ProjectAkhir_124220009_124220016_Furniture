import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class TouchableOpacity extends StatelessWidget {
  Widget child;
  void Function()?  onTap;
  TouchableOpacity({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      onPressed: onTap,
      child: child,
    );
  }
}
