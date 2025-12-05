import 'package:flutter/material.dart';
import '../scenes/login/login_factory.dart';
import 'app_shell.dart';

class AppRoutes {
  static const String login = '/';
  static const String home = '/home';

  static Map<String, WidgetBuilder> get routes => {
        login: (context) => LoginFactory.create(context),
        home: (context) => const AppShell(),
      };
}