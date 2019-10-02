import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DibujarCurva0 extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    var paint = Paint();

    paint.color = Color.fromRGBO(37, 176, 232, 0.91);
    paint.style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0, size.height * 0.775);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.775,size.width * 0.35, size.height * 0.815);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584, size.width * 1.0, size.height * 0.717);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);

    var paint1 = Paint();
    paint1.color = Color.fromRGBO(41, 250, 255, 0.50);
    paint1.style = PaintingStyle.fill;

    var path1 = Path();
    path1.moveTo(0, size.height * 0.9167);
    path1.quadraticBezierTo(size.width * 0.25, size.height * 0.875,size.width * 0.5, size.height * 0.9167);
    path1.quadraticBezierTo(size.width * 0.75, size.height * 0.9584, size.width * 1.0, size.height * 0.9167);
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);

    canvas.drawPath(path1, paint1);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}