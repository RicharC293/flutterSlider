import 'package:animaciones/src/widgets/slideshow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SlideshowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: _MySlideShow(),
          ),
          Expanded(
            child: _MySlideShow(),
          ),
        ],
      ),
    );
  }
}

class _MySlideShow extends StatelessWidget {
  const _MySlideShow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SlideShow(
          colorDotSelected: Colors.purple,
          sizeDotPrimario: 15,
          paddingDot: 5.0,
          slides: <Widget>[
            SvgPicture.asset('assets/svg/1.svg'),
            SvgPicture.asset('assets/svg/2.svg'),
            SvgPicture.asset('assets/svg/3.svg'),
          ],
        ),
      ),
    );
  }
}
