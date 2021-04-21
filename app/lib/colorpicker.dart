import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'main.dart';
import 'package:firebase_database/firebase_database.dart';

class CPHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ColorPickerWidget());
  }
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

final databaseReference = FirebaseDatabase.instance.reference();

class ColorPickerWidget extends StatefulWidget {
  const ColorPickerWidget({Key key}) : super(key: key);
  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPickerWidget> {
  Color _pickerColor;
  void changeColor(Color color) {
    _pickerColor = color;
    databaseReference.update({'Br': _pickerColor.alpha});
    // databaseReference.child("Színek").update({'Red': _pickerColor.red});
    // databaseReference.child("Színek").update({'Green': _pickerColor.green});
    // databaseReference.child("Színek").update({'Blue': _pickerColor.blue});
    // databaseReference.update({
    //   'SetUp': 'szín' +
    //       ' ' +
    //       _pickerColor.red.toString() +
    //       ' ' +
    //       _pickerColor.green.toString() +
    //       ' ' +
    //       _pickerColor.blue.toString()
    // });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            child: FutureBuilder(
              future: databaseReference.child("Színek").once(),
              builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                List lists = [];
                Map<dynamic, dynamic> values = snapshot.data.value;
                values.forEach((key, values) {
                  lists.add(values);
                });
                _pickerColor = Color.fromRGBO(lists[0], lists[2], lists[1], 1);
                return Container(
                    child: ColorPicker(
                  displayThumbColor: true,
                  pickerColor: _pickerColor,
                  onColorChanged: changeColor,
                  showLabel: false,
                  pickerAreaHeightPercent: 1,
                  colorPickerWidth: SizeConfig.blockSizeHorizontal * 70,
                  enableAlpha: true,
                  portraitOnly: true,
                  pickerAreaBorderRadius: BorderRadius.circular(50),
                ));
              },
            ),
          ),
          OutlineButton(child: Text('Set'), onPressed: onPressed),
        ],
      ),
    );
  }

  void onPressed() {
    databaseReference.child("Színek").update({'Red': _pickerColor.red});
    databaseReference.child("Színek").update({'Green': _pickerColor.green});
    databaseReference.child("Színek").update({'Blue': _pickerColor.blue});

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
}
