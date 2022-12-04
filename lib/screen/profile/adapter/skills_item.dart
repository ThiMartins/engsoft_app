import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/skills.dart';
import 'package:flutter/material.dart';

class SkillsItem extends StatelessWidget {
  final Skills skills;

  const SkillsItem({Key? key, required this.skills}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(skills.name);
  }
}
