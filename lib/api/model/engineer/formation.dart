import 'dart:math';

import 'package:comunidade_de_engenheiros_de_software/api/model/base/base_model.dart';

class Formation extends BaseModel {
  int id;
  String institution;
  String dateStart;
  String dateFinish;

  Formation(this.institution, this.dateStart, this.dateFinish, {this.id = 0}) : super.init();

  Formation.fromJson(super.map)
      : id = map["id"],
        institution = map["instituicao"],
        dateStart = map["dataInicio"],
        dateFinish = map["dataFim"],
        super.fromJson();

  Formation.test()
      : id = Random().nextInt(100000),
        institution = "Name school",
        dateStart = "2022-09-09",
        dateFinish = "2022-10-10",
        super.fromJson({});

  String get info {
    return "$institution: $dateStart até $dateFinish";
  }

  @override
  Map<String, dynamic> toJson() => {};

  void copy(Formation other) {
    institution = other.institution;
    dateStart = other.dateStart;
    dateFinish = other.dateFinish;
  }
}
