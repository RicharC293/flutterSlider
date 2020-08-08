import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconHeader extends StatelessWidget {
  final IconData icon;
  final String titulo;
  final String subtitulo;
  final Color color1;
  final Color color2;

  const IconHeader({
    Key key,
    @required this.icon,
    @required this.titulo,
    @required this.subtitulo,
    this.color1 = Colors.blue,
    this.color2 = Colors.green,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        _HeaderBackground(
          size: size,
          color1: this.color1,
          color2: this.color2,
        ),
        Positioned(
          left: -size.width * 0.18,
          top: -size.height * 0.08,
          child: FaIcon(
            this.icon,
            size: size.width * 0.6,
            color: Colors.white.withOpacity(0.2),
          ),
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: size.height * 0.093,
              width: double.infinity,
            ),
            Text(
              this.titulo,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: size.width * 0.05,
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              this.subtitulo,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: size.width * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            FaIcon(
              this.icon,
              color: Colors.white,
              size: size.width * 0.2,
            ),
          ],
        )
      ],
    );
  }
}

class _HeaderBackground extends StatelessWidget {
  const _HeaderBackground({
    Key key,
    @required this.size,
    @required this.color1,
    @required this.color2,
  }) : super(key: key);

  final Size size;
  final Color color1;
  final Color color2;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size.height * 0.40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            this.color1,
            this.color2,
          ],
        ),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
      ),
    );
  }
}
