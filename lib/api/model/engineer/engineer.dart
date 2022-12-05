import 'dart:math';

import 'package:comunidade_de_engenheiros_de_software/api/model/base/base_model.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/experience.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/formation.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/project.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/skills.dart';
import 'package:comunidade_de_engenheiros_de_software/util/api_util.dart';
import 'package:comunidade_de_engenheiros_de_software/util/reflector.dart';
import 'package:image_picker/image_picker.dart';

@reflector
class Engineer extends BaseModel {
  int id;
  bool isApproved = false;
  //bool isEnable = true;
  String nickname;
  String birthday;
  String cpf;
  String address;
  String phone;
  String picture = "";
  String profile = "";
  List<Formation> formations;
  List<Experience> experiences;
  List<Project> projects;
  List<Skills> skills;

  Engineer({
    required this.id,
    required this.isApproved,
    //required this.isEnable,
    required this.nickname,
    required this.birthday,
    required this.cpf,
    required this.address,
    required this.phone,
    required this.picture,
    required this.profile,
    required this.formations,
    required this.experiences,
    required this.projects,
    required this.skills,
  }) : super.init();

  Engineer.fromJson(super.map)
      : id = map["id"],
        nickname = map["apelido"],
        birthday = map["dataNascimento"],
        cpf = map["cpf"],
        address = map["endereco"],
        phone = map["telefone"],
        picture = map["foto"],
        formations = [],
        experiences = [],
        projects = [],
        skills = [],
        /*       
        formations = toListObject(map["formacoes"]),
        experiences = toListObject(map["formacoes"]),
        projects = toListObject(map["projetos"]),
        skills = toListObject(map["habilidades"]),
        */
        super.fromJson();

  Engineer.test({int? id, String? name, bool? isApproved, String? picture})
      : id = id ?? 10,
        nickname = name ?? "Name test",
        birthday = "2022-09-09",
        cpf = "12345678900",
        address = "Rua Qualquer, Bairro x - Cidade/UF",
        phone = "15123456789",
        picture = picture ?? "",
        formations = [
          Formation.test(),
          Formation.test(),
          Formation.test(),
        ],
        experiences = [
          Experience.test(),
          Experience.test(),
        ],
        projects = [
          Project.test(),
          Project.test(),
          Project.test(),
          Project.test(),
          Project.test(),
        ],
        skills = [
          Skills.test(),
          Skills.test(),
          Skills.test(),
        ],
        profile = "Perfil de Teste",
        //isEnable = isEnable ?? true,
        isApproved = isApproved ?? Random().nextBool(),
        super.fromJson({});

  @override
  Map<String, dynamic> toJson() => {};
}
