import 'dart:math';

import 'package:comunidade_de_engenheiros_de_software/api/model/auth/auth.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/auth/token.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/engineer.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/user/create_user.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/user/user.dart';
import 'package:comunidade_de_engenheiros_de_software/api/service/provider_test.dart';
import 'package:comunidade_de_engenheiros_de_software/util/api_util.dart';
import 'package:comunidade_de_engenheiros_de_software/util/base/constants.dart';
import 'package:comunidade_de_engenheiros_de_software/util/global/pair.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthService {
  Future<Pair<Token, User>> login(Auth auth);

  Future<Token?> refreshToken();

  Future<Pair<Token, User>> create(CreateUser user);

  Future resetPassword(String? email);
}

@Injectable(as: AuthService)
class AuthServiceDev extends AuthService {
  @override
  Future<Pair<Token, User>> login(Auth auth) async {
    await Future.delayed(const Duration(seconds: 10));

    for (var element in usersTest) {
      if (element.first.cpf == auth.cpf) {
        if (element.first.isADM && auth.password != "admin") continue;
        return Pair(first: Token.test(), second: element.first);
      }
    }

    throw Exception(["User not found"]);
  }

  @override
  Future<Token?> refreshToken() async {
    await Future.delayed(const Duration(seconds: 5));
    final preferences = await SharedPreferences.getInstance();
    final user = toObject<User>(preferences.getString(appUser) ?? "{}");

    bool contains = false;
    for (var element in usersTest) {
      if (user.cpf == element.first.cpf) contains = true;
    }
    if (!contains) return null;

    return Token.test();
  }

  @override
  Future resetPassword(String? email) async {
    if (email == null || email.isEmpty)
      throw Exception("Por favor preencher o email");
    await Future.delayed(const Duration(seconds: 10));
  }

  @override
  Future<Pair<Token, User>> create(CreateUser user) async {
    await Future.delayed(const Duration(seconds: 5));

    if (user.cpf.length != 11) throw Exception("CPF inválido");
    if (user.name.length < 3) throw Exception("Nome inválido");
    if (user.email.isEmpty) throw Exception("Email inválido");
    if (user.password.length < 6) throw Exception("Senha muito curta");
    if (user.birthday.isEmpty) throw Exception("Data de nascimento inválida");
    if (user.location.isEmpty) throw Exception("Local inválida");
    if (user.phone.length != 11) throw Exception("Telefone inválido");

    final newUser = User(
      isADM: false,
      isEnable: true,
      cpf: user.cpf,
      email: user.email,
    );
    final newEngineer = Engineer(
      id: Random().nextInt(1000),
      isApproved: true,
      //isEnable: true,
      nickname: user.name,
      birthday: user.birthday,
      cpf: user.cpf,
      address: user.location,
      phone: user.phone,
      picture: "",
      profile: "",
      formations: [],
      experiences: [],
      projects: [],
      skills: [],
    );

    usersTest.add(Pair(first: newUser, second: newEngineer));

    return Pair(
      first: Token.test(),
      second: newUser,
    );
  }
}
