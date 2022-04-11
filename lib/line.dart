import 'package:flutter/material.dart';
import 'utils.dart';

class Line extends CustomPainter {
  bool isFromTopLeft = true;
  List<MapLine> mapLines = [];
  List<MapArc> mapArcs = [];

  Line({this.mapLines, this.mapArcs});

  @override
  void paint(Canvas canvas, Size size) {
    for (var element in mapLines) {
      print("draw line, ${element.name}");
      if (element.nodes.length >= 2) {
        var paint = Paint();
        paint.color = Colors.red;
        paint.strokeWidth = 5;
        paint.style = PaintingStyle.stroke;
        canvas.drawLine(
          Offset(element.nodes[0].x, element.nodes[0].y),
          Offset(element.nodes[1].x, element.nodes[1].y),
          paint,
        );
      }
    }

    for (var element in mapArcs) {
      print("draw arc, ${element.name},${element.nodes.length}");
      print(
          "draw arc pointer, ${element.nodes[0].x},${element.nodes[0].y} y: ${element.nodes[1].x},${element.nodes[1].y}");
      if (element.nodes.length >= 2) {
        var paint = Paint();
        paint.color = Colors.blue;
        paint.style = PaintingStyle.stroke;
        // paint
        paint.strokeWidth = 5;
        paint.strokeCap = StrokeCap.round;

        // canvas.drawLine(
        //   Offset(element.nodes[0].x, element.nodes[0].y),
        //   Offset(element.nodes[1].x, element.nodes[1].y),
        //   paint,
        // );
        var startPoint = Offset(element.nodes[0].x, element.nodes[0].y);
        double cpx = 0;
        double cpy = 0;
        if (element.type == ArcType.cw) {
          // 顺时针
          cpx = element.nodes[0].x;
          cpy = element.nodes[1].y;
        } else {
          cpx = element.nodes[1].x;
          cpy = element.nodes[0].y;
        }
        // var controlPoint1 = Offset(size.width / 2, size.height / 2);
        var controlPoint1 = Offset(cpx, cpy);
        // var controlPoint2 = Offset(3 * size.width / 4, size.height / 3);
        var endPoint = Offset(element.nodes[1].x, element.nodes[1].y);

        var path = Path()
          ..moveTo(startPoint.dx, startPoint.dy)
          ..quadraticBezierTo(
              controlPoint1.dx,
              controlPoint1.dy,
              // controlPoint1.dx, controlPoint1.dy,
              endPoint.dx,
              endPoint.dy)
          ..lineTo(endPoint.dx, endPoint.dy);

        // canvas.drawArc(Rect.fromPoints(startPoint, endPoint), 0, 45, false, paint);
        // path.close();
        // canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint)
        canvas.drawPath(path, paint);
      }
    }

    return;

    var paint = Paint();

    paint.color = Colors.lightBlue;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3;

    var startPoint = Offset(0, 0);
    var controlPoint1 = Offset(size.width / 2, size.height / 2);
    // var controlPoint2 = Offset(3 * size.width / 4, size.height / 3);
    var endPoint = Offset(size.width, size.height);

    var path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint1.dx,
        controlPoint1.dy, endPoint.dx, endPoint.dy);

    canvas.drawPath(path, paint);
    return;
    // paint.color = Colors.amber;
    paint.color = Colors.green;
    paint.strokeWidth = 5;
    if (isFromTopLeft) {
      var path = Path();
      path.moveTo(0, size.height * 0.84);
      path.quadraticBezierTo(size.width * 0.25, size.height * 0.77,
          size.width * 0.52, size.height * 0.84);
      path.quadraticBezierTo(size.width * 0.74, size.height * 0.92, size.width,
          size.height * 0.84);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.close();
      // paint.color = AppColors.primaryColor.withOpacity(0.70);
      canvas.drawPath(path, paint);
      // canvas.drawCircle(Offset(0.0,0), 61, paint);
      // canvas.drawLine(
      //   Offset(0, 0),
      //   Offset(size.width, size.height),
      //   paint,
      // );
    } else {
      canvas.drawLine(
        Offset(0, size.height),
        Offset(size.width, 0),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
