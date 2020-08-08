import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color1;
  final Color color2;
  final Function onPressed;

  const CustomButton({
    Key key,
    @required this.icon,
    @required this.title,
    this.color1 = Colors.blue,
    this.color2 = Colors.orange,
    @required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _CustomButtomBackground(
          icon: this.icon,
          color1: this.color1,
          color2: this.color2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 140,
              width: 40,
            ),
            FaIcon(
              this.icon,
              color: Colors.white,
              size: 40,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Text(
              this.title,
              style: TextStyle(
                color: Colors.white,
              ),
            )),
            GestureDetector(
              onTap: this.onPressed,
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 25,
              ),
            ),
            SizedBox(
              width: 40,
            )
          ],
        )
      ],
    );
  }
}

class _CustomButtomBackground extends StatelessWidget {
  final Color color1;
  final Color color2;
  final IconData icon;
  const _CustomButtomBackground({
    Key key,
    @required this.color1,
    @required this.color2,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(4, 6),
            blurRadius: 10,
          )
        ],
        gradient: LinearGradient(colors: <Color>[
          this.color1,
          this.color2,
        ]),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -25,
              right: -20,
              child: FaIcon(
                this.icon,
                color: Colors.white.withOpacity(0.25),
                size: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
