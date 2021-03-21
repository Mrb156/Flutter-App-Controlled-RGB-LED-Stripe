import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'LED control'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final databaseReference = FirebaseDatabase.instance.reference();

int getData() {
  int data;
  FirebaseDatabase.instance
      .reference()
      .child('Br')
      .once()
      .then((DataSnapshot snapshot) {
    data = snapshot.value;
    print(data);
  });
  return data;
}

final dbRef = FirebaseDatabase.instance.reference().child("Br").once();

class _MyHomePageState extends State<MyHomePage> {
  int brightness = 20;
  Color pickerColor = Colors.red;
  IconData buttonIcon = Icons.wb_sunny;
  bool iconState = true;

  double size = 120;
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  double _bigger() {
    setState(() {
      size = 200;
    });
  }

  double _smaller() {
    setState(() {
      size = 120;
    });
  }

  Icon changeIconToDark() {
    setState(() {
      buttonIcon = Icons.nightlight_round;
    });
  }

  Icon changeIconToLight() {
    setState(() {
      buttonIcon = Icons.wb_sunny_rounded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Container(
            //height: 320,
            color: Colors.white,
            child: ColorPicker(
              displayThumbColor: true,
              pickerColor: pickerColor,
              onColorChanged: changeColor,
              showLabel: false,
              pickerAreaHeightPercent: 0.8,
              colorPickerWidth: 250,
              enableAlpha: false,
              pickerAreaBorderRadius: BorderRadius.circular(50),
            ),
          ),
          Container(
              //margin: EdgeInsets.symmetric(vertical: 10),
              child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.grey[700],
                    inactiveTrackColor: Colors.white,
                    trackShape: RoundedRectSliderTrackShape(),
                    trackHeight: 1,
                    thumbColor: Colors.white,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                    overlayColor: Colors.transparent,
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                    valueIndicatorColor: Colors.grey[700],
                    showValueIndicator: ShowValueIndicator.always,
                    valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                    valueIndicatorTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  child: Slider(
                      value: brightness.toDouble(),
                      label: brightness.round().toString(),
                      min: 0,
                      max: 100,
                      //divisions: 20,
                      onChanged: (double value) {
                        databaseReference.update({'Br': brightness.round()});
                        setState(() {
                          brightness = value.toInt();
                        });
                      }))),
          Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              height: 150,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    progs(rainbow(), 'RAINBOW', "rainbow"),
                    progs(rainbow(), 'RAINBOW2', "u_rainbow"),
                    progs(rainbow(), 'GRADIENT', "pat"),
                    progs(rainbow(), 'SNAKE', "odavissza"),
                    progs(rainbow(), 'GRADIENT2', "g_wave")
                  ],
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [single(buttonIcon, lAMP), single(Icons.lightbulb, _set)],
          )
        ],
      ),
    ));
  }

  Container single(IconData icon, void any()) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        height: 64,
        width: 130,
        child: Stack(children: [
          //Container(child:),
          Material(
              color: Colors.white,
              child: InkWell(
                child: Container(
                  height: 65,
                  width: 130,
                  child: Icon(
                    icon,
                    size: 50,
                  ),
                ),
                onTap: () {
                  any();
                },
                customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))),
        ]),
        decoration: new BoxDecoration(
            //color: Colors.white,
            borderRadius: new BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 3),
              )
            ]));
  }

  void lAMP() {
    if (iconState == true) {
      databaseReference.update({
        'SetUp': 'szín' +
            ' ' +
            0.toString() +
            ' ' +
            0.toString() +
            ' ' +
            0.toString()
      });
      databaseReference.update({'red': 0});
      databaseReference.update({'green': 0});
      databaseReference.update({'blue': 0});
      changeIconToDark();
      iconState = false;
    } else {
      databaseReference.update({
        'SetUp': 'szín' +
            ' ' +
            255.toString() +
            ' ' +
            100.toString() +
            ' ' +
            100.toString()
      });
      databaseReference.update({'red': 255});
      databaseReference.update({'green': 100});
      databaseReference.update({'blue': 100});
      changeIconToLight();
      iconState = true;
    }
  }

  void _set() {
    databaseReference.update({'red': pickerColor.red});
    databaseReference.update({'green': pickerColor.green});
    databaseReference.update({'blue': pickerColor.blue});
    databaseReference.update({
      'SetUp': 'szín' +
          ' ' +
          pickerColor.red.toString() +
          ' ' +
          pickerColor.green.toString() +
          ' ' +
          pickerColor.blue.toString()
    });
  }

  Container progs(Container cover, String text, String prop) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Stack(children: [
          Container(
              height: 140,
              width: 140,
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 3),
                    )
                  ])),
          Column(
            children: [
              cover,
              SizedBox(
                height: 10,
              ),
              Text(
                text,
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
          Container(
            height: 150,
            width: 140,
            color: Colors.transparent,
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                  //splashColor: Colors.grey[400],
                  onTap: () {
                    databaseReference.update({
                      'SetUp': prop +
                          ' ' +
                          pickerColor.red.toString() +
                          ' ' +
                          pickerColor.green.toString() +
                          ' ' +
                          pickerColor.blue.toString()
                    });
                  },
                  customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                )),
          )
        ]));
  }
}

Container rainbow() {
  return Container(
      height: 90,
      width: 140,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.yellow, Colors.red, Colors.indigo, Colors.teal]),
          //color: Colors.grey[500],
          borderRadius: BorderRadius.all(Radius.circular(20))));
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
