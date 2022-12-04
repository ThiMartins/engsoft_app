import 'dart:io';

import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/engineer.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/user/user.dart';
import 'package:comunidade_de_engenheiros_de_software/api/service/provider_test.dart';
import 'package:comunidade_de_engenheiros_de_software/base/view/content_list.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/profile/adapter/experience_item.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/profile/adapter/formation_item.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/profile/adapter/project_item.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/profile/adapter/skills_item.dart';
import 'package:comunidade_de_engenheiros_de_software/util/api_util.dart';
import 'package:comunidade_de_engenheiros_de_software/util/app_color.dart';
import 'package:comunidade_de_engenheiros_de_software/util/base/constants.dart';
import 'package:comunidade_de_engenheiros_de_software/util/global/format.dart';
import 'package:comunidade_de_engenheiros_de_software/util/view/app_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EngineerPage extends StatelessWidget {
  final Engineer engineer;

  const EngineerPage({Key? key, required this.engineer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
      ),
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(75),
                    child: Builder(builder: (_) {
                      final fileImg = usersImagesTest[engineer.id];
                      final urlImg = engineer.picture;

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
                ContentList(
                  length: engineer.skills.length,
                  itemBuilder: (_, index) =>
                      SkillsItem(skills: engineer.skills[index]),
                  title: 'Habilidades',
                ),
                ContentList(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  length: engineer.experiences.length,
                  itemBuilder: (_, index) =>
                      ExperienceItem(experience: engineer.experiences[index]),
                  title: 'Experiências',
                ),
                ContentList(
                  length: engineer.formations.length,
                  itemBuilder: (_, index) =>
                      FormationItem(formation: engineer.formations[index]),
                  title: 'Formações',
                ),
                ContentList(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  length: engineer.projects.length,
                  itemBuilder: (_, index) =>
                      ProjectItem(project: engineer.projects[index]),
                  title: 'Projetos',
                ),
                FutureBuilder<bool>(
                  future: _isADM(),
                  builder: (_, snapshot) {
                    if (!snapshot.hasData) {
                      if (snapshot.data!) {
                        return AppButton(
                          radius: 10,
                          color: Colors.transparent,
                          colorText: AppColor.textColor,
                          onPressed: () {
                            Navigator.pop(context, engineer);
                          },
                          text: engineer.isApproved ? 'Desativar' : 'Ativar',
                        );
                      }
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _isADM() async {
    final preferences = await SharedPreferences.getInstance();
    try {
      final json = preferences.getString(appUser);
      if (json != null) {
        return toObject<User>(json).isADM;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return false;
  }
}
