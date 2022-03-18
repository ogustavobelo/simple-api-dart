import 'package:json_annotation/json_annotation.dart';
import 'package:simple_crud/core/extensions/strings_extensions.dart';
import 'package:simple_crud/domain/entities/user/user.dart';
part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel extends User {
  const UserModel({
    required String uid,
    required String name,
    required String email,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) : super(
          uid: uid,
          name: name,
          email: email,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory UserModel.simple({
    required String name,
    required String email,
  }) {
    return UserModel(
      uid: StringUtils.uuid(),
      name: name,
      email: email,
      createdAt: DateTime.now(),
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserCollection {
  final List<UserModel> users;
  const UserCollection(this.users);

  factory UserCollection.fromJson(Map<String, dynamic> json) =>
      _$UserCollectionFromJson(json);
  Map<String, dynamic> toJson() => _$UserCollectionToJson(this);
}
