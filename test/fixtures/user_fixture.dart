import 'package:simple_crud/data/models/user/user_model.dart';

class UserFixture {
  static Map<String, dynamic> json = {
    "uid": "uid",
    "name": "name",
    "email": "email",
    "createdAt": "2022-03-17T01:57:27.846813",
    "updatedAt": "2022-03-18T02:57:27.846813",
  };

  static UserModel model = UserModel(
    uid: "uid",
    name: "name",
    email: "email",
    createdAt: DateTime(2022, 01, 01),
    updatedAt: DateTime(2022, 01, 02),
  );
}

class UserCollectionFixture {
  static Map<String, dynamic> json = {
    "users": [UserFixture.json],
  };

  static UserCollection model = UserCollection([UserFixture.model]);
}
