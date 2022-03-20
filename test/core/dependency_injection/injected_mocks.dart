import 'package:injectable/injectable.dart' hide Environment;
import 'package:mocktail/mocktail.dart';
import 'package:simple_crud/core/enviroment.dart';
import 'package:simple_crud/core/logger/logger.dart';

@Singleton(as: Logger)
class MockLogger extends Mock implements Logger {}

@Singleton(as: Environment)
class MockEnvironment extends Mock implements Environment {}
