import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgres extends StatefulWidget {
  final double porcentaje;
  final Color colorPrimario;
  final Color colorSecundario;
  final double borderWidth;
  final double colorWidth;
  final bool continuo;
  final Duration duration;
  final Gradient gradiente;

  RadialProgres({
    Key key,
    @required this.porcentaje,
    this.colorPrimario = Colors.blue,
    this.colorSecundario = Colors.grey,
    @required this.borderWidth,
    @required this.colorWidth,
    this.continuo = false,
    @required this.duration,
    this.gradiente,
  }) : super(key: key);

  @override
  _RadialProgresState createState() => _RadialProgresState();
}

class _RadialProgresState extends State<RadialProgres>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  double porcentajeAnterior;
  @override
  void initState() {
    porcentajeAnterior = widget.porcentaje;

    _animationController =
        new AnimationController(vsync: this, duration: widget.duration);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward(from: 0.0);

    final diferenciaAnimar = widget.porcentaje - porcentajeAnterior;
    porcentajeAnterior = widget.porcentaje;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget child) {
        if (widget.continuo == true) {
          double valorCargar = _animationController.value * 100;
          if (valorCargar == widget.porcentaje) {
            _animationController.stop();
            //_animationController.reset();
            //_animationController.forward(from: 0.0);
          }
        }
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: _MiRadialProgress(
              porcentaje: (widget.continuo == false)
                  ? ((widget.porcentaje - diferenciaAnimar) +
                      (diferenciaAnimar * _animationController.value))
                  : (_animationController.value * 100),
              colorPrimario: widget.colorPrimario,
              colorSecundario: widget.colorSecundario,
              borderWidth: widget.borderWidth,
              colorWidth: widget.colorWidth,
              gradient: widget.gradiente,
            ),
          ),
        );
      },
    );
  }
}

class _MiRadialProgress extends CustomPainter {
  final porcentaje;
  final Color colorPrimario;
  final Color colorSecundario;
  final double borderWidth;
  final double colorWidth;
  final Gradient gradient;

  _MiRadialProgress(
      {@required this.gradient,
      @required this.colorPrimario,
      @required this.colorSecundario,
      @required this.borderWidth,
      @required this.colorWidth,
      this.porcentaje});

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = new Rect.fromCircle(
      center: Offset(0, 0),
      radius: 180,
    );
    //Dibujar un círculo
    final paint = new Paint()
      ..strokeWidth = borderWidth
      ..strokeCap = StrokeCap.round
      ..color = colorSecundario
      ..style = PaintingStyle.stroke;
    Offset center = new Offset(size.width * 0.5, size.height * 0.5);
    double radio = min(size.width * 0.5, size.height * 0.5);
    canvas.drawCircle(center, radio, paint);
    //Arco
    final paintArco = new Paint()
      ..strokeWidth = colorWidth
      ..shader = (gradient == null) ? null : gradient.createShader(rect)
      ..color = colorPrimario
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = MaskFilter.blur(BlurStyle.solid, 2.5);

    double arcAngle = 2 * pi * (porcentaje / 100);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radio),
      -pi / 2,
      arcAngle,
      false,
      paintArco,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
