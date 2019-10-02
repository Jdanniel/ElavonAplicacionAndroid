import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DibujarCurva1 extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    var paint = Paint();

    paint.color = Colors.blueGrey;
    paint.style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0, size.height * 0.275);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.775, size.width * 0.75, size.height * 0.815);
    path.quadraticBezierTo(size.width * 0.45, size.height * 0.7584, size.width * 1.5, size.height * 0.717);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}