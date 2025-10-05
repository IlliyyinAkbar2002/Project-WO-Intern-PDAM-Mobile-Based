import 'package:mobile_intern_pdam/core/resource/data_state.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<DataState<List<UserEntity>>> getUsers();
  Future<DataState<UserEntity>> getUserDetail(int id);
}
