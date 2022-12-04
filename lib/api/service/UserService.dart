import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/engineer.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/experience.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/formation.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/project.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/skills.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/user/user.dart';
import 'package:comunidade_de_engenheiros_de_software/api/service/provider_test.dart';
import 'package:comunidade_de_engenheiros_de_software/util/api_util.dart';
import 'package:comunidade_de_engenheiros_de_software/util/base/constants.dart';
import 'package:comunidade_de_engenheiros_de_software/util/global/pair.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserService {
  Future<Engineer> getEngineer();

  Future<bool> updateUser(User user, Engineer engineer);

  Future<Skills> insertSkill(Skills skills);

  Future<bool> updateGeneric();

  Future<bool> removeSkill(Skills skills);

  Future<Experience> insertExperiences(Experience experience);

  Future<bool> removeExperiences(Experience experience);

  Future<Formation> insertFormations(Formation formation);

  Future<bool> removeFormations(Formation formation);

  Future<Project> insertProjects(Project project);

  Future<bool> removeProjects(Project project);
}

@Injectable(as: UserService)
class UserServiceDev extends UserService {
  @override
  Future<Engineer> getEngineer() async {
    await Future.delayed(const Duration(seconds: 5));
    final data = await _getUser();

    return data.second;
  }

  @override
  Future<Skills> insertSkill(Skills skills) async {
    await Future.delayed(const Duration(seconds: 5));
    final data = await _getUser();
    data.second.skills.add(skills);

    return skills;
  }

  @override
  Future<bool> updateGeneric() async {
    await Future.delayed(const Duration(seconds: 5));
    final data = await _getUser();
    return true;
  }

  @override
  Future<bool> removeSkill(Skills skills) async {
    await Future.delayed(const Duration(seconds: 5));
    final data = await _getUser();
    data.second.skills.removeWhere((element) => element.id == skills.id);

    return true;
  }

  @override
  Future<Experience> insertExperiences(Experience experience) async {
    await Future.delayed(const Duration(seconds: 5));
    final data = await _getUser();
    data.second.experiences.add(experience);

    return experience;
  }

  @override
  Future<bool> removeExperiences(Experience experience) async {
    await Future.delayed(const Duration(seconds: 5));
    final data = await _getUser();
    data.second.experiences
        .removeWhere((element) => element.id == experience.id);

    return true;
  }

  @override
  Future<Formation> insertFormations(Formation formation) async {
    await Future.delayed(const Duration(seconds: 5));
    final data = await _getUser();
    data.second.formations.add(formation);

    return formation;
  }

  @override
  Future<bool> removeFormations(Formation formation) async {
    await Future.delayed(const Duration(seconds: 5));
    final data = await _getUser();
    data.second.formations.removeWhere((element) => element.id == formation.id);

    return true;
  }

  @override
  Future<Project> insertProjects(Project project) async {
    await Future.delayed(const Duration(seconds: 5));
    final data = await _getUser();
    data.second.projects.add(project);

    return project;
  }

  @override
  Future<bool> removeProjects(Project project) async {
    await Future.delayed(const Duration(seconds: 5));
    final data = await _getUser();
    data.second.projects.removeWhere((element) => element.id == project.id);

    return true;
  }

  Future<Pair<User, Engineer>> _getUser() async {
    final preferences = await SharedPreferences.getInstance();
    final userCpf = toObject<User>(preferences.getString(appUser) ?? "{}").cpf;

    return usersTest.firstWhere((element) => element.first.cpf == userCpf);
  }

  @override
  Future<bool> updateUser(User user, Engineer engineer) async {
    await Future.delayed(const Duration(seconds: 2));

    final preferences = await SharedPreferences.getInstance();
    preferences.setString(appUser, user.toString());

    for (int index = 0; index < usersTest.length; index++) {
      if (usersTest[index].first.cpf == user.cpf)
        usersTest[index] = Pair(first: user, second: engineer);
    }

    return true;
  }
}
