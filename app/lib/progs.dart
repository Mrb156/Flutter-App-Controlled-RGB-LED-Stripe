import 'package:flutter/material.dart';

class ProgsW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Container(
              color: Color(0xebebebeb),
              child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        height: 200,
                        width: 400,
                        child: ListView(
                            padding: EdgeInsets.symmetric(vertical: 200),
                            scrollDirection: Axis.horizontal,
                            children: [
                              progs(Container(), "text"),
                              progs(Container(), "text"),
                              progs(Container(), "text")
                            ]),
                      ),
                    ],
                  )))),
    );
  }
}

class ProgButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 20,
      width: 200,
      decoration: new BoxDecoration(
          color: Color(0xebebebeb),
          borderRadius: new BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Color(0xC8C8C8C8),
              offset: Offset(15, 15),
              blurRadius: 32,
            ),
            BoxShadow(
              color: Color(0xFFFFFFFF),
              offset: Offset(-15, -15),
              blurRadius: 32,
            ),
          ]),
      child: Column(
        children: [
          Container(),
          SizedBox(
            height: 10,
          ),
          Text(
            "text",
            style: TextStyle(fontSize: 30),
          )
        ],
      ),
    );
  }
}

Container progs(Widget cover, String text) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
    height: 50,
    width: 200,
    decoration: new BoxDecoration(
        color: Color(0xebebebeb),
        borderRadius: new BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Color(0xC8C8C8C8),
            offset: Offset(15, 15),
            blurRadius: 32,
          ),
          BoxShadow(
            color: Color(0xFFFFFFFF),
            offset: Offset(-15, -15),
            blurRadius: 32,
          ),
        ]),
    child: Column(
      children: [
        cover,
        SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 30),
        )
      ],
    ),
  );
}
