import 'package:flutter/material.dart';

class ConfirmDelete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      backgroundColor: colorScheme.surfaceContainerHighest,
      child: Container(
        padding: EdgeInsets.all(24.0).copyWith(bottom: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Удалить событие",
              style:
                  textTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Вы уверены, что хотите удалить это событие?",
              style: textTheme.bodyMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text("Отмена"),
                ),
                SizedBox(width: 10.0),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text("Удалить"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
