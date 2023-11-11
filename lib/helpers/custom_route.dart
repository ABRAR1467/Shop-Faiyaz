import 'package:flutter/material.dart';

class CustomRoute extends PageRouteBuilder {
  final Widget page;
  @override
  final RouteSettings settings;
  CustomRoute({required this.page, required this.settings})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    settings: settings,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => const Duration(microseconds: 0);
}