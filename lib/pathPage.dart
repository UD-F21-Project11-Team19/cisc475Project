import 'main.dart';
import 'package:flutter/material.dart';
import 'carList.dart';
import 'mapPage.dart';
import 'clientpage.dart';
import 'line.dart';
import 'poly.dart';
import 'utils.dart';

//**********MAP PAGE***********
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.value}) : super(key: key);

  final String value;
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 地图的尺寸比例
  final double _sheetH = 0;
  final double _mapP = 100.0;
  final double _mapW = 702.0;
  final double _mapH = 676.0;
  // final TextEditingController _startTextEditingController =
  //     TextEditingController(text: '');
  // final TextEditingController _endTextEditingController =
  //     TextEditingController(text: '');
  final TransformationController _tc = TransformationController();

  // state
  double tapX = 0;
  double tapY = 0;
  double startTapX = 0;
  double startTapY = 0;
  double endTapX = 0;
  double endTapY = 0;

  List<MapLine> drawLines = [];
  List<MapArc> drawArcs = [];

  int tapTimes = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tc.value = Matrix4.identity()
      ..translate(-(_mapW + _mapP * 2) / 4, -(_mapH + _mapP * 2) / 4);
    tapX = _mapW / 2;
    tapY = _mapH / 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 87, 85, 85),
        title: Text("${widget.value}"),
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          tooltip: 'Back',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MapPage(
                  title: 'Map Page',
                ),
              ),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.check, color: Colors.black),
              tooltip: 'confirm',
              onPressed: () {})
        ],
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: EdgeInsets.only(bottom: _sheetH),
          child: InteractiveViewer(
            constrained: false,
            minScale: 0.01,
            maxScale: 2,
            transformationController: _tc,
            child: Padding(
              padding: EdgeInsets.all(_mapP),
              child: GestureDetector(
                  child: Stack(
                children: [
                  Container(
                      width: _mapW,
                      height: _mapH,
                      child: null,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/citymap.png"),
                              fit: BoxFit.cover))),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: CustomPaint(
                      painter: Line(mapArcs: drawArcs, mapLines: drawLines),
                    ),
                  ),
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
    );
  }
}
