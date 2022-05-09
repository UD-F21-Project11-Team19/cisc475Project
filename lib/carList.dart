import 'main.dart';
import 'mapPage.dart';
import 'package:flutter/material.dart';

//**********CAR-List PAGE***********
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
            accountName: Text('IDS LAB'), accountEmail: Text('Welcome')),
        ListTile(
          title: const Text('Ride'),
          onTap: () {
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
///thre code below are the origrnal codes, it can run before the connection
///there is a import in the main which i commented it, when run it, need to import this file

class Screen {
  final String title;
  final WidgetBuilder contentBuilder;

  Screen({this.title, this.contentBuilder});
}
//IDS Car List
final Screen carListScreen = Screen(
    title: 'IDS Car List',
    contentBuilder: (BuildContext content) {
      return ListView(
        children: [
          _Car(),
          _Car2(),
          _Car3(),
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

//get car1 image
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      child: Column(
        children: [
          Image.asset(
            'assets/images/car1.1.png',
            width: double.infinity,
            height: 150.0,
            fit: BoxFit.cover,
          ),
          Row(
            children: [
              Text("Dark blue Sport"),
            ],
          )
        ],
      ),
    );
  }
}

class _Car2 extends StatelessWidget {
  const _Car2({Key key}) : super(key: key);

  // final String headImageAssetPath;
  // final String title;

  // _Car({
  //   this.headImageAssetPath, this.title;
  // });

//get car2 image

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      child: Column(
        children: [
          Image.asset(
            'assets/images/car2.1.png',
            width: double.infinity,
            height: 150.0,
            fit: BoxFit.cover,
          ),
          Row(
            children: [
              Text('Blue Sedan'),
            ],
          )
        ],
      ),
    );
  }
}

class _Car3 extends StatelessWidget {
  const _Car3({Key key}) : super(key: key);

  // final String headImageAssetPath;
  // final String title;

  // _Car({
  //   this.headImageAssetPath, this.title;
  // });

//get car3 image

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      child: Column(
        children: [
          Image.asset(
            'assets/images/car3.1.png',
            width: double.infinity,
            height: 150.0,
            fit: BoxFit.cover,
          ),
          Row(
            children: [
              Text('White Jeep'),
            ],
          )
        ],
      ),
    );
  }
}
