import 'dart:math';

import 'package:comunidade_de_engenheiros_de_software/api/model/base/base_model.dart';

class Skills extends BaseModel {
  int id;
  String description;
  String level;

  Skills(this.description, this.level, {int? id})
      : id = id ?? Random().nextInt(1000),
        super.init();

  Skills.fromJson(super.map)
      : id = map["id"],
        description = map["description"],
        level = map["level"],
        super.fromJson();

  Skills.test()
      : id = Random().nextInt(1000),
        description = "Test ability",
        level = "Advance",
        super.fromJson({});

  String get name {
    return "$description - $level";
  }

  @override
  Map<String, dynamic> toJson() => {};
}
