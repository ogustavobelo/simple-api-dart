import 'package:simple_crud/domain/entities/serializable/serializable.dart';
import 'package:simple_crud/data/models/mappers/user_serialize_mapper.dart';
import 'user_fixture.dart';

class SerializedUserFixture {
  static Serializable user = UserFixture.model.serialize();
  static Serializable userCollection = UserCollectionFixture.model.serialize();
}