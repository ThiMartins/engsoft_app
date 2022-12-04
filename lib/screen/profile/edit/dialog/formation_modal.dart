import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/formation.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/profile/edit/dialog/viewmodel/base_view_model.dart';
import 'package:comunidade_de_engenheiros_de_software/util/app_color.dart';
import 'package:comunidade_de_engenheiros_de_software/util/global/format.dart';
import 'package:comunidade_de_engenheiros_de_software/util/view/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FormationModal extends StatefulWidget {
  final Formation? update;
  const FormationModal({Key? key, this.update}) : super(key: key);

  @override
  State<FormationModal> createState() => _FormationModalState();
}

class _FormationModalState extends State<FormationModal> {
  final TextEditingController nameSchool = TextEditingController();
  final TextEditingController dateAdmission = TextEditingController();
  final TextEditingController dateFinish = TextEditingController();

  @override
  void initState() {
    nameSchool.text = widget.update?.institution ?? "";
    dateAdmission.text = widget.update?.dateStart ?? "";
    dateFinish.text = widget.update?.dateFinish ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              TextFormField(
                controller: nameSchool,
                decoration: const InputDecoration(
                  labelText: 'Nome da instituição',
                  hintText: 'Nome da instituição:',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                keyboardType: TextInputType.none,
                controller: dateAdmission,
                decoration: const InputDecoration(
                  labelText: 'Início',
                  hintText: 'Início',
                ),
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  final DateTime? startTime = await _getDate(context);
                  if (startTime != null) {
                    dateAdmission.text = Format.formatDateTime(startTime, format: 'dd/MM/yyyy');
                  }
                },
              ),
              Observer(
                builder: (context) {
                  return TextFormField(
                    controller: dateFinish,
                    decoration: const InputDecoration(
                      labelText: 'Término',
                      hintText: 'Término:',
                    ),
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      final DateTime? endTime = await _getDate(context);
                      if (endTime != null) {
                        dateFinish.text = Format.formatDateTime(endTime, format: 'dd/MM/yyyy');
                      }
                    },
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: AppButton(
                  onPressed: () async {
                    Navigator.pop(context, Formation(nameSchool.text, dateAdmission.text, dateFinish.text));
                  },
                  text: widget.update != null ? 'Atualizar' : 'Salvar',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime?> _getDate(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.fromMicrosecondsSinceEpoch(0),
      lastDate: DateTime.now(),
    );
  }
}
