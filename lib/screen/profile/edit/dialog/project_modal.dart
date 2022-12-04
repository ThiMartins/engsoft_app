import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/project.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/profile/edit/dialog/viewmodel/base_view_model.dart';
import 'package:comunidade_de_engenheiros_de_software/util/app_color.dart';
import 'package:comunidade_de_engenheiros_de_software/util/global/format.dart';
import 'package:comunidade_de_engenheiros_de_software/util/view/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ProjectModal extends StatefulWidget {
  final Project? update;

  const ProjectModal({Key? key, this.update}) : super(key: key);

  @override
  State<ProjectModal> createState() => _ProjectModalState();
}

class _ProjectModalState extends State<ProjectModal> {
  final TextEditingController nameProject = TextEditingController();
  final TextEditingController descriptionProject = TextEditingController();
  final TextEditingController goalsProject = TextEditingController();
  final TextEditingController functionsProject = TextEditingController();
  final TextEditingController technologiesProject = TextEditingController();
  final TextEditingController dateStart = TextEditingController();
  final TextEditingController dateFinish = TextEditingController();

  final BaseStateViewModel viewModel = BaseStateViewModel();

  @override
  void initState() {
    nameProject.text = widget.update?.name ?? "";
    descriptionProject.text = widget.update?.description ?? "";
    goalsProject.text = widget.update?.goals ?? "";
    functionsProject.text = widget.update?.functions ?? "";
    technologiesProject.text = widget.update?.technologies ?? "";
    dateStart.text = widget.update?.dateStart ?? "";
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
                controller: nameProject,
                decoration: const InputDecoration(
                  labelText: 'Nome do projeto',
                  hintText: 'Nome do projeto:',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: descriptionProject,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: 'Descrição do projeto',
                  hintText: 'Descrição do projeto:',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: goalsProject,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: 'Objetivos do projeto',
                  hintText: 'Objetivos do projeto:',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: functionsProject,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: 'Funções ou cargos do projeto',
                  hintText: 'Funções ou cargos do projeto:',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: technologiesProject,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: 'Tecnologias do projeto',
                  hintText: 'Tecnologias do projeto:',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                keyboardType: TextInputType.none,
                controller: dateStart,
                decoration: const InputDecoration(
                  labelText: 'Início',
                  hintText: 'Início',
                ),
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  final DateTime? startTime = await _getDate(context);
                  if (startTime != null) {
                    dateStart.text = Format.formatDateTime(startTime, format: 'dd/MM/yyyy');
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
                          'Trabalho atualmente neste projeto',
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
                    Navigator.pop(context, Project(nameProject.text, descriptionProject.text, goalsProject.text, dateStart.text, viewModel.hasDateFinish ? dateFinish.text : null, functionsProject.text, technologiesProject.text));
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
