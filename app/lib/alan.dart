import 'package:flutter/material.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ui_design/main.dart';

class Alan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Al(),
    );
  }
}

class Al extends StatefulWidget {
  @override
  _AlState createState() => _AlState();
}

final databaseReference =
    FirebaseDatabase.instance.reference(); //reach the database's data

class _AlState extends State<Al> {
  _AlState() {
    AlanVoice.addButton(
        "0e7d288df30cf1de8c98e42ecb9d840e2e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT);
    AlanVoice.callbacks.add((command) => _handleCommand(command.data));
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

void beallitFeher() {
  databaseReference.child("Colors").update({'Red': 255});
  databaseReference.child("Colors").update({'Green': 255});
  databaseReference.child("Colors").update({'Blue': 255});
  databaseReference.update({
    'SetUp': 'szín' +
        ' ' +
        255.toString() +
        ' ' +
        255.toString() +
        ' ' +
        255.toString()
  });
}

void beallitZold() {
  databaseReference.child("Colors").update({'Red': 6});
  databaseReference.child("Colors").update({'Green': 171});
  databaseReference.child("Colors").update({'Blue': 0});
  databaseReference.update({
    'SetUp': 'szín' +
        ' ' +
        255.toString() +
        ' ' +
        255.toString() +
        ' ' +
        255.toString()
  });
}

void beallitKek() {
  databaseReference.child("Colors").update({'Red': 0});
  databaseReference.child("Colors").update({'Green': 151});
  databaseReference.child("Colors").update({'Blue': 171});
  databaseReference.update({
    'SetUp': 'szín' +
        ' ' +
        255.toString() +
        ' ' +
        255.toString() +
        ' ' +
        255.toString()
  });
}

void beallitPiros() {
  databaseReference.child("Colors").update({'Red': 171});
  databaseReference.child("Colors").update({'Green': 0});
  databaseReference.child("Colors").update({'Blue': 0});
  databaseReference.update({
    'SetUp': 'szín' +
        ' ' +
        255.toString() +
        ' ' +
        255.toString() +
        ' ' +
        255.toString()
  });
}

void beallitLila() {
  databaseReference.child("Colors").update({'Red': 89});
  databaseReference.child("Colors").update({'Green': 0});
  databaseReference.child("Colors").update({'Blue': 171});
  databaseReference.update({
    'SetUp': 'szín' +
        ' ' +
        255.toString() +
        ' ' +
        255.toString() +
        ' ' +
        255.toString()
  });
}

void beallitPink() {
  databaseReference.child("Colors").update({'Red': 171});
  databaseReference.child("Colors").update({'Green': 0});
  databaseReference.child("Colors").update({'Blue': 84});
  databaseReference.update({
    'SetUp': 'szín' +
        ' ' +
        255.toString() +
        ' ' +
        255.toString() +
        ' ' +
        255.toString()
  });
}

void beallitNarancs() {
  databaseReference.child("Colors").update({'Red': 171});
  databaseReference.child("Colors").update({'Green': 67});
  databaseReference.child("Colors").update({'Blue': 0});
  databaseReference.update({
    'SetUp': 'szín' +
        ' ' +
        255.toString() +
        ' ' +
        255.toString() +
        ' ' +
        255.toString()
  });
}

void beallitSarga() {
  databaseReference.child("Colors").update({'Red': 250});
  databaseReference.child("Colors").update({'Green': 224});
  databaseReference.child("Colors").update({'Blue': 0});
  databaseReference.update({
    'SetUp': 'szín' +
        ' ' +
        255.toString() +
        ' ' +
        255.toString() +
        ' ' +
        255.toString()
  });
}

void beallitBr(int value) {
  databaseReference.child("Colors").update({"Br": value});
  databaseReference.update({"Br": value});
}

void bekapcs() {
  databaseReference.child("Colors").update({"Br": 100});
  databaseReference.update({"Br": 100});
}

void kikapcs() {
  databaseReference.child("Colors").update({"Br": 0});
  databaseReference.update({"Br": 0});
}

_handleCommand(Map<String, dynamic> response) {
  switch (response["command"]) {
    case "white":
      beallitFeher();
      break;
    case "green":
      beallitZold();
      break;
    case "blue":
      beallitKek();
      break;
    case "red":
      beallitPiros();
      break;
    case "purple":
      beallitLila();
      break;
    case "pink":
      beallitPink();
      break;
    case "orange":
      beallitNarancs();
      break;
    case "yellow":
      beallitSarga();
      break;
    case "turn on":
      bekapcs();
      break;
    case "turn off":
      kikapcs();
      break;
    case "brightness":
      beallitBr(int.parse(response["value"]));
      break;

    default:
  }
}
