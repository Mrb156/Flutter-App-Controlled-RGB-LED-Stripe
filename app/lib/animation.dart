import 'package:flutter/material.dart';
import 'main.dart';

class Anim extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimContainer(),
    );
  }
}

class AnimContainer extends StatefulWidget {
  @override
  _AnimContainerState createState() => _AnimContainerState();
}

class _AnimContainerState extends State<AnimContainer>
    with TickerProviderStateMixin {
  DecorationTween decorationTween;
  AnimationController _controller;

  Animatable<Color> background = TweenSequence<Color>(
    [
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.red,
          end: Colors.yellow,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.yellow,
          end: Colors.green,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.green,
          end: Colors.blue,
        ),
      ),
      TweenSequenceItem(
          weight: 1.0,
          tween: ColorTween(begin: Colors.blue, end: Colors.purple)),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.purple,
          end: Colors.red,
        ),
      ),
    ],
  );

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 6));
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: background
                  .evaluate(AlwaysStoppedAnimation(_controller.value))),
          height: SizeConfig.blockSizeVertical * 10,
          width: SizeConfig.blockSizeHorizontal * 30,
        );
      },
    );
  }
}
