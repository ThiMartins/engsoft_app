import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/experience.dart';
import 'package:comunidade_de_engenheiros_de_software/api/service/ExperienceService.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'base_view_model.g.dart';

class BaseStateViewModel = BaseStateBase with _$BaseStateViewModel;

abstract class BaseStateBase with Store {
  @observable
  bool hasDateFinish = false;
}
