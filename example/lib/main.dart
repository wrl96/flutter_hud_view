import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hud_view/flutter_hud_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter HUDView Demo'),
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
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                HUDView.of(context).init(timerClose: true, timerSeconds: 2).show(autoDestroy: true);
              },
              child: Text(
                'Simple Example'
              )
            ),
            FlatButton(
              onPressed: () {
                var hud = HUDView.of(context);
                hud.init(
                  hudType: HUDType.IOS,
                  text: 'Loading...',
                  timerClose: true,
                  timerSeconds: 2
                );
                hud.show(autoDestroy: true);
              },
              child: Text(
                'iOS Style'
              )
            ),
            FlatButton(
              onPressed: () {
                var hud = HUDView.of(context);
                hud.init(
                  hudType: HUDType.ANDROID,
                  text: 'Loading...',
                  timerClose: true,
                  timerSeconds: 2
                );
                hud.show(autoDestroy: true);
              },
              child: Text(
                'Android Style'
              )
            ),
            FlatButton(
              onPressed: () {
                var hud = HUDView.of(context);
                hud.init(
                  hudIndicatorType: HUDIndicatorType.SUCCESS,
                  text: 'Success',
                  timerClose: true,
                  timerSeconds: 2
                );
                hud.show(autoDestroy: true);
              },
              child: Text(
                'Success'
              )
            ),
            FlatButton(
              onPressed: () {
                var hud = HUDView.of(context);
                hud.init(
                  hudIndicatorType: HUDIndicatorType.FAIL,
                  text: 'Failure',
                  timerClose: true,
                  timerSeconds: 2
                );
                hud.show(autoDestroy: true);
              },
              child: Text(
                'Failure'
              )
            ),
            FlatButton(
              onPressed: () {
                var hud = HUDView.of(context);
                hud.init(
                  hudIndicatorType: HUDIndicatorType.CUSTOM,
                  customIndicatorWidget: Icon(
                    Icons.error,
                    color: Theme.of(context).accentColor,
                    size: MediaQuery.of(context).size.width * 0.15,
                  ),
                  text: 'Custom Indicator',
                  timerClose: true,
                  timerSeconds: 2
                );
                hud.show(autoDestroy: true);
              },
              child: Text(
                'Custom Indicator Widget'
              )
            ),
            FlatButton(
              onPressed: () {
                var hud = HUDView.of(context);
                hud.init(
                  hudType: HUDType.CUSTOM,
                  customWidget: Card(
                    //color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Custom Widget'
                      ),
                    ),
                  ),
                  backgroundColor: Color(0xA0000000),
                  timerClose: true,
                  timerSeconds: 2
                );
                hud.show(autoDestroy: true);
              },
              child: Text(
                'Custom Widget'
              )
            ),
            FlatButton(
              onPressed: () {
                HUDView.of(context).init(hudType: HUDType.IOS, timerClose: true, timerSeconds: 3).show();
                Timer(Duration(seconds: 2), (){
                  HUDView.of(context).update(hudType: HUDType.ANDROID, text: 'update').show(autoDestroy: true);
                });
              },
              child: Text(
                  'Init and Update'
              )
            ),
            FlatButton(
              onPressed: () {
                var hud = HUDView.of(context);
                hud.init(
                  hudType: HUDType.CUSTOM,
                  customWidget: Card(
                    //color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                          'Tap anywhere to close'
                      ),
                    ),
                  ),
                  backgroundColor: Color(0xA0000000),
                  tapClose: true
                );
                hud.show(autoDestroy: true);
              },
              child: Text(
                  'Tap close'
              )
            ),
            FlatButton(
              onPressed: () {
                var hud = HUDView.of(context);
                hud.init(
                  hudType: HUDType.IOS,
                  hudColor: Colors.black,
                  hudTextColor: Colors.black,
                  hudBackgroundColor: Colors.white,
                  backgroundColor: Color(0xA0000000),
                  text: 'Custom Color',
                  timerClose: true,
                  timerSeconds: 2
                );
                hud.show(autoDestroy: true);
              },
              child: Text(
                  'Custom Color'
              )
            ),
            FlatButton(
              onPressed: () {
                HUDView.of(context).init(text: '1').show();
                Timer(Duration(seconds: 2), () {
                  HUDView.of(context).dismiss();
                  HUDView.of(context).update(text: '2').show();
                  Timer(Duration(seconds: 2), () {
                    HUDView.of(context).destroy();
                    try {
                      HUDView.of(context).update(text: '3');
                    } catch(e) {
                      /// Can't call update after destroy
                      /// Please call init after destroy
                      HUDView.of(context).init(text: '4', timerClose: true, timerSeconds: 2).show(autoDestroy: true);
                    }
                  });
                });
              },
              child: Text(
                'Dismiss and Destroy'
              )
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
