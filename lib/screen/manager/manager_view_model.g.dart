// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manager_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ManagerViewModel on ManagerViewModelBase, Store {
  late final _$filterEnableAtom =
      Atom(name: 'ManagerViewModelBase.filterEnable', context: context);

  @override
  bool get filterEnable {
    _$filterEnableAtom.reportRead();
    return super.filterEnable;
  }

  @override
  set filterEnable(bool value) {
    _$filterEnableAtom.reportWrite(value, super.filterEnable, () {
      super.filterEnable = value;
    });
  }

  late final _$filterDisableAtom =
      Atom(name: 'ManagerViewModelBase.filterDisable', context: context);

  @override
  bool get filterDisable {
    _$filterDisableAtom.reportRead();
    return super.filterDisable;
  }

  @override
  set filterDisable(bool value) {
    _$filterDisableAtom.reportWrite(value, super.filterDisable, () {
      super.filterDisable = value;
    });
  }

  late final _$filterApprovedAtom =
      Atom(name: 'ManagerViewModelBase.filterApproved', context: context);

  @override
  bool get filterApproved {
    _$filterApprovedAtom.reportRead();
    return super.filterApproved;
  }

  @override
  set filterApproved(bool value) {
    _$filterApprovedAtom.reportWrite(value, super.filterApproved, () {
      super.filterApproved = value;
    });
  }

  late final _$filterNotApprovedAtom =
      Atom(name: 'ManagerViewModelBase.filterNotApproved', context: context);

  @override
  bool get filterNotApproved {
    _$filterNotApprovedAtom.reportRead();
    return super.filterNotApproved;
  }

  @override
  set filterNotApproved(bool value) {
    _$filterNotApprovedAtom.reportWrite(value, super.filterNotApproved, () {
      super.filterNotApproved = value;
    });
  }

  @override
  String toString() {
    return '''
filterEnable: ${filterEnable},
filterDisable: ${filterDisable},
filterApproved: ${filterApproved},
filterNotApproved: ${filterNotApproved}
    ''';
  }
}
