import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_crud/core/logger/logger.dart';

@Singleton(as: Logger)
class MockLogger extends Mock implements Logger {}

