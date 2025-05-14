import 'package:flutter/cupertino.dart';

class BackgroundRightClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(size.width, 0);

    path.lineTo(size.width, size.height);

    path.lineTo(0, size.height);
    // Close the path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


class BackgroundLeftClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(size.width, 0);

    path.lineTo(0, size.height);
    // Close the path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}