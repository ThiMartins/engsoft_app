import 'dart:math';

import 'package:comunidade_de_engenheiros_de_software/api/model/base/base_model.dart';
import 'package:comunidade_de_engenheiros_de_software/util/global/format.dart';

class Experience extends BaseModel {
  int id;
  String enterprise;
  String dateAdmission;
  String? dateFinish;

  Experience.fromJson(Map<String, dynamic> map)
      : id = map["id"],
        enterprise = map["empresa"],
        dateAdmission = map["dataAdmissao"],
        dateFinish = map["dataDesligamento"],
        super.fromJson(map);

  Experience.test()
      : id = Random().nextInt(100000),
        enterprise = "Name enterprise",
        dateAdmission = "2022-09-09",
        dateFinish = "2022-10-10",
        super.fromJson({});

  Experience(this.enterprise, this.dateAdmission, {this.dateFinish})
      : id = Random().nextInt(100000),
        super.init();

  String get info {
    String finish = "até o momento";
    if (dateFinish != null)
      finish =
          "até ${Format.formatDate(dateFinish!, format: "MMMM 'de' yyyy")}";

    return "${Format.formatDate(dateAdmission, format: "MMMM 'de' yyyy")} $finish";
  }

  @override
  Map<String, dynamic> toJson() => {
        "empresa": enterprise,
        "dataAdmissao": dateAdmission,
        "dataDesligamento": dateFinish,
      };

  void copy(Experience other) {
    enterprise = other.enterprise;
    dateAdmission = other.dateAdmission;
    dateFinish = other.dateFinish;
  }
}
