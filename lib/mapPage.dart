import 'dart:collection';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scale_city/line.dart';

import 'poly.dart';
import 'utils.dart';
import 'package:meta/meta.dart';

import 'main.dart';
import 'carList.dart';

import 'pathPage.dart';
import 'detailPage.dart';

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'poly.dart';

import 'clientpage.dart';

class Area {
  String name = '';
  double x = 0;
  double y = 0;
  double width = 0;
  double height = 0;

  Area({this.name, this.x, this.y, this.width, this.height});
}

class MapPage extends StatefulWidget {
  const MapPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<StatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // 地图的尺寸比例
  final double _sheetH = 230.0;
  final double _mapP = 100.0;
  final double _mapW = 1000.0;
  final double _mapH = 1000.0;

  List<MapNode> mapNodeList = [];
  List<MapLine> mapLineList = [];
  List<MapArc> mapArcsList = [];

  List<MapLine> drawLines = [];
  List<MapArc> drawArcs = [];

  // final List<Area> _bigAreas = [
  //   Area(name: "1", x: 158, y: 113, width: 318, height: 81),
  //   Area(name: "2", x: 521, y: 113, width: 266, height: 81),
  //   Area(name: "3", x: 832, y: 113, width: 69, height: 254),
  //   Area(name: "4", x: 158, y: 239, width: 114, height: 91),
  //   Area(name: "5", x: 317, y: 239, width: 159, height: 128),
  //   Area(name: "5", x: 185, y: 367, width: 291, height: 33),
  //   Area(name: "5", x: 185, y: 400, width: 268, height: 100),
  //   Area(name: "6", x: 521, y: 239, width: 133, height: 128),
  //   Area(name: "6", x: 533, y: 367, width: 182, height: 51),
  //   Area(name: "6", x: 546, y: 418, width: 241, height: 103),
  //   Area(name: "7", x: 704, y: 239, width: 83, height: 121),
  //   Area(name: "8", x: 185, y: 590, width: 168, height: 126),
  //   Area(name: "8", x: 353, y: 603, width: 32, height: 202),
  //   Area(name: "8", x: 253, y: 716, width: 100, height: 118),
  //   Area(name: "9", x: 396, y: 590, width: 57, height: 244),
  //   Area(name: "10", x: 476, y: 779, width: 45, height: 57),
  //   Area(name: "11", x: 547, y: 590, width: 132, height: 238),
  //   Area(name: "11", x: 679, y: 570, width: 108, height: 119),
  //   Area(name: "12", x: 105, y: 748, width: 115, height: 159),
  //   Area(name: "13", x: 750, y: 704, width: 115, height: 159)
  // ];

  final TextEditingController _startTextEditingController =
      TextEditingController(text: '');
  final TextEditingController _endTextEditingController =
      TextEditingController(text: '');
  final TransformationController _tc = TransformationController();

  final _startFocusNode = FocusNode();
  final _endFocusNode = FocusNode();

  // 地图中区域
  List<Polygon> polys = []; // 暂时自动生成

  // state
  double startTapX = 0;
  double startTapY = 0;
  double endTapX = 0;
  double endTapY = 0;

  bool isStart = true;
  bool isEnd = false;
  bool showArea = false;
  @override
  void initState() {
    super.initState();
    // print("initstate");
    var mapConvert =
        MapConvert.fromCsv(mapWidth: _mapW, mapHeight: _mapW, padding: _mapP);
    mapNodeList = MapNode.fromCsv(mapConvert);
    mapLineList = MapLine.fromCsv(mapConvert);
    mapArcsList = MapArc.fromCsv(mapConvert);
    if (kDebugMode) {
      print(
          "mapNodeList length,${mapNodeList.length}, ${mapLineList.length}, ${mapArcsList.length}");
    }

    // int xCount = 8;
    // int yCount = 8;
    // double xStep = (_mapW / xCount).floor().toDouble();
    // double yStep = (_mapH / xCount).floor().toDouble();
    //
    // // 暂时自动生成
    // // List<double> xList = [];
    // int index = 0;
    // for (var i = 0; i < xCount; i++) {
    //   double startX = xStep * i;
    //   double endX = i== xCount - 1 ? _mapW.toDouble(): xStep * (i+1);
    //   for (var ii = 0; ii < yCount; ii++) {
    //     index += 1;
    //     List<Point> list = [];
    //     double startY =  yStep * ii;
    //     double endY = ii == yCount - 1? _mapH.toDouble() : yStep * (ii+1);
    //
    //     list.add(Point(startX,startY));
    //     double nextX = startX + 1;
    //     double nextY = startY;
    //     // right -> down -> left -> up
    //
    //     // right
    //     while (nextX != endX) {
    //       nextX += 1;
    //       list.add(Point(nextX,nextY));
    //     }
    //
    //     // down
    //     while (nextY != endY) {
    //       nextY += 1;
    //       list.add(Point(nextX,nextY));
    //     }
    //
    //     // left
    //     while (nextX != startX) {
    //       nextX -= 1;
    //       list.add(Point(nextX,nextY));
    //     }
    //
    //     // up
    //     while (nextY != startY) {
    //       nextY -= 1;
    //       list.add(Point(nextX,nextY));
    //     }
    //     // print("${i},${ii},${list}");
    //     polys.add(Polygon(list,name: "x:${i+1},y: ${ii+1}"));
    //   }
    // }

    _tc.value = Matrix4.identity()
      ..translate(-(_mapW + _mapP * 2) / 4, -(_mapH + _mapP * 2) / 4);
    _onTap(x: _mapW / 2, y: _mapH / 2, isInit: true);

    _startFocusNode.addListener(_setInput);
    _endFocusNode.addListener(_setInput);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (kDebugMode) {
      print("dispose");
    }
    _startFocusNode.removeListener(_setInput);
    _endFocusNode.removeListener(_setInput);
    super.dispose();
  }

  _setInput() {
    if (kDebugMode) {
      print("setInput 0:$isStart,$isEnd");
    }
    setState(() {
      if (!_startFocusNode.hasFocus && !_endFocusNode.hasFocus) {
        return;
      }
      isStart = _startFocusNode.hasFocus;
      isEnd = _endFocusNode.hasFocus;
    });

    if (kDebugMode) {
      print("setInput 1: $isStart,$isEnd");
    }
  }

  // tap real position
  _onTap({double x, double y, isInit = false, areaName = ''}) {
    // find meaningful position
    // String polyname = '';
    // int time = 0;
    // while(polyname.isEmpty) {
    //   for (var poly in polys) {
    //     // print("poly name ${poly.name}");
    //     if(poly.isPointInside(Point(min(x+time,_mapW),min(y+time,_mapH)))) {
    //       print("is in ${poly.name},time:${time}");
    //       polyname = poly.name;
    //     }
    //   }
    //   time+=1;
    // }

    double _min = 0;
    String _minName;
    for (var node in mapNodeList) {
      var dis = sqrt(pow((node.x - x).abs(), 2) + pow((node.y - y).abs(), 2));
      if (_minName?.isEmpty ?? true) {
        _min = dis;
        _minName = node.name;
      }
      _min = min(_min, dis);
      _minName = _min == dis ? node.name : _minName;
    }
    if (_minName != null) {
      // find line
      var closedLines = mapLineList
          .where((e) => e.name.toLowerCase() == (_minName ?? '').toLowerCase())
          .toList();
      // find arc line
      var closedArcs = mapArcsList
          .where((e) => e.name.toLowerCase() == (_minName ?? '').toLowerCase())
          .toList();

      if (kDebugMode) {
        print("choose line:${closedLines.length}, ${closedArcs.length}");
      }

      setState(() {
        setState(() {
          drawLines = closedLines;
          drawArcs = closedArcs;
        });
      });
    }
    if (kDebugMode) {
      print("min distance:$_minName: $_min,$x, $y");
      print("min distance2:$isStart,$isEnd,$isInit");
    }

    // String pointer = '${(x * 100 / _mapW).ceil()},${((_mapH - y) * 100 / _mapH).ceil()},area: ${_minName ?? ''}';
    String pointer = '${x.ceil()},${y.ceil()},area: ${_minName ?? ''}';
    if (isStart || isInit) {
      _startTextEditingController.value = TextEditingValue(text: pointer);
      setState(() {
        startTapX = x;
        startTapY = y;
      });
    }
    if (isEnd || isInit) {
      _endTextEditingController.value = TextEditingValue(text: pointer);
      setState(() {
        endTapX = x;
        endTapY = y;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.check, color: Colors.black),
              tooltip: 'confirm',
              onPressed: () {
                var route = new MaterialPageRoute(
                  builder: (BuildContext context) => new ClientPage(
                      value: _startTextEditingController.text.substring(13) +
                          _endTextEditingController.text.substring(13)),
                );
                Navigator.of(context).push(route);
              })
        ],
      ),
      drawer: Drawer(
          child: ListView(children: [
        UserAccountsDrawerHeader(
            accountName: Text('IDS LAB'), accountEmail: Text('Welcome')),
        ListTile(
          title: const Text('Ride'),
          onTap: () {
            // Update the state of the app.
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Car List'),
          onTap: () {
            // Update the state of the app.
            // //Navigator.pop(context);
            ////runApp(const MyHome());
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHome()),
            );
          },
        ),
        ListTile(
          title: const Text('Back to the login page'),
          onTap: () {
            // Update the state of the app.
            // //Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BackgroundVideo()),
            );
          },
        ),
      ])),
      body: SizedBox.expand(
        child: Padding(
          padding: EdgeInsets.only(bottom: _sheetH),
          child: InteractiveViewer(
            constrained: false,
            minScale: 0.01,
            maxScale: 2,
            transformationController: _tc,
            // onInteractionUpdate: (ScaleUpdateDetails details) {
            //   print("onInteractionUpdate ${_tc.value.getTranslation()}");
            // },
            child: Padding(
              // width: 702.0 * 2,
              // height: 676.0 * 2,
              padding: EdgeInsets.all(_mapP),
              child: GestureDetector(
                  onTapUp: (TapUpDetails details) {
                    // RenderBox box = context.findRenderObject();
                    if (kDebugMode) {
                      print(
                          "onTapUp ${details.globalPosition},  ${details.localPosition}}");
                    }
                    _onTap(
                        x: details.localPosition.dx,
                        y: details.localPosition.dy);
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: _mapW,
                        height: _mapH,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage("assets/citymap.png"),
                          fit: BoxFit.cover,
                        )),
                      ),
                      if (showArea)
                        for (var node in mapNodeList)
                          Positioned(
                            top: node.y,
                            left: node.x,
                            child: Text(node.name),
                          ),
                      // for (var area in _bigAreas)
                      //   Positioned(
                      //     top: area.y,
                      //     left: area.x,
                      //     child: GestureDetector(
                      //       onTapUp: (TapUpDetails details) {
                      //         // RenderBox box = context.findRenderObject();
                      //         // print("onTapUp1 ${details.globalPosition},  ${details.localPosition}}, area name ${area.name}");
                      //         _onTap(x:details.localPosition.dx + area.x,y: details.localPosition.dy + area.y,areaName: area.name);
                      //
                      //       },
                      //       child: Container(
                      //         width: area.width,
                      //         height: area.height,
                      //         child: Center(child: Text('',style: const TextStyle(color: Colors.black,fontSize: 30),),),
                      //         decoration: const BoxDecoration(
                      //             color: Colors.transparent
                      //         ),
                      //       ),
                      //     ),
                      //
                      //   ),

                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: CustomPaint(
                          painter: Line(mapArcs: drawArcs, mapLines: drawLines),
                        ),
                      ),
                      // for (var item in drawLines)
                      //   if (item.nodes.length >=2)
                      //     Positioned(
                      //       top: min(item.nodes[0].y,item.nodes[1].y),
                      //       left: min(item.nodes[0].x,item.nodes[1].x),
                      //       width:(item.nodes[0].x - item.nodes[1].x).abs(),
                      //       height: (item.nodes[0].y - item.nodes[1].y).abs(),
                      //       child: CustomPaint(
                      //         painter: Line(isFromTopLeft: true, mapLine: item),
                      //       ),
                      //     ),
                      // for (var item in drawArcs)
                      //   if (item.nodes.length >=2)
                      //     Positioned(
                      //       top: min(item.nodes[0].y,item.nodes[1].y),
                      //       left: min(item.nodes[0].x,item.nodes[1].x),
                      //       width:(item.nodes[0].x - item.nodes[1].x).abs(),
                      //       height: (item.nodes[0].y - item.nodes[1].y).abs(),
                      //       child: CustomPaint(
                      //         painter: Line(isFromTopLeft: true, mapArc: item),
                      //       ),
                      //     ),

                      // Positioned(
                      //   top: min(startTapY, endTapY) + 25,
                      //   left: min(startTapX,endTapX),
                      //   width:(startTapX - endTapX).abs(),
                      //   height: (startTapY - endTapY).abs(),
                      //   child: CustomPaint(
                      //     painter: Line(isFromTopLeft:(startTapY < endTapY && startTapX < endTapX) || (startTapY > endTapY && startTapX > endTapX)),
                      //     // child: Center(
                      //     //   child: Text(
                      //     //     "Blade Runner",
                      //     //     style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
                      //     //   ),
                      //     // ),
                      //   ),
                      // ),
                      Positioned(
                        top: startTapY - 25,
                        left: startTapX - 25,
                        child: Image.asset(
                          'assets/map_pin.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                      Positioned(
                        top: endTapY - 25,
                        left: endTapX - 25,
                        child: Image.asset(
                          'assets/map_pin_end.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: _sheetH,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextField(
                readOnly: true,
                focusNode: _startFocusNode,
                decoration: const InputDecoration(
                    hintText: "Please choose a starting point",
                    border: OutlineInputBorder()),
                controller: _startTextEditingController,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  readOnly: true,
                  focusNode: _endFocusNode,
                  decoration: const InputDecoration(
                      hintText: "Please choose a end point",
                      border: OutlineInputBorder()),
                  controller: _endTextEditingController,
                ),
              ),
              // RaisedButton(
              //     child: new Text("Submit"),
              //     onPressed: () {
              //       var route = new MaterialPageRoute(
              //         builder: (BuildContext context) => new ClientPage(
              //             value:
              //                 _startTextEditingController.text.substring(11) +
              //                     _endTextEditingController.text.substring(11)),
              //       );
              //       Navigator.of(context).push(route);
              //     }),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            showArea = !showArea;
                          });
                        },
                        child: Text(showArea ? 'hide area' : 'show area')),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPage()),
                          );
                        },
                        child: const Text('go detail')),
                  ],
                ),
              ),
            ],
          ),
        ),
        decoration: const BoxDecoration(color: Colors.black12),
      ),
    );
  }
}
