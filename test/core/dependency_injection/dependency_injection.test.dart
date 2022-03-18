import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'dependency_injection.test.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
    initializerName: r'$initGetItTest',
    preferRelativeImports: true,
    asExtension: false,
    generateForDir: ["test"])

void dependenciesTestSetup() {
  $initGetItTest(getIt, environment: Environment.test);
}
