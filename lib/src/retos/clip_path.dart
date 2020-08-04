import 'package:flutter/material.dart';

class CorazonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _Corazon(),
      ),
    );
  }
}

class _Corazon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: Rectangulo(),
      clipper: DashClipper(),
    );
  }
}

class DashClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
    Path path = Path();
    path.moveTo(width * 0.5, height * 0.20);
    //path.quadraticBezierTo(width * 0.45, height * 0.1, width * 0.25, 0);
    path.quadraticBezierTo(width * 0.40, height * 0, width * 0.25, 0);
    path.quadraticBezierTo(width * 0.0, height * 0, 0, height * 0.25);
    path.quadraticBezierTo(width * 0, height * 0.65, width * 0.5, size.height);
    path.quadraticBezierTo(width * 1, height * 0.65, width, height * 0.25);
    path.quadraticBezierTo(width, 0, width * 0.75, 0);
    path.quadraticBezierTo(width * 0.6, height * 0, width * 0.5, height * 0.20);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class Rectangulo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(color: Colors.red),
    );
  }
}
