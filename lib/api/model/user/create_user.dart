import 'package:comunidade_de_engenheiros_de_software/api/model/base/base_model.dart';

class CreateUser extends BaseModel {
  String name;
  String cpf;
  String email;
  String password;
  String birthday;
  String location;
  String phone;

  CreateUser({
    required this.name,
    required this.cpf,
    required this.email,
    required this.password,
    required this.birthday,
    required this.location,
    required this.phone,
  }) : super.init();

  @override
  Map<String, dynamic> toJson() => {
    "nome" : name,
    "cpf" : cpf,
    "email" : email,
    "password" : password,
    "data_nascimento" : birthday,
    "endereco" : location,
    "telefone" : phone,
  };
}
