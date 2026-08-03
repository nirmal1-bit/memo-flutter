import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/session/shared_prefrences_init.dart';
import 'injector.config.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> configureInjection() async {
  // await $initGetIt(getIt, environment: Environment.prod);
  getIt.init();
  await getIt<SharedPreferencesInit>().initialize();
}
