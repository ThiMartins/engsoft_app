import 'dart:math';

import 'package:comunidade_de_engenheiros_de_software/api/model/base/base_model.dart';
import 'package:comunidade_de_engenheiros_de_software/util/global/format.dart';

class Project extends BaseModel {
  int id;
  String name;
  String description;
  String goals;
  String dateStart;
  String? dateFinish;
  String functions;
  String technologies;

  Project(this.name, this.description, this.goals, this.dateStart, this.dateFinish, this.functions, this.technologies, {this.id = 0}) : super.init();

  Project.fromJson(super.map)
      : id = map["id"],
        name = map["nome"],
        description = map["descricao"],
        goals = map["objetivos"],
        dateStart = map["dataInicio"],
        dateFinish = map["dataFim"],
        functions = map["funcoes"],
        technologies = map["tecnologias"],
        super.fromJson();

  Project.test()
      : id = Random().nextInt(100000),
        name = "Name Project",
        description = "Description of project",
        goals = "Goals of project",
        dateStart = "2022-10-10",
        dateFinish = null,
        functions = "Developer",
        technologies = "Kotlin/Java/Flutter",
        super.fromJson({});

  String get info {
    String finish = "até o momento";
    if (dateFinish != null) finish = "até ${Format.formatDate(dateFinish!)}";

    return "${Format.formatDate(dateStart)} $finish";
  }

  @override
  Map<String, dynamic> toJson() => {};

  void copy(Project other) {
    name = other.name;
    description = other.description;
    goals = other.goals;
    dateStart = other.dateStart;
    dateFinish = other.dateFinish;
    functions = other.functions;
    technologies = other.technologies;
  }
}
