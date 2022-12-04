import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/experience.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/profile/edit/dialog/viewmodel/base_view_model.dart';
import 'package:comunidade_de_engenheiros_de_software/util/app_color.dart';
import 'package:comunidade_de_engenheiros_de_software/util/global/format.dart';
import 'package:comunidade_de_engenheiros_de_software/util/view/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ExperienceModal extends StatefulWidget {
  final Experience? update;

  const ExperienceModal({Key? key, this.update}) : super(key: key);

  @override
  State<ExperienceModal> createState() => _ExperienceModalState();
}

class _ExperienceModalState extends State<ExperienceModal> {

  final TextEditingController nameEnterprise = TextEditingController();
  final TextEditingController dateAdmission = TextEditingController();
  final TextEditingController dateFinish = TextEditingController();

  final BaseStateViewModel viewModel = BaseStateViewModel();

  @override
  void initState() {
    nameEnterprise.text = widget.update?.enterprise ?? "";
    dateAdmission.text = widget.update?.dateAdmission ?? "";
    dateFinish.text = widget.update?.dateFinish ?? "";

    viewModel.hasDateFinish = dateFinish.text.isNotEmpty;

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
                controller: nameEnterprise,
                decoration: const InputDecoration(
                  labelText: 'Nome da empresa',
                  hintText: 'Nome da empresa:',
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Checkbox(
                            checkColor: AppColor.backgroundColor,
                            activeColor: AppColor.primaryColor,
                            value: !viewModel.hasDateFinish,
                            onChanged: (newState) {
                              viewModel.hasDateFinish = !(newState ?? true);
                            },
                          ),
                        ),
                        const Text(
                          'Trabalho atualmente neste cargo',
                        ),
                      ],
                    ),
                  );
                },
              ),
              Observer(
                builder: (context) {
                  return Visibility(
                    visible: viewModel.hasDateFinish,
                    child: TextFormField(
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
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: AppButton(
                  onPressed: () async {
                    Navigator.pop(context, Experience(nameEnterprise.text, dateAdmission.text, dateFinish: viewModel.hasDateFinish ? dateFinish.text : null));
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
