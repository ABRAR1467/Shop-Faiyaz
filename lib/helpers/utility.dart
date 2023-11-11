import 'package:flutter/widgets.dart';
import 'package:shop_app/main.dart';

class Utility{
  static get context => MyApp.navKey.currentContext!;
  static pop() => Navigator.of(context).pop();
}