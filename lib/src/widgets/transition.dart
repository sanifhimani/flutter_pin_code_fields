import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

class TransitionWidget extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;
  final Animations animationType;

  const TransitionWidget({
    Key? key,
    required this.animation,
    required this.child,
    required this.animationType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget transitionWidget = FadeTransition(
      opacity: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(animation),
      child: child,
    );

    switch (animationType) {
      case Animations.fade:
        break;
      case Animations.grow:
        {
          transitionWidget = ScaleTransition(
            scale: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animation),
            child: child,
          );
        }
        break;
      case Animations.shrink:
        {
          transitionWidget = ScaleTransition(
            scale: Tween<double>(
              begin: 1.5,
              end: 1,
            ).animate(animation),
            child: child,
          );
        }
        break;
      case Animations.slideInUp:
        {
          transitionWidget = SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.5),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }
        break;
      case Animations.slideInDown:
        {
          transitionWidget = SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -0.5),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }
        break;
      case Animations.slideInLeft:
        {
          transitionWidget = SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }
        break;
      case Animations.slideInRight:
        {
          transitionWidget = SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }
        break;
      case Animations.rotateLeft:
        {
          transitionWidget = RotationTransition(
            turns: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(animation),
            child: child,
          );
        }
        break;
      case Animations.rotateRight:
        {
          transitionWidget = RotationTransition(
            turns: Tween<double>(
              begin: 1.0,
              end: 0.0,
            ).animate(animation),
            child: child,
          );
        }
        break;
    }

    return transitionWidget;
  }
}
