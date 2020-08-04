import 'package:flutter/material.dart';

class CuadradoAnimadoPage extends StatelessWidget {
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
  Animation<double> mov1;
  Animation<double> mov2;
  Animation<double> mov3;
  Animation<double> mov4;

  @override
  void initState() {
    _animationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 4500),
    );
    //Movimiento Horizontal 1
    mov1 = Tween(begin: 0.0, end: 100.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.25,
        curve: Curves.bounceOut,
      ),
    ));
    mov2 = Tween(begin: 0.0, end: -100.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.25,
        0.50,
        curve: Curves.bounceOut,
      ),
    ));
    mov3 = Tween(begin: 0.0, end: 100.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.50,
        0.75,
        curve: Curves.bounceOut,
      ),
    ));
    mov4 = Tween(begin: 0.0, end: 100.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.75,
        1.00,
        curve: Curves.bounceOut,
      ),
    ));

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
    return AnimatedBuilder(
      animation: _animationController,
      child: _Rectangulo(),
      builder: (BuildContext context, Widget child) {
        return Transform.translate(
          offset: Offset(mov1.value - mov3.value, mov2.value + mov4.value),
          child: child,
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
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(35.0)),
    );
  }
}
