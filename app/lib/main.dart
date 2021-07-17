import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ui_design/alan.dart';
//import 'package:ui_design/colorpicker.dart';
import 'progs.dart';

import 'animation.dart';
import 'animation_rainbow2.dart';

//main entry point of the program
void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //initializing the widgets before building them
  await Firebase.initializeApp();

  runApp(MyApp()); //building the app
}

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
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

//creating the page with a StatefulWidget (it can be changed)
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final databaseReference =
    FirebaseDatabase.instance.reference(); //reach the database's data

int getData() {
  int data;
  FirebaseDatabase.instance.reference().child('Br').once();
  return data;
}

//the true magic happens here
class _MyHomePageState extends State<MyHomePage> {
  //set variables and methods (some of them aren't used yet)
  int brightness;
  Color pickerColor = Colors.red;
  Color _pickerColor;
  IconData buttonIcon = Icons.wb_sunny;
  bool iconState = true;

  double size = 120;
  void changeColor(Color color) {
    _pickerColor = color;
    databaseReference
        .child("Colors")
        .update({'Br': (_pickerColor.alpha / 2.55).round()});
    databaseReference.update({'Br': (_pickerColor.alpha / 2.55).round()});
  }

  //making the base widget
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Container(
      color: Color(0xEBEBEBEB),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: SizeConfig.blockSizeVertical * 7,
          ),
          Expanded(
              //building the colorpicker
              child: FutureBuilder(
            future: databaseReference.child("Colors").once(),
            builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
              if (snapshot.hasData) {
                List<int> lists = [];
                Map<dynamic, dynamic> values = snapshot.data.value;
                values.forEach((key, values) {
                  lists.add(values);
                }); //red 1; br 0; blue 2; green 3;
                _pickerColor = pickerColor = Color.fromRGBO(lists[1], lists[3],
                    lists[2], ((lists[0]) * 0.01).toDouble());

                return Container(
                    child: ColorPicker(
                  displayThumbColor: true,
                  pickerColor: _pickerColor,
                  onColorChanged: changeColor,
                  showLabel: false,
                  pickerAreaHeightPercent: 1,
                  colorPickerWidth: SizeConfig.blockSizeHorizontal * 70,
                  enableAlpha: true,
                  pickerAreaBorderRadius: BorderRadius.circular(50),
                ));
              } else {
                return Center(
                  child: SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 20,
                      height: SizeConfig.blockSizeVertical * 10,
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                      )),
                );
              }
            },
          )),
          //for the different programs, that the LED stripe can show, i created a horizontal scrollable widget
          Container(
            height: SizeConfig.blockSizeVertical * 30,
            //width: SizeConfig.blockSizeHorizontal * 22,
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 50),
              scrollDirection: Axis.horizontal,
              children: [
                progs(AnimContainer(), "RAINBOW", "rainbow"),
                progs(AnimContainer2(), 'RAINBOW2', "u_rainbow"),
                progs(rainbow(), 'GRADIENT', "pat"),
                progs(rainbow(), 'GRADIENT2', "g_wave"),
                progs(rainbow(), 'SNAKE', "odavissza"),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              single_button(Icons.lightbulb, _set),
              //Container(child: Alan())
            ],
          ),
        ],
      ),
    ));
  }

  //function for a single button, wich returns a container widget
  Container single_button(IconData icon, void any()) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 20),
        height: SizeConfig.blockSizeVertical * 10,
        width: SizeConfig.blockSizeHorizontal * 80,
        child: Stack(children: [
          //Container(child:),
          Material(
              color: Color(0xEBEBEBEB),
              child: InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: SizeConfig.blockSizeVertical * 10,
                  width: SizeConfig.blockSizeHorizontal * 90,
                  child: Icon(
                    icon,
                    size: SizeConfig.blockSizeVertical * 7,
                  ),
                ),
                onTap: () {
                  any(); //calling the any method parameter
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
                color: Color(0xC8C8C8C8),
                offset: Offset(15, 15),
                blurRadius: 32,
              ),
              BoxShadow(
                  blurRadius: 32,
                  color: Color(0xFFFFFFFF),
                  offset: Offset(-15, -15)),
            ]));
  }

  //these methods are for the single_button widget's any parameter
  //they are updates the given paths of the database, with the given values

  //this method sends values to the firebase from the colorpicker
  void _set() {
    databaseReference.child("Colors").update({'Red': _pickerColor.red});
    databaseReference.child("Colors").update({'Green': _pickerColor.green});
    databaseReference.child("Colors").update({'Blue': _pickerColor.blue});
    databaseReference.update({
      'SetUp': 'szín' +
          ' ' +
          _pickerColor.red.toString() +
          ' ' +
          _pickerColor.green.toString() +
          ' ' +
          _pickerColor.blue.toString()
    });
  }

  //creating the widgets for the different programs
  Container progs(Widget cover, String text, String prop) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Stack(children: [
          Container(
            height: SizeConfig.blockSizeVertical * 100,
            width: SizeConfig.blockSizeHorizontal * 45.7,
            decoration: new BoxDecoration(
                color: Color(0xEBEBEBEB),
                borderRadius: new BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xC8C8C8C8),
                    offset: Offset(15, 15),
                    blurRadius: 32,
                  ),
                  BoxShadow(
                      blurRadius: 32,
                      color: Color(0xFFFFFFFF),
                      offset: Offset(-15, -15)),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                cover,
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal * 6,
                  child: Text(
                    text,
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 6),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: SizeConfig.blockSizeVertical * 100,
            width: SizeConfig.blockSizeHorizontal * 45.7,
            color: Colors.transparent,
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                  //splashColor: Colors.grey[400],
                  onTap: () {
                    databaseReference.update({
                      'SetUp': prop +
                          ' ' +
                          _pickerColor.red.toString() +
                          ' ' +
                          _pickerColor.green.toString() +
                          ' ' +
                          _pickerColor.blue.toString()
                    });
                  },
                  customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                )),
          )
        ]));
  }
}

//this is the style of the widgets above
Container rainbow() {
  return Container(
      height: SizeConfig.blockSizeVertical * 10,
      width: SizeConfig.blockSizeHorizontal * 30,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.yellow, Colors.red, Colors.indigo, Colors.teal]),
          //color: Colors.grey[500],
          borderRadius: BorderRadius.all(Radius.circular(20))));
}

/*
          Container(
              //margin: EdgeInsets.symmetric(vertical: 10),
              //a slider to change the brightness
              child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.grey[700],
                    inactiveTrackColor: Colors.white,
                    trackShape: RoundedRectSliderTrackShape(),
                    trackHeight: SizeConfig.blockSizeHorizontal * 0.1,
                    thumbColor: Colors.white,
                    thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: SizeConfig.blockSizeHorizontal * 4),
                    overlayColor: Colors.transparent,
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                    valueIndicatorColor: Colors.grey[700],
                    showValueIndicator: ShowValueIndicator.always,
                    valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                    valueIndicatorTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  child: FutureBuilder(
                      future: databaseReference.child("Br").once(),
                      builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                        int br = snapshot.data.value;
                        return Slider(
                            value: br.toDouble(),
                            label: br.round().toString(),
                            min: 0,
                            max: 100,
                            //as the slider's state chaanges, it sends its data to the database
                            onChanged: (double value) {
                              databaseReference
                                  .update({'Br': brightness.round()});
                              setState(() => brightness = value.toInt());
                            });
                      }))),*/
