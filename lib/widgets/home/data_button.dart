import 'package:flutter/material.dart';

class DataButton extends StatelessWidget {
  final void Function()? onPress;
  const DataButton({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: this.onPress,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.date_range),
          SizedBox(width: 15.0),
          Text("Данные"),
        ],
      ),
    );
  }
}
