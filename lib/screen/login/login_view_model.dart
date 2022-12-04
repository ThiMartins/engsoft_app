import 'package:comunidade_de_engenheiros_de_software/api/model/auth/auth.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/auth/token.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/user/create_user.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/user/user.dart';
import 'package:comunidade_de_engenheiros_de_software/api/service/AuthService.dart';
import 'package:comunidade_de_engenheiros_de_software/util/base/constants.dart';
import 'package:comunidade_de_engenheiros_de_software/util/global/pair.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel {
  final AuthService authService;

  LoginViewModel({required this.authService});

  Future<bool> login(String? cpf, String? password) async {
    try {
      final response = await authService.login(Auth(cpf, password));

      final preferences = await SharedPreferences.getInstance();

      await preferences.setString(appUser, response.second.toString());
      await preferences.setString(tokenUser, response.first.toString());
    } catch (e) {
      return false;
    }

    return true;
  }

  Future<Pair<Token, User>?> create(CreateUser user) async {
    final response = await authService.create(user);
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString(appUser, response.second.toString());
    await preferences.setString(tokenUser, response.first.toString());

    return response;
  }

  Future<bool> resetPassword(String? email) async {
    try {
      await authService.resetPassword(email);
    } catch (e) {
      return false;
    }

    return true;
  }
}
