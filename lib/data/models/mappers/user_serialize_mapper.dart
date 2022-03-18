import 'package:simple_crud/data/models/user/user_model.dart';
import 'package:simple_crud/domain/entities/serializable/serializable.dart';

extension UserSerialize on UserModel {
  Serializable serialize() => Serializable(toJson());
  UserModel deserialize(Serializable serial) => UserModel.fromJson(serial.json);
}

extension UserCollectionSerialize on UserCollection {
  Serializable serialize() => Serializable(toJson());
}
