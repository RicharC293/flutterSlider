import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimacionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CuadradoAnimado(),
      ),
    );
  }
}

class CuadradoAnimado extends StatefulWidget {
  @override
  _CuadradoAnimadoState createState() => _CuadradoAnimadoState();
}

class _CuadradoAnimadoState extends State<CuadradoAnimado>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> rotate;
  Animation<double> opacity;
  Animation<double> opacityOut;
  Animation<double> move;
  Animation<double> scale;

  @override
  void initState() {
    _animationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 4000),
    );
    //Se aplica la rotación
    rotate = Tween(begin: 0.0, end: 2 * math.pi).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.ease));
    //Se aplica la opacidad
    opacity = Tween(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.0,
          0.25,
          //curve: Curves.bounceInOut,
        ),
      ),
    );
    //Se aplica el fade
    opacityOut = Tween(begin: 0.75, end: 0.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.750,
          1.00,
          //curve: Curves.bounceInOut,
        ),
      ),
    );
    //Se mueve el cuadro
    move = Tween(begin: 0.0, end: 100.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.ease));
    //Escalar el cuadrado
    scale = Tween(begin: 0.2, end: 2.0).animate(_animationController);

    _animationController.addListener(() {
      print('Listener: ${_animationController.status}');
      if (_animationController.status == AnimationStatus.completed) {
        //_animationController.reverse();
        _animationController.reset();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Iniciar la animación
    _animationController.forward();
    //repetir
    //_animationController.repeat();

    return AnimatedBuilder(
      animation: _animationController,
      child: _Rectangulo(),
      builder: (BuildContext context, Widget child) {
        return Transform.translate(
          offset: Offset(move.value, 0),
          child: Transform.rotate(
            angle: rotate.value,
            child: Opacity(
                opacity: opacity.value,
                child: Transform.scale(
                    scale: scale.value,
                    child: Opacity(opacity: opacityOut.value, child: child))),
          ),
        );
      },
    );
  }
}

class _Rectangulo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(color: Colors.blue),
    );
  }
}
