import 'package:flutter/material.dart';
import 'mapPage.dart';
import 'carList.dart';

//**********PATH PAGE***********
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
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            'LSD LAB',
            style: TextStyle(color: Colors.black),
          ),
        ),
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          tooltip: 'Back',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => path()),
            );
          },
        ),
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
