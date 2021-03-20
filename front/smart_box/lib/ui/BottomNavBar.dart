import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({this.selectedIndex, this.setBottomBarIndex});

  int selectedIndex;
  Function(int) setBottomBarIndex;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.bottomCenter,
      width: size.width,
      child: Stack(
        // overflow: Overflow.visible,
        children: [
          CustomPaint(
            size: Size(size.width, size.height),
            painter: MyCustomPainter(),
          ),
          Container(
            width: size.width,
            height: size.height * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FlatButton(
                  onPressed: () {
                    widget.setBottomBarIndex(0);
                  },
                  child: Container(
                    width: size.width * 0.13,
                    height: size.height * 0.1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: widget.selectedIndex == 0
                            ? AssetImage('images/onBox.png')
                            : AssetImage('images/offBox.png'),
                      ),
                    ),
                  ),
                ),
                FlatButton(
                  height: 20,
                  onPressed: () {
                    widget.setBottomBarIndex(1);
                  },
                  child: Container(
                    width: size.width * 0.31,
                    height: size.height * 0.2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/reader.png'),
                      ),
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    widget.setBottomBarIndex(2);
                  },
                  child: Container(
                    width: size.width * 0.13,
                    height: size.height * 0.1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: widget.selectedIndex == 2
                            ? AssetImage('images/onPrint.png')
                            : AssetImage('images/offPrint.png'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.black12.withAlpha(40)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    Path path = Path();
    path.moveTo(0, 10); // Start
    path.lineTo(size.width * 0.35, 10);
    path.quadraticBezierTo(size.width * 0.4, -20, size.width * 0.5, -20);
    path.quadraticBezierTo(size.width * 0.6, -20, size.width * 0.65, 10);
    path.lineTo(size.width, 10);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);

    paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    path = Path();
    path.moveTo(0, 10); // Start
    path.lineTo(size.width * 0.35, 10);
    path.quadraticBezierTo(size.width * 0.4, -20, size.width * 0.5, -20);
    path.quadraticBezierTo(size.width * 0.6, -20, size.width * 0.65, 10);
    path.lineTo(size.width, 10);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
