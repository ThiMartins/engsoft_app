import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/skills.dart';
import 'package:comunidade_de_engenheiros_de_software/util/global/pair.dart';
import 'package:comunidade_de_engenheiros_de_software/util/view/app_button.dart';
import 'package:comunidade_de_engenheiros_de_software/util/view/dropdown.dart';
import 'package:flutter/material.dart';

enum Levels {
  beginner,
  basic,
  intermediary,
  advanced,
  specialist;

  String get level {
    switch (this) {
      case beginner:
        return "Iniciante";
      case basic:
        return "Básico";
      case intermediary:
        return "Intermediário";
      case advanced:
        return "Avançado";
      case specialist:
        return "Especialista";
    }
  }

  @override
  String toString() => level;
}

class SkillsModal extends StatelessWidget {
  final TextEditingController _controller;
  final bool isUpdate;

  SkillsModal({Key? key, Skills? update})
      : _controller = TextEditingController(text: update?.description ?? ""),
        level = Levels.values.firstWhere((element) => element.name == (update?.level ?? ""), orElse: () => Levels.basic),
        isUpdate = update != null,
        super(key: key);

  Levels level = Levels.basic;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: SizedBox(
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Habilidade',
                    hintText: 'Habilidade:',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Nível',
                  style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AppDropdown<Levels>(
                  onChange: (Levels value) {
                    level = value;
                  },
                  items: Levels.values,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: AppButton(
                  onPressed: () {
                    if (_controller.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Preencha o campo do nome da habilidade')));
                      return;
                    }

                    Navigator.pop(context, Pair(first: level, second: _controller.text));
                  },
                  text: isUpdate ? 'Atualizar' : 'Adicionar',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
