import 'package:dio/dio.dart';
import '/core/resource/data_state.dart';
import '/feature/work_order/data/models/work_order_model.dart';
import '/core/resource/remote_data_source.dart';

class WorkOrderRemoteDataSource extends RemoteDatasource {
  WorkOrderRemoteDataSource() : super();

  Future<DataState<List<WorkOrderModel>>> fetchWorkOrders(
    int page,
    int limit,
    List<int>? status,
    List<int>? excludeStatus,
    int? picId,
    int? userId,
    int? type,
    String? dateRange,
    String? startDate,
    String? endDate,
    String? search,
  ) async {
    try {
      final queryParameters = {
        'page': page,
        'limit': limit,
        if (status != null) 'status': status.join(','),
        if (excludeStatus != null) 'exclude_status': excludeStatus.join(','),
        if (picId != null) 'pic_id': picId,
        if (userId != null) 'user_id': userId,
        if (type != null) 'type': type,
        if (dateRange != null) 'date_range': dateRange,
        if (startDate != null) 'start_date': startDate,
        if (endDate != null) 'end_date': endDate,
        if (search != null) 'search': search,
      };

      // Use parent class's get() method which includes auth headers
      final response = await get(
        path: '/workorder',
        queryParameters: queryParameters,
      );
      final data = response.data['data']
          .map<WorkOrderModel>((json) => WorkOrderModel.fromMap(json))
          .toList();
      final totalPages = response.data['totalPages'];
      final currentPage = response.data['currentPage'];
      return PaginatedDataSuccess(
        data,
        totalPages: totalPages,
        currentPage: currentPage,
      );
    } catch (e) {
      return DataFailed(
        DioException(
          error: e,
          requestOptions: RequestOptions(path: '/workorder'),
        ),
      );
    }
  }

  Future<DataState<WorkOrderModel>> fetchWorkOrderDetail(int id) async {
    try {
      // Use parent class's get() method which includes auth headers
      final response = await get(path: '/workorder/$id');
      final data = WorkOrderModel.fromMap(response.data);
      return DataSuccess(data);
    } catch (e) {
      return DataFailed(
        DioException(
          error: e,
          requestOptions: RequestOptions(path: '/workorder/$id'),
        ),
      );
    }
  }

  Future<DataState<WorkOrderModel>> createWorkOrder(
    WorkOrderModel workOrder,
  ) async {
    try {
      print("📤 Mengirim request ke API: ${dio.options.baseUrl}/workorder");
      print("📤 Data yang dikirim: ${workOrder.toMap()}");

      // Use parent class's post() method which includes auth headers
      final response = await post(path: '/workorder', data: workOrder.toMap());
      print("📥 Response: ${response.statusCode} - ${response.data}");
      final data = WorkOrderModel.fromMap(response.data);
      return DataSuccess(data);
    } catch (e) {
      return DataFailed(
        DioException(
          error: e,
          requestOptions: RequestOptions(path: '/workorder'),
        ),
      );
    }
  }

  Future<DataState<WorkOrderModel>> updateWorkOrder(
    WorkOrderModel workOrder,
  ) async {
    try {
      // Use parent class's put() method which includes auth headers
      final response = await put(
        path: '/workorder/${workOrder.id}',
        data: workOrder.toMap(),
      );
      final data = WorkOrderModel.fromMap(response.data);
      return DataSuccess(data);
    } catch (e) {
      return DataFailed(
        DioException(
          error: e,
          requestOptions: RequestOptions(path: '/workorder/${workOrder.id}'),
        ),
      );
    }
  }

  Future<DataState<void>> deleteWorkOrder(int id) async {
    try {
      // Use parent class's delete() method which includes auth headers
      await delete(path: '/workorder/$id');
      return const DataSuccess(null);
    } catch (e) {
      return DataFailed(
        DioException(
          error: e,
          requestOptions: RequestOptions(path: '/workorder/$id'),
        ),
      );
    }
  }
}
