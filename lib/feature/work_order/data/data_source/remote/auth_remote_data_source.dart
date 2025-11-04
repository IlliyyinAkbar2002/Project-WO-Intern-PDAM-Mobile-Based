import 'package:dio/dio.dart';
import 'package:mobile_intern_pdam/core/resource/data_state.dart';
import 'package:mobile_intern_pdam/core/resource/remote_data_source.dart';
import 'package:mobile_intern_pdam/feature/work_order/data/models/auth_response_model.dart';

class AuthRemoteDataSource extends RemoteDatasource {
  AuthRemoteDataSource() : super();

  Future<DataState<AuthResponseModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      print('🔐 Attempting login for: $email');
      print('📡 Full URL: ${dio.options.baseUrl}/v1/mobile/login');
      print('📡 Headers: ${dio.options.headers}');
      print(
        '📤 Sending data: {email: $email, password: ${password.replaceAll(RegExp(r'.'), '*')}}',
      );

      final response = await post(
        path: '/v1/mobile/login',
        data: {'email': email, 'password': password},
      );

      print('✅ Login response status: ${response.statusCode}');
      print('📥 Response headers: ${response.headers}');
      print('📥 Response data: ${response.data}');

      final data = AuthResponseModel.fromMap(response.data);
      return DataSuccess(data);
    } on DioException catch (e) {
      print('❌ DioException Type: ${e.type}');
      print('❌ Error Message: ${e.message}');
      print('❌ Response Status: ${e.response?.statusCode}');
      print('❌ Response Data: ${e.response?.data}');
      print('❌ Response Headers: ${e.response?.headers}');
      print('❌ Request URL: ${e.requestOptions.uri}');
      print('❌ Request Headers: ${e.requestOptions.headers}');
      return DataFailed(e);
    } catch (e) {
      print('❌ Unexpected Error: $e');
      return DataFailed(
        DioException(
          error: e,
          requestOptions: RequestOptions(path: '/v1/mobile/login'),
        ),
      );
    }
  }
}
