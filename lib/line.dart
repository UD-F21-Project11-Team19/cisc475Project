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

        var controlPoint1 = Offset(cpx, cpy);

        var endPoint = Offset(element.nodes[1].x, element.nodes[1].y);

        var path = Path()
          ..moveTo(startPoint.dx, startPoint.dy)
          ..quadraticBezierTo(
              controlPoint1.dx, controlPoint1.dy, endPoint.dx, endPoint.dy)
          ..lineTo(endPoint.dx, endPoint.dy);

        canvas.drawPath(path, paint);
      }
    }

    return;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
