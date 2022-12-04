import 'package:comunidade_de_engenheiros_de_software/api/model/base/base_model.dart';
import 'package:comunidade_de_engenheiros_de_software/util/reflector.dart';

@reflector
class User extends BaseModel {
  final bool _isADM;
  bool isEnable;
  //bool isApproved;
  final String? name;
  //final String? picture;
  //final String? dateApprove;
  final String cpf;
  String? email;

  bool isNewUser = false;

  bool get isADM {
    return _isADM;
  }

  User.test()
      : _isADM = false,
        isEnable = true,
        name = null,
        //isApproved = true,
        //picture = null,
        //dateApprove = "2022-01-01",
        cpf = "",
        email = null,
        super.init();

  User.fromJson(super.map)
      : _isADM = map["isADM"] ?? false,
        isEnable = map["isEnable"] ?? false,
        name = map["name"] ?? null,
        //isApproved = map["isApproved"] ?? false,
        //picture = map["picture"],
        //dateApprove = map["dateApprove"],
        cpf = map["cpf"],
        email = map["email"],
        isNewUser = map["isNewUser"],
        super.fromJson();

  User({
    required bool isADM,
    required this.isEnable,
    //required this.isApproved,
    this.name,
    //this.picture,
    //this.dateApprove,
    this.cpf = "",
    this.email,
  })  : _isADM = isADM,
        isNewUser = true,
        super.init();

  @override
  Map<String, dynamic> toJson() => {
        "isADM": _isADM,
        "isEnable": isEnable,
        "name": name,
        //"isApproved": isApproved,
        //"picture": picture,
        //"dateApprove": dateApprove,
        "cpf": cpf,
        "email": email,
        "isNewUser": isNewUser,
      };
}
