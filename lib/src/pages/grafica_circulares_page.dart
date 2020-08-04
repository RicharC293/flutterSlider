import 'package:animaciones/src/widgets/radial_progres.dart';
import 'package:flutter/material.dart';

class GraficasCircularesPage extends StatefulWidget {
  @override
  _GraficasCircularesPageState createState() => _GraficasCircularesPageState();
}

class _GraficasCircularesPageState extends State<GraficasCircularesPage> {
  double porcentajeSalto = 25.0;
  double porcentaje = 0.0;

  void cambio() {
    setState(() {
      porcentaje = porcentajeSalto + porcentaje;
      if (porcentaje > 100) {
        porcentaje = 0;
      }
      print(porcentaje);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            porcentaje = porcentajeSalto + porcentaje;
            if (porcentaje > 100) {
              porcentaje = 0;
            }
            print(porcentaje);
          });
        },
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black87,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CustomRadialProgress(
                  porcentaje: porcentaje,
                  color: Colors.blue,
                ),
                CustomRadialProgress(porcentaje: porcentaje, color: Colors.red),
              ],
            ),
            Divider(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CustomRadialProgress(
                  porcentaje: porcentaje,
                  color: Colors.yellow,
                ),
                CustomRadialProgress(
                  porcentaje: porcentaje,
                  color: Colors.pink,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRadialProgress extends StatelessWidget {
  final Color color;

  const CustomRadialProgress({
    Key key,
    @required this.porcentaje,
    @required this.color,
  }) : super(key: key);

  final double porcentaje;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      child: RadialProgres(
        porcentaje: porcentaje,
        duration: Duration(milliseconds: 2000),
        colorPrimario: color,
        colorSecundario: Colors.grey,
        borderWidth: 5,
        colorWidth: 10,
        // gradiente: LinearGradient(colors: <Color>[
        //   Colors.red,
        //   Colors.blue,
        //   Colors.pink,
        // ]),
      ),
    );
  }
}
