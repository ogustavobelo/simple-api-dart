import 'package:injectable/injectable.dart';
import 'package:simple_crud/core/extensions/strings_extensions.dart';
import 'package:simple_crud/data/models/user/user_model.dart';

abstract class UsersHelper {
  UserModel buildUser(String name, String email);
}

@Injectable(as: UsersHelper)
class UsersHelperImpl implements UsersHelper {
  @override
  UserModel buildUser(String name, String email) {
    return UserModel(
      uid: StringUtils.uuid(),
      name: name,
      email: email,
      createdAt: DateTime.now(),
    );
  }
}
