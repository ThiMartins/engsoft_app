import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'constants.config.dart';

const String tokenUser = "tokenUser";
const String appUser = "appUser";

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
void configureDependencies() => $initGetIt(getIt);