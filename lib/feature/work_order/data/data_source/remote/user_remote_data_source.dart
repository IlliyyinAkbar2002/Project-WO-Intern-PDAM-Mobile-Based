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
      print("📥 Response type: ${response.data.runtimeType}");

      // Check if response is a list
      if (response.data is! List) {
        print("❌ Expected List but got ${response.data.runtimeType}");
        return DataFailed(
          DioException(
            error: "Invalid response format: expected List",
            requestOptions: RequestOptions(path: '/pegawai'),
          ),
        );
      }

      final List<dynamic> responseList = response.data as List;
      print("📥 Total items: ${responseList.length}");

      // Check first item structure
      if (responseList.isNotEmpty) {
        print("📥 First item: ${responseList.first}");
        print("📥 First item type: ${responseList.first.runtimeType}");
        if (responseList.first is Map) {
          print(
            "📥 First item keys: ${(responseList.first as Map).keys.toList()}",
          );
        }
      }

      // Parse each item
      final data = responseList.map<UserModel>((item) {
        print("🔍 Processing item: $item");
        print("🔍 Item type: ${item.runtimeType}");

        // Check if this is already a user object with nested pegawai
        // or just a pegawai object that needs to be wrapped
        Map<String, dynamic> userMap;

        if (item['pegawai'] != null) {
          // API already returns user with nested pegawai
          print("✅ Item already has nested 'pegawai' field");
          userMap = Map<String, dynamic>.from(item);
        } else {
          // API returns just pegawai data, need to wrap it
          print("🔄 Wrapping pegawai data in user structure");
          userMap = {
            'id': item['user_id'] ?? item['id'],
            'pegawai_id': item['id'],
            'email': item['email'],
            'role_id': item['role_id'],
            'pegawai': item, // Nest the entire item as pegawai
          };
        }

        print("🔍 Final userMap: $userMap");
        final userModel = UserModel.fromMap(userMap);
        print(
          "🔍 Parsed UserModel: id=${userModel.id}, name=${userModel.employee?.name}, nip=${userModel.employee?.nip}",
        );
        return userModel;
      }).toList();

      print("✅ Successfully parsed ${data.length} users");
      print(
        "✅ Sample result: ${data.isNotEmpty ? '${data.first.employee?.name} - ${data.first.employee?.nip}' : 'empty'}",
      );
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
