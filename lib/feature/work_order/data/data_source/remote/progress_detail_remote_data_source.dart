import 'package:dio/dio.dart';
import 'package:mobile_intern_pdam/core/resource/data_state.dart';
import 'package:mobile_intern_pdam/core/resource/remote_data_source.dart';
import 'package:mobile_intern_pdam/feature/work_order/data/models/progress_detail_model.dart';

class ProgressDetailRemoteDataSource extends RemoteDatasource {
  ProgressDetailRemoteDataSource() : super();

  Future<DataState<List<ProgressDetailModel>>> fetchProgressDetails(
    int workOrderProgressId,
  ) async {
    try {
      final response = await dio.get(
        '/detail-progress',
        queryParameters: {'progress_workorder_id': workOrderProgressId},
      );
      if (response.data is Map<String, dynamic>) {
        final progressDetailModel = ProgressDetailModel.fromMap(response.data);
        return DataSuccess([progressDetailModel]); // Bungkus dalam List
      } else {
        // Jika response.data adalah List (opsional, untuk fleksibilitas)
        final data = (response.data as List)
            .map<ProgressDetailModel>(
              (json) => ProgressDetailModel.fromMap(json),
            )
            .toList();
        return DataSuccess(data);
      }
    } catch (e) {
      return DataFailed(
        DioException(
          error: e,
          requestOptions: RequestOptions(path: '/detail-progress'),
        ),
      );
    }
  }

  Future<DataState<ProgressDetailModel>> fetchProgressDetailDetail(
    int id,
  ) async {
    try {
      final response = await dio.get('/detail-progress/$id');
      final data = ProgressDetailModel.fromMap(response.data);
      return DataSuccess(data);
    } catch (e) {
      return DataFailed(
        DioException(
          error: e,
          requestOptions: RequestOptions(path: '/detail-progress/$id'),
        ),
      );
    }
  }

  Future<DataState<ProgressDetailModel>> updateProgressDetail(
    ProgressDetailModel progressDetail,
  ) async {
    try {
      final response = await dio.put(
        '/detail-progress/${progressDetail.id}',
        data: progressDetail.toMap(),
      );
      final data = ProgressDetailModel.fromMap(response.data);
      return DataSuccess(data);
    } catch (e) {
      return DataFailed(
        DioException(
          error: e,
          requestOptions: RequestOptions(
            path: '/detail-progress/${progressDetail.id}',
          ),
        ),
      );
    }
  }
}
