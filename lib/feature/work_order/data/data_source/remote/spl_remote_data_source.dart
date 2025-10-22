import 'package:dio/dio.dart';
import 'package:mobile_intern_pdam/core/resource/data_state.dart';
import 'package:mobile_intern_pdam/core/resource/remote_data_source.dart';
import 'package:mobile_intern_pdam/feature/work_order/data/models/spl_model.dart';

class SplRemoteDataSource extends RemoteDatasource {
  SplRemoteDataSource() : super();

  Future<DataState<List<SplModel>>> fetchSpls() async {
    try {
      // Use parent class's get() method which includes auth headers
      final response = await get(path: '/lembur-spl');
      final data = response.data['data']
          .map<SplModel>((json) => SplModel.fromMap(json))
          .toList();
      return DataSuccess(data);
    } catch (e) {
      return DataFailed(
        DioException(
          error: e,
          requestOptions: RequestOptions(path: '/lembur-spl'),
        ),
      );
    }
  }

  Future<DataState<SplModel>> fetchSplDetail(int id) async {
    try {
      // Use parent class's get() method which includes auth headers
      final response = await get(path: '/lembur-spl/$id');
      final data = SplModel.fromMap(response.data);
      return DataSuccess(data);
    } catch (e) {
      return DataFailed(
        DioException(
          error: e,
          requestOptions: RequestOptions(path: '/lembur-spl/$id'),
        ),
      );
    }
  }

  Future<DataState<SplModel>> updateSpl(SplModel spl) async {
    try {
      // Use parent class's put() method which includes auth headers
      final response = await put(
        path: '/lembur-spl/${spl.id}',
        data: spl.toMap(),
      );
      final data = SplModel.fromMap(response.data);
      return DataSuccess(data);
    } catch (e) {
      return DataFailed(
        DioException(
          error: e,
          requestOptions: RequestOptions(path: '/lembur-spl/${spl.id}'),
        ),
      );
    }
  }
}
