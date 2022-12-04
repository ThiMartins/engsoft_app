import 'package:flutter_test/flutter_test.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/user/create_user.dart';

void main() {
  final user = CreateUser(
      name: "Thiago",
      cpf: "<22222222222>",
      birthday: "",
      email: "teste@teste.com",
      location: "",
      password: "",
      phone: "");

  test("CPF deve ser 22222222222:", () {
    expect(user.cpf, '<22222222222>');
  });

  test("CPF deve ser teste@teste.com:", () {
    expect(user.email, 'teste@teste.com');
  });
}
