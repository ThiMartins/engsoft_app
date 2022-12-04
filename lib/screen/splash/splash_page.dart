import 'package:comunidade_de_engenheiros_de_software/api/service/AuthService.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/login/login_page.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/main/main_page.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/splash/splash_view_model.dart';
import 'package:comunidade_de_engenheiros_de_software/util/app_color.dart';
import 'package:comunidade_de_engenheiros_de_software/util/base/constants.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  final SplashViewModel viewModel =
      SplashViewModel(service: getIt<AuthService>());

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.isLogged().then((value) {
      Widget page = LoginPage();
      if (value) {
        widget.viewModel.refreshToken().then((updatedToken) {
          if (updatedToken == null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Unable action')));
            return;
          }
          if (updatedToken == true) {
            page = const MainPage();
          }
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => page));
        }).catchError((e) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => page));
        });
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => page));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.primaryColor,
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(75),
            child: Image.asset(
              'images/icon.jpg',
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
