import 'package:comunidade_de_engenheiros_de_software/api/model/base/base_model.dart';
import 'package:comunidade_de_engenheiros_de_software/util/reflector.dart';

@reflector
class Token extends BaseModel {
  final String token;
  final String type;

  Token.fromJson(Map<String, dynamic> map)
      : token = map["token"],
        type = map["type"],
        super.fromJson(map);

  String get authToken => "$type $token";

  Token.test() :
        token = "authToken",
        type = "Bearer",
        super.init();

  @override
  Map<String, dynamic> toJson() => {
        "token": token,
        "type": type,
      };
}
