import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SpriteJumpingAnimation(),
      ),
    );
  }
}

class SpriteJumpingAnimation extends StatefulWidget {
  @override
  _SpriteJumpingAnimationState createState() => _SpriteJumpingAnimationState();
}

class _SpriteJumpingAnimationState extends State<SpriteJumpingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(
      begin: -200,
      end: 200,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.translate(
        offset: Offset(0, _animation.value),
        child: Image.asset(
          'assets/ball.png',
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
