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