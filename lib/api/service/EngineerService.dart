import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/engineer.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/user/user.dart';
import 'package:comunidade_de_engenheiros_de_software/api/service/provider_test.dart';
import 'package:comunidade_de_engenheiros_de_software/util/global/pair.dart';
import 'package:injectable/injectable.dart';

abstract class EngineerService {
  Future<List<Engineer>> list(
      bool enabled, bool disable, bool approved, bool notApproved, int offset);

  Future<List<Engineer>> listAll(int offset);

  Future<List<Engineer>> search(int offset, String query);

  Future<bool> updateState(Engineer engineer);

  Future<bool> updateApproved(Engineer engineer);
}

@Injectable(as: EngineerService)
class EngineerServiceDev extends EngineerService {
  @override
  Future<List<Engineer>> list(bool enabled, bool disable, bool approved,
      bool notApproved, int offset) async {
    await Future.delayed(const Duration(seconds: 2));

    if (offset > 0) return [];

    List<Engineer> engineers = [];
    for (Pair<User, Engineer> engineer in usersTest) {
      if (enabled && engineer.first.isEnable) {
        engineers.add(engineer.second);
        continue;
      }

      if (disable && !engineer.first.isEnable) {
        engineers.add(engineer.second);
        continue;
      }

      if (approved && engineer.second.isApproved) {
        engineers.add(engineer.second);
        continue;
      }

      if (notApproved && !engineer.second.isApproved) {
        engineers.add(engineer.second);
        continue;
      }

      if (!enabled && !disable && !approved && !notApproved)
        engineers.add(engineer.second);
    }

    return engineers;
  }

  @override
  Future<List<Engineer>> search(int offset, String query) async {
    await Future.delayed(const Duration(seconds: 2));
    if (offset > 0) return [];

    List<Engineer> engineers = [];
    for (Pair<User, Engineer> engineer in usersTest) {
      if (engineer.second.nickname.toLowerCase().contains(query.toLowerCase()))
        engineers.add(engineer.second);
    }

    return engineers;
  }

  @override
  Future<List<Engineer>> listAll(int offset) async {
    await Future.delayed(const Duration(seconds: 2));
    if (offset == 0) return usersTest.map((e) => e.second).toList();
    return [];
  }

  @override
  Future<bool> updateState(Engineer engineer) async {
    await Future.delayed(const Duration(seconds: 2));

    for (int index = 0; index < usersTest.length; index++) {
      if (usersTest[index].second.id == engineer.id)
        usersTest[index].first.isEnable = !engineer.isApproved;
    }

    return !engineer.isApproved;
  }

  @override
  Future<bool> updateApproved(Engineer engineer) async {
    await Future.delayed(const Duration(seconds: 2));

    for (int index = 0; index < usersTest.length; index++) {
      if (usersTest[index].second.id == engineer.id)
        usersTest[index].second.isApproved = !engineer.isApproved;
    }

    return !engineer.isApproved;
  }
}
