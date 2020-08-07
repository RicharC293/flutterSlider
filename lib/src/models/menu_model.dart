import 'package:flutter/material.dart';

class MenuModel with ChangeNotifier {
  bool _mostrar = true;

  bool get mostrar => this._mostrar;
  set mostrar(bool mostrar) {
    this._mostrar = mostrar;
    notifyListeners();
  }
}
