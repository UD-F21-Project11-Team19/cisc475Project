import 'main.dart';
import 'package:flutter/material.dart';
import 'carList.dart';
import 'mapPage.dart';

//page set up

class _MyHomePageState2 extends State<MyHomePage> {
  final TextEditingController _startTextEditingController =
      TextEditingController();
  final TextEditingController _endTextEditingController =
      TextEditingController();

  @override
  void initState() {
    _startTextEditingController.addListener(() {
      setState(() {});
    });
    _endTextEditingController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: Center(child: MyHomePage(title: 'Map Detail')),
    );
  }
}

/* class DetailPage extends StatelessWidget {
  final String title;
  DetailPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text('Detail page'),
        
      ),
    );
  }
} */
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // The scale of the map's dimensions
  final double _sheetH = 0;
  final double _mapP = 100.0;
  final double _mapW = 702.0;
  final double _mapH = 676.0;
  final TextEditingController _startTextEditingController =
      TextEditingController(text: '');
  final TextEditingController _endTextEditingController =
      TextEditingController(text: '');
  final TransformationController _tc = TransformationController();

  // state
  double tapX = 0;
  double tapY = 0;

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

//buttons set up--go back and go to the map

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title),
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
        // actions: <Widget>[
        //   IconButton(
        //       icon: const Icon(Icons.check, color: Colors.black),
        //       tooltip: 'confirm',
        //       onPressed: () {})
        // ],
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
                  onTapUp: (TapUpDetails details) {
                    print(
                        "onTapUp ${details.globalPosition},  ${details.localPosition}}");
                    setState(() {
                      tapX = details.localPosition.dx;
                      tapY = details.localPosition.dy;
                    });
                  },
                  child: Stack(
                    children: [
                      Container(
                          width: _mapW,
                          height: _mapH,
                          child: null,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/detail-image.png"),
                                  fit: BoxFit.cover))),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
