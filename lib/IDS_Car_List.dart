import 'package:flutter/material.dart';
import 'main.dart';

//CarList class 应该在main里
class _CarList extends State<MyHomePage> {
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
            // Update the state of the app.
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
    );
  }
}


//////////////////////////////////////////////////
///后面这些code是这个文件夹的原本的文件，在连接之前是可以run的
///main里面有个import我comment掉了，正常run的时候需要import这个文件

class Screen {
  final String title;
  final WidgetBuilder contentBuilder;

  Screen({required this.title, required this.contentBuilder});
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
  const _Car({Key? key}) : super(key: key);

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
