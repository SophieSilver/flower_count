import 'package:flutter/material.dart';

class ClickNotifier extends ChangeNotifier {
  void notify() => notifyListeners();
}