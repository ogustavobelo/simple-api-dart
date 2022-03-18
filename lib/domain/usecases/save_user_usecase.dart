import 'package:injectable/injectable.dart';
import 'package:simple_crud/domain/models/user/user_model.dart';
import 'package:simple_crud/domain/repositories/user_repository.dart';

@injectable
class SaveUserUseCase {
  const SaveUserUseCase({
    required UserRepository repository,
  }) : _repository = repository;
  final UserRepository _repository;

  Future<void> call(User user) {
    return _repository.saveUser(user);
  }
}
