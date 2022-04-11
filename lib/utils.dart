import 'dart:math';

import 'data.dart';

class MapConvert {
  double xMid = 0;
  double yMid = 0;
  double step = 0;
  double xBase = 0;
  double yBase = 0;

  MapConvert({this.xMid, this.yMid, this.step, this.xBase, this.yBase});

  MapConvert.fromCsv({double mapWidth, double mapHeight, double padding}) {
    double xMin = 0;
    double xMax = 0;
    double yMin = 0;
    double yMax = 0;
    dataNodes.split('\n').toList().forEach((e) {
      var list = e.split(',').toList();
      if (list.length >= 4) {
        try {
          double x = double.parse(list[1]);
          double y = double.parse(list[2]);
          xMin = min(xMin, x);
          xMax = max(xMax, x);
          yMin = min(yMin, y);
          yMax = max(yMax, y);
        } catch (e) {
          print(e);
        }
      }
    });
    double xStep = xMin.abs() + xMax.abs();
    double yStep = yMin.abs() + yMax.abs();
    xMid = (xMax + xMin) / 2;
    yMid = (yMax + yMin) / 2;
    step = max(xStep, yStep).ceil().toDouble();
    xBase = mapWidth / step;
    yBase = mapHeight / step;
    print("nodes, $xMax,$xMin,$xStep, $xMid, $yMax, $yMin, $yStep, $yMid");
    // MapCover(xMid: xMid,yMid: yMid, step: step,xBase: xBase,yBase: yBase);
  }
}

class MapLine {
  String name = '';
  double index = 0;
  List<MapNode> nodes = [];

  MapLine.fromCsvRow(List<String> csvRow, MapConvert mapConvert) {
    name = csvRow[1];
    index = double.parse(csvRow[0]);
    nodes = [
      MapNode.fromCsvRow(
          xSt: csvRow[4], ySt: csvRow[5], mapConvert: mapConvert),
      MapNode.fromCsvRow(xSt: csvRow[6], ySt: csvRow[7], mapConvert: mapConvert)
    ];
  }

  static List<MapLine> fromCsv(MapConvert mapConvert) {
    return MapNode.parseCsv(dataLines, minLen: 13)
        .map((e) => MapLine.fromCsvRow(e, mapConvert))
        .toList();
  }
}

enum ArcType {
  /**
   * 顺时针旋转
   */
  cw,
  /**
   * 逆时针旋转
   */
  ccw
}

/**
 * 曲线
 */
class MapArc {
  String name = '';
  double index = 0;

  /**
   * 旋转方向
   */
  ArcType type = ArcType.cw;
  List<MapNode> nodes = [];
  List<MapNode> angles = [];

  MapArc({this.name, this.index, this.nodes, this.angles});

  MapArc.fromCsvRow(List<String> csvRow, MapConvert mapConvert) {
    name = csvRow[1];
    index = double.parse(csvRow[0]);
    type = csvRow[7] == 'CCW' ? ArcType.ccw : ArcType.cw;
    nodes = [
      MapNode.fromCsvRow(
          xSt: csvRow[8], ySt: csvRow[9], mapConvert: mapConvert),
      MapNode.fromCsvRow(
          xSt: csvRow[10], ySt: csvRow[11], mapConvert: mapConvert)
    ];
    angles = [
      MapNode.fromCsvRow(
          xSt: csvRow[5], ySt: csvRow[6], mapConvert: mapConvert),
    ];
  }

  static List<MapArc> fromCsv(MapConvert mapConvert) {
    return MapNode.parseCsv(dataArcs, minLen: 16)
        .map((e) => MapArc.fromCsvRow(e, mapConvert))
        .toList();
  }
}

class MapNode {
  String name = '';
  double x = 0;
  double y = 0;
  double index = 0;
  MapNode({this.name, this.x, this.y, this.index});

  MapNode.fromCsvRow(
      {this.name = '',
      String indexSt = "0",
      String xSt,
      String ySt,
      MapConvert mapConvert}) {
    // name = csvRow[3];
    // 整体按照 10 的单位来算
    try {
      index = double.parse(indexSt);
      double half = mapConvert.step / 2;
      double _x = double.parse(xSt); // 大于0的在左边，小于0的右边
      _x -= mapConvert.xMid;
      // double _xHalf = (step - xMid ) / 2;
      // print("x half $_x");
      x = _x > 0
          ? (half - _x) * mapConvert.xBase
          : (half + _x.abs()) * mapConvert.xBase;

      double _y = double.parse(ySt); // 小于0的在上面，大于0的在下面
      _y -= mapConvert.yMid;
      // double _yHalf = (step - yMid) / 2;
      // print("y half $_y");
      y = _y < 0
          ? (half - _y.abs()) * mapConvert.yBase
          : (half + _y) * mapConvert.yBase;
      // index = double.parse(csvRow[4]);

    } catch (e) {
      print("error $e");
    }
  }

  static List<List<String>> parseCsv(String csvText,
      {int minLen, bool skipFirst = true}) {
    List<List<String>> nodeList = [];

    int i = 0;
    csvText.split('\n').toList().forEach((e) {
      if (i > 0 || !skipFirst) {
        var list = e.split(',').toList();
        // print("nodelist list,${list},${i}");
        if (list.length >= minLen) {
          try {
            nodeList.add(list);
          } catch (e) {
            print(e);
          }
        }
      }
      i++;
    });
    print("nodelist length,${nodeList.length}");
    return nodeList;
  }

  static List<MapNode> fromCsv(MapConvert mapConvert) {
    return MapNode.parseCsv(dataNodes, minLen: 4)
        .map((csvRow) => MapNode.fromCsvRow(
            name: csvRow[3],
            indexSt: csvRow[4],
            xSt: csvRow[1],
            ySt: csvRow[2],
            mapConvert: mapConvert))
        .toList();
  }
}
