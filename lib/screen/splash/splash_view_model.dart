import 'package:comunidade_de_engenheiros_de_software/api/service/AuthService.dart';
import 'package:comunidade_de_engenheiros_de_software/util/base/constants.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashViewModel {
  @injectable
  final AuthService service;

  SplashViewModel({required this.service});

  Future<bool> isLogged() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.containsKey(tokenUser);
  }

  Future<bool?> refreshToken() async {
    final token = await service.refreshToken();

    if (token == null) {
      return false;
    }

    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(tokenUser, token.toString());

    return true;
  }
}
