import 'package:json_annotation/json_annotation.dart';
import 'package:simple_crud/core/extensions/strings_extensions.dart';
import 'package:simple_crud/domain/entities/serializable/serializable.dart';
part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  final String uid;
  final String name;
  final String email;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const User({
    required this.uid,
    required this.name,
    required this.email,
    required this.createdAt,
    this.updatedAt,
  });

  factory User.simple({
    required String name,
    required String email,
  }) {
    return User(
      uid: StringUtils.uuid(),
      name: name,
      email: email,
      createdAt: DateTime.now(),
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
  Serializable serialize() => Serializable(toJson());
  factory User.deserialize(Serializable serial) => User.fromJson(serial.json);
}

@JsonSerializable(explicitToJson: true)
class UserCollection {
  final List<User> users;
  const UserCollection(this.users);

  factory UserCollection.fromJson(Map<String, dynamic> json) =>
      _$UserCollectionFromJson(json);
  Map<String, dynamic> toJson() => _$UserCollectionToJson(this);
  Serializable serialize() => Serializable(toJson());
}
