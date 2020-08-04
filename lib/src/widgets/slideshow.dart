import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlideShow extends StatelessWidget {
  final List<Widget> slides;
  final Color colorDotSelected;
  final Color colorDot;
  final bool upDot;
  final BoxShape dotForm;
  final double paddingDot;
  final double sizeDotPrimario;
  final double sizeDotSecundario;

  const SlideShow({
    Key key,
    @required this.slides,
    this.colorDot = Colors.grey,
    this.upDot = false,
    this.colorDotSelected = Colors.blue,
    this.dotForm = BoxShape.circle,
    this.paddingDot = 5.0,
    this.sizeDotPrimario = 12.0,
    this.sizeDotSecundario = 12.0,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return new _SlideShowModel();
      },
      child: SafeArea(
        child: Center(
          child: Builder(
            builder: (BuildContext context) {
              Provider.of<_SlideShowModel>(context).dotColor = this.colorDot;
              Provider.of<_SlideShowModel>(context).dotColorSelected =
                  this.colorDotSelected;
              Provider.of<_SlideShowModel>(context).dotPrimario =
                  this.sizeDotPrimario;
              Provider.of<_SlideShowModel>(context).dotSecundario =
                  this.sizeDotSecundario;
              return _CrearSlideshowStructure(
                  upDot: upDot,
                  slides: slides,
                  dotForm: dotForm,
                  paddingDot: paddingDot);
            },
          ),
        ),
      ),
    );
  }
}

class _CrearSlideshowStructure extends StatelessWidget {
  const _CrearSlideshowStructure({
    Key key,
    @required this.upDot,
    @required this.slides,
    @required this.dotForm,
    @required this.paddingDot,
  }) : super(key: key);

  final bool upDot;
  final List<Widget> slides;
  final BoxShape dotForm;
  final double paddingDot;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (this.upDot)
          _Dots(
            numDots: this.slides.length,
            dotForm: this.dotForm,
            paddingDot: this.paddingDot,
          ),
        Expanded(
          child: _Slides(slides: this.slides),
        ),
        if (!this.upDot)
          _Dots(
              numDots: this.slides.length,
              dotForm: this.dotForm,
              paddingDot: this.paddingDot),
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  final int numDots;
  final BoxShape dotForm;
  final double paddingDot;

  const _Dots(
      {Key key,
      @required this.numDots,
      @required this.dotForm,
      @required this.paddingDot})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          this.numDots,
          (index) => _Dot(
            index: index,
            dotForm: this.dotForm,
            paddingDot: this.paddingDot,
          ),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;
  final BoxShape dotForm;
  final double paddingDot;
  const _Dot({
    Key key,
    this.index,
    @required this.dotForm,
    @required this.paddingDot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final slideShowModel = Provider.of<_SlideShowModel>(context);
    double tamano;
    Color color;
    if (slideShowModel.currentPage >= index - 0.5 &&
        slideShowModel.currentPage < index + 0.5) {
      tamano = slideShowModel.dotPrimario;
      color = slideShowModel.dotColorSelected;
    } else {
      tamano = slideShowModel.dotSecundario;
      color = slideShowModel.dotColor;
    }
    return GestureDetector(
      onTap: () {
        slideShowModel.currentPage = index.toDouble();
        slideShowModel.pageviewController.animateToPage(index,
            duration: Duration(milliseconds: 400), curve: Curves.bounceIn);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        width: tamano,
        height: tamano,
        margin: EdgeInsets.symmetric(horizontal: this.paddingDot),
        decoration: BoxDecoration(
          color: color,
          shape: this.dotForm,
        ),
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;

  const _Slides({Key key, this.slides}) : super(key: key);
  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {
  final pageViewController = new PageController();

  @override
  void initState() {
    Provider.of<_SlideShowModel>(context, listen: false).pageviewController =
        pageViewController;
    pageViewController.addListener(() {
      Provider.of<_SlideShowModel>(context, listen: false).currentPage =
          pageViewController.page;
    });

    super.initState();
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller: pageViewController,
        physics: BouncingScrollPhysics(),
        children: widget.slides.map((slide) => _Slide(slide: slide)).toList(),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;

  const _Slide({Key key, this.slide}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(30),
      child: slide,
    );
  }
}

class _SlideShowModel with ChangeNotifier {
  double _currentPage = 0;
  Color _dotColor = Colors.grey;
  Color _dotColorSelected = Colors.blue;
  double _dotPrimario = 12.0;
  double _dotSecundario = 12.0;
  PageController _pageViewController;

  double get currentPage => this._currentPage;
  set currentPage(double currentPage) {
    this._currentPage = currentPage;
    notifyListeners();
  }

  PageController get pageviewController => this._pageViewController;
  set pageviewController(PageController pageviewController) {
    this._pageViewController = pageviewController;
  }

  Color get dotColor => this._dotColor;
  set dotColor(Color dotColor) {
    this._dotColor = dotColor;
  }

  Color get dotColorSelected => this._dotColorSelected;
  set dotColorSelected(Color dotColorSelected) {
    this._dotColorSelected = dotColorSelected;
  }

  double get dotPrimario => this._dotPrimario;
  set dotPrimario(double dotPrimario) {
    this._dotPrimario = dotPrimario;
  }

  double get dotSecundario => this._dotSecundario;
  set dotSecundario(double dotSecundario) {
    this._dotSecundario = dotSecundario;
  }
}
