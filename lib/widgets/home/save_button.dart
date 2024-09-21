import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final void Function()? onPress;
  const SaveButton({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: this.onPress,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.save),
          SizedBox(width: 15.0),
          Text("Сохранить"),
        ],
      ),
    );
  }
}
