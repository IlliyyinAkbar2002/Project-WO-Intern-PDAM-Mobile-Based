import 'package:mobile_intern_pdam/core/resource/data_state.dart';
import 'package:mobile_intern_pdam/core/usecase/usecase.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/entities/user_entity.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/repositories/user_repository.dart';

class GetUserDetailUsecase
    implements UseCase<Future<DataState<UserEntity>>, int> {
  final UserRepository repository;

  GetUserDetailUsecase(this.repository);

  @override
  Future<DataState<UserEntity>> call(int id) {
    return repository.getUserDetail(id);
  }
}
