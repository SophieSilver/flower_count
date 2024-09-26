import 'package:flutter/material.dart';

class RemoveAnimation extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;
  const RemoveAnimation(
      {super.key, required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    final reversedAnimation = ReverseAnimation(animation);
    final sizeFactor = Tween(begin: 1.0, end: .0).animate(
      CurvedAnimation(
        parent: reversedAnimation,
        curve: Interval(0.3, 1.0, curve: Curves.easeInQuad),
      ),
    );

    final shiftFactor = Tween(begin: Offset.zero, end: Offset(-1, 0)).animate(
      CurvedAnimation(
        parent: reversedAnimation,
        curve: Interval(0.0, 0.9, curve: Curves.easeInQuad),
      ),
    );

    return SlideTransition(
      position: shiftFactor,
      child: SizeTransition(
        sizeFactor: sizeFactor,
        child: child,
      ),
    );
  }
}
