import 'package:dio/dio.dart';
import 'package:mobile_intern_pdam/core/resource/data_state.dart';
import 'package:mobile_intern_pdam/core/resource/remote_data_source.dart';
import 'package:mobile_intern_pdam/feature/work_order/data/models/user_model.dart';

class UserRemoteDataSource extends RemoteDatasource {
  UserRemoteDataSource() : super();

  Future<DataState<List<UserModel>>> fetchUsers() async {
    try {
      // Use parent class's get() method which includes auth headers
      final response = await get(path: '/user');
      final data = response.data
          .map<UserModel>((json) => UserModel.fromMap(json))
          .toList();
      return DataSuccess(data);
    } catch (e) {
      return DataFailed(
        DioException(
          error: e,
          requestOptions: RequestOptions(path: '/user'),
        ),
      );
    }
  }

  Future<DataState<UserModel>> fetchUserDetail(int id) async {
    try {
      // Use parent class's get() method which includes auth headers
      final response = await get(path: '/user/$id');
      final data = UserModel.fromMap(response.data);
      return DataSuccess(data);
    } catch (e) {
      return DataFailed(
        DioException(
          error: e,
          requestOptions: RequestOptions(path: '/user/$id'),
        ),
      );
    }
  }
}
