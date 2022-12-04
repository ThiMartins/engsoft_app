import 'package:comunidade_de_engenheiros_de_software/api/model/base/base_model.dart';
import 'package:comunidade_de_engenheiros_de_software/util/reflector.dart';

@reflector
class Auth extends BaseModel {
  final String? cpf;
  final String? password;

  Auth(this.cpf, this.password) : super.init();

  @override
  Map<String, dynamic> toJson() => {
        "cpf": cpf,
        "password": password,
      };
}
