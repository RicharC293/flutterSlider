import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomButton {
  final Function onPressed;
  final IconData icon;

  CustomButton({
    @required this.onPressed,
    @required this.icon,
  });
}

class CustomMenu extends StatelessWidget {
  final bool mostrar;
  final Color iconColor;
  final Color backgroundColor;
  final Color activeIconColor;
  final List<CustomButton> items;

  CustomMenu({
    Key key,
    @required this.items,
    this.mostrar = true,
    this.iconColor = Colors.blueGrey,
    this.backgroundColor = Colors.white,
    this.activeIconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return new _MenuModel();
      },
      child: Builder(
        builder: (BuildContext context) {
          Provider.of<_MenuModel>(context).backgroundColor =
              this.backgroundColor;
          Provider.of<_MenuModel>(context).iconColor = this.iconColor;
          Provider.of<_MenuModel>(context).activeIconColor =
              this.activeIconColor;
          return AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: (mostrar) ? 1 : 0,
            child: _MenuContainer(
              child: _MenuItems(menuItems: items),
            ),
          );
        },
      ),
    );
  }
}

class _MenuContainer extends StatelessWidget {
  final Widget child;
  const _MenuContainer({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<_MenuModel>(context);
    return Container(
      width: 250,
      height: 60,
      decoration: BoxDecoration(
        color: provider.backgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black38,
            blurRadius: 20.0,
            spreadRadius: -5,
          )
        ],
      ),
      child: child,
    );
  }
}

class _MenuItems extends StatelessWidget {
  final List<CustomButton> menuItems;

  const _MenuItems({Key key, this.menuItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        menuItems.length,
        (index) => _MenuButton(
          index: index,
          item: menuItems[index],
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final int index;
  final CustomButton item;

  const _MenuButton({Key key, this.index, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //NOTA SI TE APARECE UN ERROR COLOCAR EL LISTEN DEL PROVIDER EN FALSO
    final provider = Provider.of<_MenuModel>(context);

    return GestureDetector(
      onTap: () {
        provider.itemSeleccionado = this.index;
        item.onPressed();
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        child: Icon(item.icon,
            size: (provider.itemSeleccionado == index) ? 35.0 : 25.0,
            color: (provider.itemSeleccionado == index)
                ? provider.activeIconColor
                : provider.iconColor),
      ),
    );
  }
}

class _MenuModel with ChangeNotifier {
  int _itemSeleccionado = 0;
  Color _iconColor = Colors.blueGrey;
  Color _activeIconColor = Colors.black;
  Color _backgroundColor = Colors.white;

  int get itemSeleccionado => this._itemSeleccionado;

  set itemSeleccionado(int index) {
    this._itemSeleccionado = index;
    notifyListeners();
  }

  Color get iconColor => this._iconColor;

  set iconColor(Color color) {
    this._iconColor = color;
  }

  Color get activeIconColor => this._activeIconColor;

  set activeIconColor(Color color) {
    this._activeIconColor = color;
  }

  Color get backgroundColor => this._backgroundColor;

  set backgroundColor(Color color) {
    this._backgroundColor = color;
  }
}
