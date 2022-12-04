import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/engineer.dart';
import 'package:comunidade_de_engenheiros_de_software/api/service/EngineerService.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

part 'manager_view_model.g.dart';

class ManagerViewModel = ManagerViewModelBase with _$ManagerViewModel;

abstract class ManagerViewModelBase with Store {
  final EngineerService service;

  @observable
  bool filterEnable = false;

  @observable
  bool filterDisable = false;

  @observable
  bool filterApproved = false;

  @observable
  bool filterNotApproved = false;

  ManagerViewModelBase({required this.service});

  Future<List<Engineer>> getEngineers(int page) async {
    final item = await service.list(filterEnable, filterDisable, filterApproved, filterNotApproved, page).catchError((e) {});
    return item;
  }

  Future<bool?> updateState(Engineer engineer) async {
    try {
      return await service.updateState(engineer);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future<bool?> updateApproved(Engineer engineer) async {
    try {
      return await service.updateApproved(engineer);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

}
