import 'package:dio/dio.dart';
import 'package:mobile_intern_pdam/core/resource/data_state.dart';
import 'package:mobile_intern_pdam/core/resource/remote_data_source.dart';
import 'package:mobile_intern_pdam/feature/work_order/data/models/user_model.dart';

class UserRemoteDataSource extends RemoteDatasource {
  UserRemoteDataSource() : super();

  Future<DataState<List<UserModel>>> fetchUsers() async {
    try {
      // Use parent class's get() method which includes auth headers
      final response = await get(path: '/pegawai');
      print("📥 Raw response from /pegawai: ${response.data}");

      // Check first item structure
      if (response.data is List && (response.data as List).isNotEmpty) {
        print("📥 First pegawai item: ${(response.data as List).first}");
        print("📥 First pegawai keys: ${(response.data as List).first.keys}");
      }

      // Transform pegawai data to User format
      final data = (response.data as List).map<UserModel>((pegawai) {
        print("🔍 Processing pegawai: $pegawai");
        // Convert pegawai object to user object with nested employee
        final transformedData = {
          'id': pegawai['id'],
          'pegawai_id': pegawai['id'],
          'email': null,
          'role_id': null,
          'pegawai': pegawai, // Nest the pegawai object
        };
        final userModel = UserModel.fromMap(transformedData);
        print(
          "🔍 UserModel: name=${userModel.employee?.name}, nip=${userModel.employee?.nip}",
        );
        return userModel;
      }).toList();
      print("✅ Parsed ${data.length} users/pegawai");
      return DataSuccess(data);
    } catch (e, stackTrace) {
      print("❌ Error fetching pegawai: $e");
      print("❌ Stack trace: $stackTrace");
      return DataFailed(
        DioException(
          error: e,
          requestOptions: RequestOptions(path: '/pegawai'),
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
