import 'package:flutter/material.dart';

class ConfirmDelete extends StatelessWidget {
  const ConfirmDelete({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      backgroundColor: colorScheme.surfaceContainerHighest,
      child: Container(
        padding: const EdgeInsets.all(24.0).copyWith(bottom: 10.0),
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Удалить событие",
                style: textTheme.titleLarge
                    ?.copyWith(color: colorScheme.onSurface),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                "Вы уверены, что хотите удалить это событие?",
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text("Отмена"),
                  ),
                  const SizedBox(width: 10.0),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text("Удалить"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
