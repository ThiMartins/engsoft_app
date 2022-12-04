// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../api/service/AuthService.dart' as _i3;
import '../../api/service/EngineerService.dart' as _i4;
import '../../api/service/ExperienceService.dart' as _i5;
import '../../api/service/UserService.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.AuthService>(() => _i3.AuthServiceDev());
  gh.factory<_i4.EngineerService>(() => _i4.EngineerServiceDev());
  gh.factory<_i5.ExperienceService>(() => _i5.ExperienceServiceDev());
  gh.factory<_i6.UserService>(() => _i6.UserServiceDev());
  return get;
}
