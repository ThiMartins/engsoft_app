// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BaseStateViewModel on BaseStateBase, Store {
  late final _$hasDateFinishAtom =
      Atom(name: 'BaseStateBase.hasDateFinish', context: context);

  @override
  bool get hasDateFinish {
    _$hasDateFinishAtom.reportRead();
    return super.hasDateFinish;
  }

  @override
  set hasDateFinish(bool value) {
    _$hasDateFinishAtom.reportWrite(value, super.hasDateFinish, () {
      super.hasDateFinish = value;
    });
  }

  @override
  String toString() {
    return '''
hasDateFinish: ${hasDateFinish}
    ''';
  }
}
