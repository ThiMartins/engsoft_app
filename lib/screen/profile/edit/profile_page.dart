import 'dart:io';

import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/engineer.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/experience.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/formation.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/project.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/skills.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/user/user.dart';
import 'package:comunidade_de_engenheiros_de_software/api/service/UserService.dart';
import 'package:comunidade_de_engenheiros_de_software/api/service/provider_test.dart';
import 'package:comunidade_de_engenheiros_de_software/base/view/content_list.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/profile/adapter/experience_item.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/profile/adapter/formation_item.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/profile/adapter/project_item.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/profile/adapter/skills_item.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/profile/edit/dialog/experience_modal.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/profile/edit/dialog/formation_modal.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/profile/edit/dialog/project_modal.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/profile/edit/dialog/skills_modal.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/profile/edit/edit_profile_page.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/profile/edit/profile_view_model.dart';
import 'package:comunidade_de_engenheiros_de_software/util/app_color.dart';
import 'package:comunidade_de_engenheiros_de_software/util/base/constants.dart';
import 'package:comunidade_de_engenheiros_de_software/util/global/format.dart';
import 'package:comunidade_de_engenheiros_de_software/util/global/pair.dart';
import 'package:comunidade_de_engenheiros_de_software/util/view/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileViewModel viewModel =
      ProfileViewModel(service: getIt<UserService>());

  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: FutureBuilder<Pair<Engineer, User>>(
        future: viewModel.getEngineer(),
        builder: (_, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(
                child: Text('Não foi possível carregar seu usuário'));
          }

          final engineer = snapshot.data!.first;
          viewModel.setEngineer(engineer);

          /*final canEditOrAdd = snapshot.data!.second.isApproved ||
              (snapshot.data!.second.isApproved &&
                  snapshot.data!.second.dateApprove != null) ||
              snapshot.data!.second.isNewUser;*/

          const canEditOrAdd = true;

          if (usersImagesTest.containsKey(snapshot.data!.first.id)) {
            viewModel.imageUser = usersImagesTest[snapshot.data!.first.id];
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 32,
                      ),
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(75),
                              child: Observer(builder: (_) {
                                final fileImg = viewModel.imageUser;
                                final urlImg = snapshot.data!.first.picture;

                                if (fileImg != null) {
                                  return Image.file(
                                    File(fileImg.path),
                                    fit: BoxFit.cover,
                                    height: 150,
                                    width: 150,
                                  );
                                }

                                if (urlImg == null || urlImg.isEmpty) {
                                  return const Icon(
                                    Icons.person,
                                    size: 150,
                                  );
                                }
                                return Image.network(
                                  engineer.picture,
                                  loadingBuilder: (_, child, progress) {
                                    if (progress == null) return child;
                                    return Container(
                                      color: AppColor.primaryColorDark,
                                    );
                                  },
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                );
                              }),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColor.secondColor,
                                    borderRadius: BorderRadius.circular(24)),
                                child: IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    _imagePicker
                                        .pickImage(source: ImageSource.gallery)
                                        .then((value) {
                                      if (value != null) {
                                        usersImagesTest[
                                            snapshot.data!.first.id] = value;
                                        viewModel.imageUser = value;
                                      }
                                    });
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        engineer.nickname,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                        Format.formatDate(engineer.birthday),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(height: 16),
                      Text(engineer.address),
                      Text(Format.formatPhone(engineer.phone)),
                      const SizedBox(height: 32),
                      Observer(
                        builder: (_) {
                          return ContentList(
                            disableClick: canEditOrAdd,
                            length: viewModel.skills.length,
                            itemBuilder: (_, index) =>
                                SkillsItem(skills: viewModel.skills[index]),
                            title: 'Habilidades',
                            canEdit: true,
                            onInsert: () async {
                              final Pair<Levels, String>? skill =
                                  await showModalBottomSheet(
                                      context: context,
                                      builder: (_) => SkillsModal(),
                                      isScrollControlled: true);
                              if (skill != null) {
                                final loading = LoadingControl();
                                showDialog(
                                    context: context,
                                    builder: (_) => loading.create(),
                                    barrierDismissible: false);
                                await viewModel.insertSkill(
                                    Skills(skill.second, skill.first.name));
                                loading.close();
                              }
                            },
                            onChange: (index) async {
                              final skill = viewModel.skills[index];
                              final Pair<Levels, String>? update =
                                  await showModalBottomSheet(
                                      context: context,
                                      builder: (_) =>
                                          SkillsModal(update: skill),
                                      isScrollControlled: true);
                              if (update != null) {
                                skill.description = update.second;
                                skill.level = update.first.name;

                                final loading = LoadingControl();
                                showDialog(
                                    context: context,
                                    builder: (_) => loading.create(),
                                    barrierDismissible: false);
                                await viewModel.updateSkill(
                                    index, viewModel.skills[index]);
                                loading.close();
                              }
                            },
                            onDelete: (index) async {
                              final loading = LoadingControl();
                              showDialog(
                                  context: context,
                                  builder: (_) => loading.create(),
                                  barrierDismissible: false);
                              await viewModel
                                  .removeSkill(viewModel.skills[index]);
                              loading.close();
                            },
                          );
                        },
                      ),
                      Observer(
                        builder: (_) {
                          return ContentList(
                            disableClick: canEditOrAdd,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            length: viewModel.experiences.length,
                            itemBuilder: (_, index) => ExperienceItem(
                                experience: viewModel.experiences[index]),
                            title: 'Experiências',
                            canEdit: true,
                            onInsert: () async {
                              final Experience? experience =
                                  await showModalBottomSheet(
                                      context: context,
                                      builder: (_) => const ExperienceModal(),
                                      isScrollControlled: true);
                              if (experience != null) {
                                final loading = LoadingControl();
                                showDialog(
                                    context: context,
                                    builder: (_) => loading.create(),
                                    barrierDismissible: false);
                                await viewModel.insertExperiences(experience);
                                loading.close();
                              }
                            },
                            onChange: (index) async {
                              final experience = viewModel.experiences[index];
                              final Experience? update =
                                  await showModalBottomSheet(
                                      context: context,
                                      builder: (_) =>
                                          ExperienceModal(update: experience),
                                      isScrollControlled: true);
                              if (update != null) {
                                experience.copy(update);
                                final loading = LoadingControl();
                                showDialog(
                                    context: context,
                                    builder: (_) => loading.create(),
                                    barrierDismissible: false);
                                await viewModel.updateExperiences(
                                    index, experience);
                                loading.close();
                              }
                            },
                            onDelete: (index) async {
                              final loading = LoadingControl();
                              showDialog(
                                  context: context,
                                  builder: (_) => loading.create(),
                                  barrierDismissible: false);
                              await viewModel.removeExperiences(
                                  viewModel.experiences[index]);
                              loading.close();
                            },
                          );
                        },
                      ),
                      Observer(
                        builder: (_) {
                          return ContentList(
                            disableClick: canEditOrAdd,
                            length: viewModel.formations.length,
                            itemBuilder: (_, index) => FormationItem(
                                formation: viewModel.formations[index]),
                            title: 'Formações',
                            canEdit: true,
                            onInsert: () async {
                              final Formation? formations =
                                  await showModalBottomSheet(
                                      context: context,
                                      builder: (_) => const FormationModal(),
                                      isScrollControlled: true);
                              if (formations != null) {
                                final loading = LoadingControl();
                                showDialog(
                                    context: context,
                                    builder: (_) => loading.create(),
                                    barrierDismissible: false);
                                await viewModel.insertFormations(formations);
                                loading.close();
                              }
                            },
                            onChange: (index) async {
                              final formations = viewModel.formations[index];
                              final Formation? update =
                                  await showModalBottomSheet(
                                      context: context,
                                      builder: (_) =>
                                          FormationModal(update: formations),
                                      isScrollControlled: true);
                              if (update != null) {
                                formations.copy(update);
                                final loading = LoadingControl();
                                showDialog(
                                    context: context,
                                    builder: (_) => loading.create(),
                                    barrierDismissible: false);
                                await viewModel.updateFormations(
                                    index, formations);
                                loading.close();
                              }
                            },
                            onDelete: (index) async {
                              final loading = LoadingControl();
                              showDialog(
                                  context: context,
                                  builder: (_) => loading.create(),
                                  barrierDismissible: false);
                              await viewModel.removeFormations(
                                  viewModel.formations[index]);
                              loading.close();
                            },
                          );
                        },
                      ),
                      Observer(
                        builder: (_) {
                          return ContentList(
                            disableClick: canEditOrAdd,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            length: viewModel.projects.length,
                            itemBuilder: (_, index) =>
                                ProjectItem(project: viewModel.projects[index]),
                            title: 'Projetos',
                            canEdit: true,
                            onInsert: () async {
                              final Project? project =
                                  await showModalBottomSheet(
                                      context: context,
                                      builder: (_) => const ProjectModal(),
                                      isScrollControlled: true);
                              if (project != null) {
                                final loading = LoadingControl();
                                showDialog(
                                    context: context,
                                    builder: (_) => loading.create(),
                                    barrierDismissible: false);
                                await viewModel.insertProjects(project);

                                loading.close();
                              }
                            },
                            onChange: (index) async {
                              final project = viewModel.projects[index];
                              final Project? update =
                                  await showModalBottomSheet(
                                      context: context,
                                      builder: (_) =>
                                          ProjectModal(update: project),
                                      isScrollControlled: true);
                              if (update != null) {
                                project.copy(update);
                                final loading = LoadingControl();
                                showDialog(
                                    context: context,
                                    builder: (_) => loading.create(),
                                    barrierDismissible: false);
                                await viewModel.updateProjects(index, project);
                                loading.close();
                              }
                            },
                            onDelete: (index) async {
                              final loading = LoadingControl();
                              showDialog(
                                  context: context,
                                  builder: (_) => loading.create(),
                                  barrierDismissible: false);
                              await viewModel
                                  .removeProjects(viewModel.projects[index]);
                              loading.close();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        final bool? updated = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const EditProfilePage()));
                        if (updated == true) setState(() {});
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
