import 'package:flutter/material.dart';

class Routes {
  static Routes instance = Routes();
  Future<dynamic> pushAndRemoveUtil(
      {required widget, required BuildContext context}) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => widget), (Route) => false);
  }

  Future<dynamic> push({required widget, required BuildContext context}) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => widget),
    );
  }
}
