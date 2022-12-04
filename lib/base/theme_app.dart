import 'package:comunidade_de_engenheiros_de_software/screen/splash/splash_page.dart';
import 'package:comunidade_de_engenheiros_de_software/util/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeApp extends StatelessWidget {
  const ThemeApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        splashColor: AppColor.primaryColor,
        appBarTheme: AppBarTheme(
          toolbarHeight: 80,
          elevation: 0,
          color: AppColor.primaryColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColor.primaryColor,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
        ),
        backgroundColor: AppColor.backgroundColor,
        primaryColor: AppColor.primaryColor,
        primaryColorDark: AppColor.primaryColorDark,
        primaryColorLight: AppColor.primaryColorLight,
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          headline2: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          headline5: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          headline6: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: UnderlineInputBorder(
              borderSide: BorderSide(
            color: AppColor.primaryColorDark,
          )),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: AppColor.primaryColorDark,
          )),
          labelStyle: TextStyle(
            color: AppColor.primaryColorDark,
          ),
          hintStyle: TextStyle(
            color: AppColor.primaryColorLight,
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: AppColor.primaryColorDark,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
