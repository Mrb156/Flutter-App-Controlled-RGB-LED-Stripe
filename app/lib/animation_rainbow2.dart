import 'package:flutter/material.dart';
import 'main.dart';

class Anim2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimContainer2(),
    );
  }
}

class AnimContainer2 extends StatefulWidget {
  @override
  _AnimContainerState2 createState() => _AnimContainerState2();
}

class _AnimContainerState2 extends State<AnimContainer2>
    with TickerProviderStateMixin {
  DecorationTween decorationTween;
  AnimationController _controller;

  Animatable<Decoration> background = TweenSequence<Decoration>(
    [
      TweenSequenceItem(
        weight: 1.0,
        tween: DecorationTween(
          begin: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.red,
                    Colors.yellow[800],
                    Colors.green,
                    Colors.blue,
                    Colors.purple,
                  ])),
          end: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.purple,
                    Colors.red,
                    Colors.yellow[800],
                    Colors.green,
                    Colors.blue,
                  ])),
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: DecorationTween(
          begin: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.purple,
                    Colors.red,
                    Colors.yellow[800],
                    Colors.green,
                    Colors.blue,
                  ])),
          end: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.blue,
                    Colors.purple,
                    Colors.red,
                    Colors.yellow[800],
                    Colors.green,
                  ])),
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: DecorationTween(
          begin: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.blue,
                    Colors.purple,
                    Colors.red,
                    Colors.yellow[800],
                    Colors.green,
                  ])),
          end: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.green,
                    Colors.blue,
                    Colors.purple,
                    Colors.red,
                    Colors.yellow[800],
                  ])),
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: DecorationTween(
          begin: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.green,
                    Colors.blue,
                    Colors.purple,
                    Colors.red,
                    Colors.yellow[800],
                  ])),
          end: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.yellow[800],
                    Colors.green,
                    Colors.blue,
                    Colors.purple,
                    Colors.red,
                  ])),
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: DecorationTween(
          begin: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.yellow[800],
                    Colors.green,
                    Colors.blue,
                    Colors.purple,
                    Colors.red,
                  ])),
          end: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.red,
                    Colors.yellow[800],
                    Colors.green,
                    Colors.blue,
                    Colors.purple,
                  ])),
        ),
      ),
    ],
  );

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _controller.repeat();
    //_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Center(
          child: Container(
            height: SizeConfig.blockSizeVertical * 10,
            width: SizeConfig.blockSizeHorizontal * 30,
            decoration:
                background.evaluate(AlwaysStoppedAnimation(_controller.value)),
          ),
        );
      },
    );
  }
}
