import 'package:flutter/material.dart';

class SliverListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: _Header(),
      //body: _MiLista(),
      body: Stack(
        children: <Widget>[
          _MainScroll(),
          Positioned(bottom: -10, right: 0, child: _Footer()),
        ],
      ),
    );
  }
}

class _MainScroll extends StatelessWidget {
  final items = [
    _Tarjeta('Orange', Color(0xffF08F66)),
    _Tarjeta('Family', Color(0xffF2A38A)),
    _Tarjeta('Subscriptions', Color(0xffF7CDD5)),
    _Tarjeta('Books', Color(0xffFCEBAF)),
    _Tarjeta('Orange', Color(0xffF08F66)),
    _Tarjeta('Family', Color(0xffF2A38A)),
    _Tarjeta('Subscriptions', Color(0xffF7CDD5)),
    _Tarjeta('Books', Color(0xffFCEBAF)),
  ];
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          floating: true,
          delegate: _SliverCustomHeaderDelegate(
            maxHeight: 200,
            minHeight: 150,
            child: _Header(),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            ...items,
            SizedBox(height: 100),
          ]),
        ),
      ],
    );
  }
}

class _SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;
  _SliverCustomHeaderDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(
      child: this.child,
    );
  }

  @override
  double get maxExtent =>
      (this.minHeight > this.maxHeight) ? this.minHeight : this.maxHeight;

  @override
  double get minExtent => this.minHeight;

  @override
  bool shouldRebuild(_SliverCustomHeaderDelegate oldDelegate) {
    return this.maxHeight != oldDelegate.maxHeight ||
        this.minHeight != oldDelegate.minHeight ||
        this.child != oldDelegate.child;
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.only(left: 30),
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'New',
                style: TextStyle(
                  color: Color(0xff532128),
                  fontSize: 40,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Stack(
              children: <Widget>[
                Positioned(
                  top: 32,
                  left: 10,
                  child: Container(
                    height: 8,
                    width: 100,
                    color: Color(0xffF7CDD5),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  width: double.infinity,
                  child: Text(
                    'List',
                    style: TextStyle(
                      color: Color(0xffD93A30),
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MiLista extends StatelessWidget {
  final items = [
    _Tarjeta('Orange', Color(0xffF08F66)),
    _Tarjeta('Family', Color(0xffF2A38A)),
    _Tarjeta('Subscriptions', Color(0xffF7CDD5)),
    _Tarjeta('Books', Color(0xffFCEBAF)),
    _Tarjeta('Orange', Color(0xffF08F66)),
    _Tarjeta('Family', Color(0xffF2A38A)),
    _Tarjeta('Subscriptions', Color(0xffF7CDD5)),
    _Tarjeta('Books', Color(0xffFCEBAF)),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return items[index];
      },
    );
  }
}

class _Tarjeta extends StatelessWidget {
  final String titulo;
  final Color color;

  const _Tarjeta(
    this.titulo,
    this.color,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 30),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: this.color,
      ),
      child: Text(
        this.titulo,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      height: size.height * 0.12,
      child: RaisedButton(
        color: Color(0xffED6762),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
          ),
        ),
        onPressed: () {},
        child: Text(
          'CREATE NEW LIST',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
      ),
    );
  }
}
