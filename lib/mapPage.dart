import 'main.dart';
import 'package:flutter/material.dart';
import 'carList.dart';
import 'pathPage.dart';

//**********MAP PAGE***********

class _MyHomePageState2 extends State<MyHomePage> {
  final TextEditingController _startTextEditingController =
      TextEditingController();
  final TextEditingController _endTextEditingController =
      TextEditingController();
  Map<String, List<String>> data = {
    "a&b": ["zld", "lxt"],
    "c&d": ["why"],
    "e&f": ["wx"],
  };
  List<String> resultData = [];

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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                    Container(
                      width: 2,
                      height: 60,
                      color: Colors.black45,
                    ),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                  ],
                ),
                Expanded(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: TextField(
                        decoration: const InputDecoration(
                            hintText: "Please enter a starting point",
                            border: OutlineInputBorder()),
                        controller: _startTextEditingController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: "Please input the end",
                          border: OutlineInputBorder(),
                        ),
                        controller: _endTextEditingController,
                      ),
                    ),
                  ],
                )),
              ],
            ),
            (_startTextEditingController.value.text != '') &&
                    ((_endTextEditingController.value.text) != '')
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: GestureDetector(
                        child: Image.asset(
                          'assets/images/xiaoqiche.png',
                          width: 50,
                          height: 50,
                        ),
                        onTap: () {
                          String search =
                              '${_startTextEditingController.value.text}&${_endTextEditingController.value.text}';
                          if (data.containsKey(search)) {
                            setState(() {
                              resultData.clear();
                              resultData.addAll(data[search] as List<String>);
                            });
                          }
                        },
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 0,
                  ),
            Column(
              children: resultData
                  .map((e) => Card(
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          height: 50,
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(e),
                          ),
                        ),
                      ))
                  .toList(),
            )
          ],
        ),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover)),
      ),
    );
  }
}

class path extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: MyHomePage(title: 'IDS LAB'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 地图的尺寸比例
  final double _sheetH = 200.0;
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
    _onTap(tapX, tapY);
  }

  _onTap(double x, double y) {
    String pointer =
        '${(x * 100 / _mapW).ceil()},${((_mapH - y) * 100 / _mapH).ceil()}';
    if (tapTimes.isEven) {
      _startTextEditingController.value = TextEditingValue(text: pointer);
    } else {
      _endTextEditingController.value = TextEditingValue(text: pointer);
    }
    tapTimes++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title),
        /* leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          tooltip: 'Back',
          onPressed: () => debugPrint('back'),
        ), */
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.check, color: Colors.black),
              tooltip: 'confirm',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondRoute()),
                );
              })
        ],
      ),
      drawer: Drawer(
          child: ListView(children: [
        UserAccountsDrawerHeader(
            accountName: Text('User Name'), accountEmail: Text('Guest')),
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
            //Navigator.pop(context);
            //runApp(const MyHome());
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
            //Navigator.pop(context);
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
                    print(
                        "onTapUp ${details.globalPosition},  ${details.localPosition}}");
                    setState(() {
                      tapX = details.localPosition.dx;
                      tapY = details.localPosition.dy;
                    });
                    _onTap(tapX, tapY);
                  },
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
                        top: tapY - 25,
                        left: tapX - 25,
                        child: Image.asset(
                          'assets/images/xiaoqiche.png',
                          width: 50,
                          height: 50,
                        ),
                      )
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
                decoration: const InputDecoration(
                    hintText: "Please choose a starting point",
                    border: OutlineInputBorder()),
                controller: _startTextEditingController,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextField(
                  readOnly: true,
                  decoration: const InputDecoration(
                      hintText: "Please choose a end point",
                      border: OutlineInputBorder()),
                  controller: _endTextEditingController,
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
