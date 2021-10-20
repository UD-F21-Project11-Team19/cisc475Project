import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

//import 'IDS_Car_List.dart';

void main() => runApp(BackgroundVideo());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterApp',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primaryColor: Colors.black12,
        accentColor: Colors.orange,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Stateless'),
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}

class BackgroundVideo extends StatefulWidget {
  @override
  _BackgroundVideoState createState() => _BackgroundVideoState();
}

class AboutUs extends StatefulWidget {
  @override
  _AboutUs createState() => _AboutUs();
}

class _BackgroundVideoState extends State<BackgroundVideo> {
  // TODO 4: Create a VideoPlayerController object.
  VideoPlayerController _controller;

  // TODO 5: Override the initState() method and setup your VideoPlayerController
  @override
  void initState() {
    super.initState();
    // Pointing the video controller to our local asset.
    _controller = VideoPlayerController.asset("assets/Background_Video.mp4")
      ..initialize().then((_) {
        // Once the video has been loaded we play the video and set looping to true.
        _controller.play();
        _controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Adjusted theme colors to match logo.
        primaryColor: Color(0xffb55e28),
        accentColor: Color(0xffffd544),
      ),
      home: SafeArea(
        child: Scaffold(
          // TODO 6: Create a Stack Widget
          body: Stack(
            children: <Widget>[
              // TODO 7: Add a SizedBox to contain our video.
              SizedBox.expand(
                child: FittedBox(
                  // If your background video doesn't look right, try changing the BoxFit property.
                  // BoxFit.fill created the look I was going for.
                  fit: BoxFit.fill,
                  child: SizedBox(
                    width: _controller.value.size?.width ?? 0,
                    height: _controller.value.size?.height ?? 0,
                    child: VideoPlayer(_controller),
                  ),
                ),
              ),
              LoginWidget()
            ],
          ),
        ),
      ),
    );
  }

  // TODO 8: Override the dipose() method to cleanup the video controller.
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

// A basic login widget with a logo and a form with rounded corners.
//test
class LoginWidget extends StatelessWidget {
  const LoginWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Center(
            child: Image(
              image: AssetImage("assets/IDS_logo.png"),
              width: 300.0,
            ),
          ),
        ),
        SizedBox(
          height: 75.0,
        ),
        Container(
          decoration: new BoxDecoration(
            color: Colors.white.withAlpha(200),
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0),
              bottomLeft: const Radius.circular(10.0),
              bottomRight: const Radius.circular(10.0),
            ),
          ),
          padding: EdgeInsets.all(16),
          width: 300,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ButtonTheme(
                minWidth: 300.0,
                child: RaisedButton(
                  color: Color(0xff00539f),
                  child: Text(
                    'Login as Guest',
                    style: TextStyle(color: Color(0xffffd544), fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => path()),
                    );
                  },
                ),
              ),
              ButtonTheme(
                minWidth: 300.0,
                child: RaisedButton(
                  color: Color(0xff00539f),
                  child: Text(
                    'Login as User',
                    style: TextStyle(color: Color(0xffffd544), fontSize: 20),
                  ),
                  onPressed: () {},
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                    fontSize: 15,
                    color: Color(0xff00539f),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUs()),
                  );
                },
                child: const Text('About Us'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AboutUs extends State {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Pointing the video controller to our local asset.
    _controller = VideoPlayerController.asset("assets/Background_Video.mp4")
      ..initialize().then((_) {
        // Once the video has been loaded we play the video and set looping to true.
        _controller.play();
        _controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('IDS Lab'),
      ),
      body: new Container(
        child: new Text(
          "Welcome to Professor Andreas Malikopoulos’ Information and Decision Science (IDS) lab! The overarching goal of the IDS Lab is to enhance understanding of large-scale, complex cyber-physical systems (CPS) and establish rigorous theories and algorithms for making CPS able to realize how to improve their performance over time while interacting with their environment. The emphasis is on applications related to emerging mobility systems (e.g., connected and automated vehicles, shared mobility), sociotechnical systems, social media, and smart cities.",
          style: new TextStyle(
              fontSize: 12.0,
              color: const Color(0xFF000000),
              fontWeight: FontWeight.w200,
              fontFamily: "Roboto"),
        ),
        padding: const EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 179.0),
        alignment: Alignment.center,
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
            runApp(const MyHome());
            //Navigator.push(
            //context,

            //MaterialPageRoute(builder: (context) => MyHome()),
            //);
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

class MyHome extends StatelessWidget {
  const MyHome({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IDS Lab',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage1(title: 'IDS Car List'),
    );
  }
}

class MyHomePage1 extends StatefulWidget {
  const MyHomePage1({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage1> createState() => _CarList();
}

//List<String> litems = ["Car 1", "Car 2", "Car 3", "Car 4"];

class _CarList extends State<MyHomePage1> {
  var activeScreen = carListScreen;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            activeScreen.title,
            style: const TextStyle(
              fontFamily: 'bebas-neue',
              fontSize: 25.0,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            )
          ]),
      drawer: Drawer(
          child: ListView(children: [
        UserAccountsDrawerHeader(
            accountName: Text('User Name'), accountEmail: Text('Guest')),
        ListTile(
          title: const Text('Ride'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => path()),
            );
          },
        ),
        ListTile(
          title: const Text('Car List'),
          onTap: () {
            // Update the state of the app.
            Navigator.pop(context);
          },
        ),
      ])),
      body: activeScreen.contentBuilder(context),

      // ListView.builder(
      //     itemCount: litems.length,
      //     itemBuilder: (BuildContext ctxt, int index) {
      //       return Text(litems[index]);
      //     })
    );
  }
}

//////////////////////////////////////////////////
///后面这些code是这个文件夹的原本的文件，在连接之前是可以run的
///main里面有个import我comment掉了，正常run的时候需要import这个文件

class Screen {
  final String title;
  final WidgetBuilder contentBuilder;

  Screen({this.title, this.contentBuilder});
}

final Screen carListScreen = Screen(
    title: 'IDS Car List',
    contentBuilder: (BuildContext content) {
      return ListView(
        children: [
          _Car(),
          _Car(),
          _Car(),
        ],
      );
    });

class _Car extends StatelessWidget {
  const _Car({Key key}) : super(key: key);

  // final String headImageAssetPath;
  // final String title;

  // _Car({
  //   this.headImageAssetPath, this.title;
  // });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      child: Column(
        children: [
          Image.asset(
            'assets/images/car.png',
            width: double.infinity,
            height: 150.0,
            fit: BoxFit.cover,
          ),
          Row(
            children: [
              Text('Car Name'),
            ],
          )
        ],
      ),
    );
  }
}

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
                          color: Colors.blue,
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

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 5.0,
                    color: Colors.amber,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 5.0,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
            preferredSize: const Size.square(1.0)),
        backgroundColor: const Color(0xff885566),
        title: const Center(
          child: Text(
            'LSD LAB',
            style: TextStyle(color: Color(0xff000000)),
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.check, color: Colors.black),
            tooltip: 'Confirm',
            onPressed: () => debugPrint('Confirm the path.'),
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 80),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                  onPressed: () {
                    print('minus');
                  },
                  child: const Icon(Icons.remove),
                  tooltip: 'zoom down'),
            ),
          ),
        ],
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(width: 600, height: 600),
        child: Image.asset(
          "assets/citymap.png",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
