import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/engineer.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/experience.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/formation.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/project.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/skills.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/user/user.dart';
import 'package:comunidade_de_engenheiros_de_software/api/service/UserService.dart';
import 'package:comunidade_de_engenheiros_de_software/util/api_util.dart';
import 'package:comunidade_de_engenheiros_de_software/util/base/constants.dart';
import 'package:comunidade_de_engenheiros_de_software/util/global/pair.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_view_model.g.dart';

class ProfileViewModel = ProfileViewModelBase with _$ProfileViewModel;

abstract class ProfileViewModelBase with Store {
  final UserService service;

  @observable
  ObservableList<Skills> skills = ObservableList();

  @observable
  ObservableList<Experience> experiences = ObservableList();

  @observable
  ObservableList<Formation> formations = ObservableList();

  @observable
  ObservableList<Project> projects = ObservableList();

  @observable
  XFile? imageUser;

  ProfileViewModelBase({required this.service});

  Future<Pair<Engineer, User>> getEngineer() async {
    final engineer = await service.getEngineer();
    final user = await getUser();
    return Pair(first: engineer, second: user);
  }

  Future<User> getUser() async {
    final preferences = await SharedPreferences.getInstance();
    return toObject<User>(preferences.getString(appUser) ?? "{}");
  }

  Future insertSkill(Skills skills) async {
    try {
      final skill = await service.insertSkill(skills);
      _insertSkill(skill);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future removeSkill(Skills skills) async {
    try {
      final canRemove = await service.removeSkill(skills);
      if (canRemove) _removeSkill(skills);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future updateSkill(int index, Skills skill) async {
    try {
      await service.updateGeneric();
      _updateSkill(index, skill);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future insertExperiences(Experience experience) async {
    try {
      final xp = await service.insertExperiences(experience);
      _insertExperiences(xp);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future removeExperiences(Experience experience) async {
    try {
      final canRemove = await service.removeExperiences(experience);
      if (canRemove) _removeExperiences(experience);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future updateExperiences(int index, Experience experience) async {
    try {
      await service.updateGeneric();
      _updateExperiences(index, experience);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future insertFormations(Formation formation) async {
    try {
      final xp = await service.insertFormations(formation);
      _insertFormations(xp);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future removeFormations(Formation formation) async {
    try {
      final canRemove = await service.removeFormations(formation);
      if (canRemove) _removeFormations(formation);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future updateFormations(int index, Formation formation) async {
    try {
      await service.updateGeneric();
      _updateFormations(index, formation);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future insertProjects(Project project) async {
    try {
      final projects = await service.insertProjects(project);
      _insertProjects(projects);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future removeProjects(Project project) async {
    try {
      final canRemove = await service.removeProjects(project);
      if (canRemove) _removeProjects(project);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future updateProjects(int index, Project project) async {
    try {
      await service.updateGeneric();
      _updateProjects(index, project);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<bool> updateUser(User user, Engineer engineer) async {
    try {
      return await service.updateUser(user, engineer);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return false;
  }

  @action
  void _insertSkill(Skills skill) {
    skills.add(skill);
  }

  @action
  void _removeSkill(Skills skill) {
    skills.remove(skill);
  }

  @action
  void _updateSkill(int index, Skills skill) {
    skills.removeAt(index);
    skills.insert(index, skill);
  }

  @action
  void _insertExperiences(Experience experience) {
    experiences.add(experience);
  }

  @action
  void _removeExperiences(Experience experience) {
    experiences.remove(experience);
  }

  @action
  void _updateExperiences(int index, Experience experience) {
    experiences.removeAt(index);
    experiences.insert(index, experience);
  }

  @action
  void _insertFormations(Formation formation) {
    formations.add(formation);
  }

  @action
  void _removeFormations(Formation formation) {
    formations.remove(formation);
  }

  @action
  void _updateFormations(int index, Formation formation) {
    formations.removeAt(index);
    formations.insert(index, formation);
  }

  @action
  void _insertProjects(Project project) {
    projects.add(project);
  }

  @action
  void _removeProjects(Project project) {
    projects.remove(project);
  }

  @action
  void _updateProjects(int index, Project project) {
    projects.removeAt(index);
    projects.insert(index, project);
  }

  void setEngineer(Engineer engineer) {
    skills.clear();
    projects.clear();
    formations.clear();
    experiences.clear();

    skills.addAll(engineer.skills);
    projects.addAll(engineer.projects);
    formations.addAll(engineer.formations);
    experiences.addAll(engineer.experiences);
  }
}
