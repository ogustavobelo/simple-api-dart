import 'package:injectable/injectable.dart';
import 'package:simple_crud/data/models/user/user_model.dart';
import 'package:simple_crud/domain/repositories/user_repository.dart';

@injectable
class ListUserUseCase {
  const ListUserUseCase({
    required UserRepository repository,
  }) : _repository = repository;
  final UserRepository _repository;

  Future<UserCollection> call() {
    return _repository.listAllUsers();
  }
}
