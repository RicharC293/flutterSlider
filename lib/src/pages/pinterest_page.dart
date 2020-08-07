import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import 'package:animaciones/src/models/menu_model.dart';
import 'package:animaciones/src/widgets/custom_menu.dart';

class PinterestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return new MenuModel();
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            PinterestGrid(),
            _PinterestMenu(),
          ],
        ),
      ),
    );
  }
}

class _PinterestMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mostrar = Provider.of<MenuModel>(context).mostrar;
    return Positioned(
      bottom: 30,
      child: Container(
        width: size.width,
        child: Align(
          child: CustomMenu(
            items: <CustomButton>[
              CustomButton(
                icon: Icons.pie_chart,
                onPressed: () {
                  print('Pressed pie_chart');
                },
              ),
              CustomButton(
                icon: Icons.search,
                onPressed: () {
                  print('Pressed search');
                },
              ),
              CustomButton(
                icon: Icons.notifications,
                onPressed: () {
                  print('Pressed notifications');
                },
              ),
              CustomButton(
                icon: Icons.supervised_user_circle,
                onPressed: () {
                  print('Pressed supervised_user_circle');
                },
              ),
            ],
            mostrar: mostrar,
            backgroundColor: Colors.white,
            iconColor: Colors.grey,
            activeIconColor: Colors.red,
          ),
        ),
      ),
    );
  }
}

class PinterestGrid extends StatefulWidget {
  @override
  _PinterestGridState createState() => _PinterestGridState();
}

class _PinterestGridState extends State<PinterestGrid> {
  //Número de Items
  final List items = List.generate(200, (index) => index);

  ScrollController scrollController = new ScrollController();
  double scrollAnterior = 0;
  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.offset <= 0) {
        Provider.of<MenuModel>(context, listen: false).mostrar = true;
      } else {
        if (scrollController.offset > scrollAnterior) {
          Provider.of<MenuModel>(context, listen: false).mostrar = false;
        } else {
          Provider.of<MenuModel>(context, listen: false).mostrar = true;
        }
      }

      scrollAnterior = scrollController.offset;
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      controller: scrollController,
      physics: BouncingScrollPhysics(),
      crossAxisCount: 4,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) => _PinterestItem(
        index: index,
      ),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index.isEven ? 2 : 1),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}

class _PinterestItem extends StatelessWidget {
  final int index;
  const _PinterestItem({
    Key key,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(20),
      ),
      child: new Center(
        child: new CircleAvatar(
          backgroundColor: Colors.white,
          child: new Text('$index'),
        ),
      ),
    );
  }
}
