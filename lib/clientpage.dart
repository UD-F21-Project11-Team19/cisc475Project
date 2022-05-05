//ClientPage file is that the page shows after the map page. It will create the Client and connect with Server, and send the original indexes, the number of passagers,
//and estimated time to Server.
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:scale_city/pathPage.dart';
import 'client.dart';

class ClientPage extends StatefulWidget {
  final String value;
  ClientPage({Key key, this.value}) : super(key: key);
  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  Client client;
  List<String> serverLogs = [];
  double _value1 = 0;
  double _value2 = 0;
  TextEditingController controller = TextEditingController();

//create the new Client with the IP address
  initState() {
    super.initState();

    client = Client(
      hostname: "192.168.1.227", //change the IP address in here
      port: 54000,
      onData: this.onData,
      onError: this.onError,
    );
  }

//design the message, and it will be "the real time: indexed" in the Cleint Page.
  onData(Uint8List data) {
    DateTime time = DateTime.now();
    serverLogs.add(time.hour.toString() +
        " : " +
        time.minute.toString() +
        " : " +
        String.fromCharCodes(data));
    setState(() {});
  }

  onError(dynamic error) {
    print(error);
  }

  dispose() {
    controller.dispose();
    client.disconnect();
    super.dispose();
  }

//return to the prevvious page
  confirmReturn() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("ATTENTION"),
          content: Text("You will leave this page and disconnect with server"),
          actions: <Widget>[
            FlatButton(
              child: Text("Quit", style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Annuler", style: TextStyle(color: Colors.grey)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

//This method is design the Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: confirmReturn,
        ),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.check,
                  color: Color.fromARGB(255, 255, 255, 255)),
              tooltip: 'confirm',
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      //It will goes the next page and shows the result path
                      builder: (context) => MyHomePage(
                            value: serverLogs.map((String log) {
                              return log;
                            }).toList(),
                          )),
                );
                await client.disconnect();
              })
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Client",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: client.connected ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                        padding: EdgeInsets.all(5),
                        child: Text(
                          client.connected ? 'CONNECT' : 'DISCONNECT',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  //Here are the two sliders
                  Slider(
                    min: 0.0,
                    max: 5.0,
                    value: _value1,
                    divisions: 5,
                    label: '${_value1.round()}',
                    onChanged: (value) {
                      setState(() {
                        _value1 = value;
                      });
                    },
                  ),
                  Text(
                    'Number of Passengers: ${_value1.round()}',
                  ),

                  Slider(
                    min: 0.0,
                    max: 10.0,
                    value: _value2,
                    divisions: 10,
                    label: '${_value2.round()}',
                    onChanged: (value) {
                      setState(() {
                        _value2 = value;
                      });
                    },
                  ),
                  Text(
                    'Estimated Time: ${_value2.round()}',
                  ),

                  Divider(
                    height: 30,
                    thickness: 1,
                    color: Colors.black12,
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView(
                      children: serverLogs.map((String log) {
                        var path = log;
                        return Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(log), //text back
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //Here is the TextField that will send to the Server.
          Container(
            color: Colors.grey,
            height: 80,
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Message :',
                        style: TextStyle(
                          fontSize: 8,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: controller,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                MaterialButton(
                  onPressed: () async {
                    await client.connect();
                    setState(() {});
                    controller.text =
                        ("${widget.value},${_value1.round()},${_value2.round()}"); //the two indexes data from previous page and the two number from the sliders
                  },
                  minWidth: 30,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Icon(Icons.add),
                ),
                SizedBox(
                  width: 15,
                ),
                MaterialButton(
                  onPressed: () {
                    client.write(controller.text);
                    //await client.disconnect();
                    setState(() {});
                    controller.text = "";
                  },
                  minWidth: 30,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Icon(Icons.send),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
