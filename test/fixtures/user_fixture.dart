import 'package:simple_crud/data/models/user/user_model.dart';

class UserFixture {
  static Map<String, dynamic> json = {
    "uid": "uid",
    "name": "name",
    "email": "email",
    "createdAt": "2022-03-17T01:57:27.846813",
    "updatedAt": "2022-03-18T02:57:27.846813",
  };

  static User model = User(
    uid: "uid",
    name: "name",
    email: "email",
    createdAt: DateTime(2022, 01, 01),
    updatedAt: DateTime(2022, 01, 02),
  );
}
