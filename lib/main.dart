import 'package:comunidade_de_engenheiros_de_software/api/manager/api.dart';
import 'package:comunidade_de_engenheiros_de_software/base/theme_app.dart';
import 'package:comunidade_de_engenheiros_de_software/main.reflectable.dart';
import 'package:comunidade_de_engenheiros_de_software/util/base/constants.dart';
import 'package:flutter/material.dart';

void main() async {
  await API.loadAPI();
  configureDependencies();
  initializeReflectable();
  runApp(const ThemeApp());
}
