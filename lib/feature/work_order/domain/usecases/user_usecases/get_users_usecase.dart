import 'package:mobile_intern_pdam/core/resource/data_state.dart';
import 'package:mobile_intern_pdam/core/usecase/usecase.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/entities/user_entity.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/repositories/user_repository.dart';

class GetUsersUsecase
    implements UseCase<Future<DataState<List<UserEntity>>>, NoParams> {
  final UserRepository repository;

  GetUsersUsecase(this.repository);

  @override
  Future<DataState<List<UserEntity>>> call(NoParams params) {
    return repository.getUsers();
  }
}
