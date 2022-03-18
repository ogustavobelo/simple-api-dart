import 'package:injectable/injectable.dart';
import 'package:simple_crud/domain/entities/serializable/serializable.dart';
import 'package:simple_crud/domain/repositories/user_repository.dart';

@injectable
class ListUserUseCase {
  const ListUserUseCase({
    required UserRepository repository,
  }) : _repository = repository;
  final UserRepository _repository;

  Future<Serializable> call() {
    return _repository.listAllUsers();
  }
}
