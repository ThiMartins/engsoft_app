import 'dart:async';

import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/engineer.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/user/user.dart';
import 'package:comunidade_de_engenheiros_de_software/api/service/EngineerService.dart';
import 'package:comunidade_de_engenheiros_de_software/util/api_util.dart';
import 'package:comunidade_de_engenheiros_de_software/util/base/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'main_view_model.g.dart';

typedef SearchListener = void Function(List<Engineer>);

class MainViewModel = MainViewModelBase with _$MainViewModel;

abstract class MainViewModelBase with Store {
  final EngineerService service;
  SearchListener? _listener;
  Timer? _delay;

  VoidCallback? _callback;

  @observable
  bool showSearch = false;

  MainViewModelBase({required this.service});

  Future<bool> isADM() async {
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

  Future<List<Engineer>> getEngineers(int page) async {
    final item = await service.listAll(page);
    item.removeWhere((item) => item.isApproved == false);
    return item;
  }

  Future<List<Engineer>> _getEngineers(int page, String text) async {
    final item = await service.search(page, text);
    return item;
  }

  void addListener(SearchListener listener) {
    _listener = listener;
  }

  void addLoadingListener(VoidCallback callback) {
    _callback = callback;
  }

  void search(String text) {
    _delay?.cancel();
    _delay = Timer(const Duration(seconds: 3), () async {
      _callback?.call();
      try {
        _getEngineers(0, text).then((value) {
          _listener?.call(value);
          _callback?.call();
        });
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        _callback?.call();
      }
    });
  }

  Future logout() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
