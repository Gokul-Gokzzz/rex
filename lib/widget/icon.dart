import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  const IconWidget(
    context, {
    super.key,
    required this.iconData,
    this.color = Colors.black,
    this.size = .061,
    this.padding = 8,
  });

  final IconData iconData;
  final Color color;
  final double size;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Icon(iconData, color: color, size: 15),
    );
  }
}
