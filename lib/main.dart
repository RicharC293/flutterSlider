import 'package:animaciones/src/pages/animaciones_page.dart';
import 'package:animaciones/src/labs/circular_progress_page.dart';
import 'package:animaciones/src/pages/grafica_circulares_page.dart';
import 'package:animaciones/src/labs/slideShow_page.dart';
import 'package:animaciones/src/pages/slideShow_page.dart';
import 'package:animaciones/src/retos/clip_path.dart';
import 'package:animaciones/src/retos/cuadrado_animado.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: SlideshowPage(),
    );
  }
}
