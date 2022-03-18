import 'package:injectable/injectable.dart';
import 'package:simple_crud/domain/entities/serializable/serializable.dart';
import 'package:simple_crud/domain/repositories/user_repository.dart';

@injectable
class SaveUserUseCase {
  const SaveUserUseCase({
    required UserRepository repository,
  }) : _repository = repository;
  final UserRepository _repository;

  Future<Serializable> call(String name, String email) {
    return _repository.saveUser(name, email);
  }
}
