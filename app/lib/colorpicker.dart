import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'main.dart';
import 'package:firebase_database/firebase_database.dart';

class CPHome extends StatelessWidget {
  // CPHome({Key key, @required this.brightness,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(child: ColorPickerWidget());
  }
}

class ColorPickerWidget extends StatefulWidget {
  //const ColorPickerWidget({Key key}) : super(key: key);
  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPickerWidget> {
  Color pickerColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          SizedBox(
            height: 200,
          ),
          Container(
            color: Colors.white,
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
              showLabel: false,
              pickerAreaHeightPercent: 0.8,
              enableAlpha: false,
              pickerAreaBorderRadius: BorderRadius.circular(33),
            ),
          ),
          OutlineButton(
              child: Text('Set'),
              onPressed: () {
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
              }),
          OutlineButton(
              child: Text('Back'),
              color: Colors.white,
              textColor: Colors.black,
              onPressed: () {
                Navigator.push(context, FadeRoute(page: MyApp()));
              })
        ]));
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }
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

final databaseReference = FirebaseDatabase.instance.reference();
