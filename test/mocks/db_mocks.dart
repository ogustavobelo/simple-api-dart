import 'package:mocktail/mocktail.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MockDb extends Mock implements Db {}

class MockDbCollection extends Mock implements DbCollection {}
