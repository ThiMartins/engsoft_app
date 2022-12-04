// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileViewModel on ProfileViewModelBase, Store {
  late final _$skillsAtom =
      Atom(name: 'ProfileViewModelBase.skills', context: context);

  @override
  ObservableList<Skills> get skills {
    _$skillsAtom.reportRead();
    return super.skills;
  }

  @override
  set skills(ObservableList<Skills> value) {
    _$skillsAtom.reportWrite(value, super.skills, () {
      super.skills = value;
    });
  }

  late final _$experiencesAtom =
      Atom(name: 'ProfileViewModelBase.experiences', context: context);

  @override
  ObservableList<Experience> get experiences {
    _$experiencesAtom.reportRead();
    return super.experiences;
  }

  @override
  set experiences(ObservableList<Experience> value) {
    _$experiencesAtom.reportWrite(value, super.experiences, () {
      super.experiences = value;
    });
  }

  late final _$formationsAtom =
      Atom(name: 'ProfileViewModelBase.formations', context: context);

  @override
  ObservableList<Formation> get formations {
    _$formationsAtom.reportRead();
    return super.formations;
  }

  @override
  set formations(ObservableList<Formation> value) {
    _$formationsAtom.reportWrite(value, super.formations, () {
      super.formations = value;
    });
  }

  late final _$projectsAtom =
      Atom(name: 'ProfileViewModelBase.projects', context: context);

  @override
  ObservableList<Project> get projects {
    _$projectsAtom.reportRead();
    return super.projects;
  }

  @override
  set projects(ObservableList<Project> value) {
    _$projectsAtom.reportWrite(value, super.projects, () {
      super.projects = value;
    });
  }

  late final _$imageUserAtom =
      Atom(name: 'ProfileViewModelBase.imageUser', context: context);

  @override
  XFile? get imageUser {
    _$imageUserAtom.reportRead();
    return super.imageUser;
  }

  @override
  set imageUser(XFile? value) {
    _$imageUserAtom.reportWrite(value, super.imageUser, () {
      super.imageUser = value;
    });
  }

  late final _$ProfileViewModelBaseActionController =
      ActionController(name: 'ProfileViewModelBase', context: context);

  @override
  void _insertSkill(Skills skill) {
    final _$actionInfo = _$ProfileViewModelBaseActionController.startAction(
        name: 'ProfileViewModelBase._insertSkill');
    try {
      return super._insertSkill(skill);
    } finally {
      _$ProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _removeSkill(Skills skill) {
    final _$actionInfo = _$ProfileViewModelBaseActionController.startAction(
        name: 'ProfileViewModelBase._removeSkill');
    try {
      return super._removeSkill(skill);
    } finally {
      _$ProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _updateSkill(int index, Skills skill) {
    final _$actionInfo = _$ProfileViewModelBaseActionController.startAction(
        name: 'ProfileViewModelBase._updateSkill');
    try {
      return super._updateSkill(index, skill);
    } finally {
      _$ProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _insertExperiences(Experience experience) {
    final _$actionInfo = _$ProfileViewModelBaseActionController.startAction(
        name: 'ProfileViewModelBase._insertExperiences');
    try {
      return super._insertExperiences(experience);
    } finally {
      _$ProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _removeExperiences(Experience experience) {
    final _$actionInfo = _$ProfileViewModelBaseActionController.startAction(
        name: 'ProfileViewModelBase._removeExperiences');
    try {
      return super._removeExperiences(experience);
    } finally {
      _$ProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _updateExperiences(int index, Experience experience) {
    final _$actionInfo = _$ProfileViewModelBaseActionController.startAction(
        name: 'ProfileViewModelBase._updateExperiences');
    try {
      return super._updateExperiences(index, experience);
    } finally {
      _$ProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _insertFormations(Formation formation) {
    final _$actionInfo = _$ProfileViewModelBaseActionController.startAction(
        name: 'ProfileViewModelBase._insertFormations');
    try {
      return super._insertFormations(formation);
    } finally {
      _$ProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _removeFormations(Formation formation) {
    final _$actionInfo = _$ProfileViewModelBaseActionController.startAction(
        name: 'ProfileViewModelBase._removeFormations');
    try {
      return super._removeFormations(formation);
    } finally {
      _$ProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _updateFormations(int index, Formation formation) {
    final _$actionInfo = _$ProfileViewModelBaseActionController.startAction(
        name: 'ProfileViewModelBase._updateFormations');
    try {
      return super._updateFormations(index, formation);
    } finally {
      _$ProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _insertProjects(Project project) {
    final _$actionInfo = _$ProfileViewModelBaseActionController.startAction(
        name: 'ProfileViewModelBase._insertProjects');
    try {
      return super._insertProjects(project);
    } finally {
      _$ProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _removeProjects(Project project) {
    final _$actionInfo = _$ProfileViewModelBaseActionController.startAction(
        name: 'ProfileViewModelBase._removeProjects');
    try {
      return super._removeProjects(project);
    } finally {
      _$ProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _updateProjects(int index, Project project) {
    final _$actionInfo = _$ProfileViewModelBaseActionController.startAction(
        name: 'ProfileViewModelBase._updateProjects');
    try {
      return super._updateProjects(index, project);
    } finally {
      _$ProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
skills: ${skills},
experiences: ${experiences},
formations: ${formations},
projects: ${projects},
imageUser: ${imageUser}
    ''';
  }
}
