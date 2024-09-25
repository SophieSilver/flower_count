import 'package:flower_count/widgets/home/counter/click_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class OnClickPopUp extends HookWidget {
  const OnClickPopUp({super.key});

  void _onClick(AnimationController controller, BuildContext context) async {
    double startPosition = controller.value;

    final animationFuture = controller.animateWith(
      SpringSimulation(
          SpringDescription.withDampingRatio(
            mass: 1.5,
            stiffness: 200.0,
            ratio: 0.10 + 0.4 * (0.5 - startPosition),
          ),
          startPosition,
          0.5,
          startPosition),
    );
    // this would be cancelled if the controller was dismissed or is playing another animation
    await animationFuture;
    controller.animateBack(
      0.0,
      duration: const Duration(milliseconds: 700),
      curve: const Interval(0.33, 1.0, curve: Curves.easeInOutBack),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final controller = useAnimationController(duration: const Duration(seconds: 1));

    useOnListenableChange(
      Provider.of<ClickNotifier>(context, listen: false),
      () {
        _onClick(controller, context);
      },
    );

    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 5.0), end: const Offset(0, 0.0))
          .animate(Tween<double>(begin: 0.0, end: 2.0).animate(controller)),
      child: Card.filled(
        elevation: 2.0,
        color: colorScheme.primaryContainer,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Событие добавлено!",
            style: textTheme.titleMedium
                ?.copyWith(color: colorScheme.onPrimaryContainer),
          ),
        ),
      ),
    );
  }
}
