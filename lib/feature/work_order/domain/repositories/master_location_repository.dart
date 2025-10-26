import 'package:mobile_intern_pdam/core/resource/data_state.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/entities/master_location_entity.dart';

abstract class MasterLocationRepository {
  Future<DataState<List<MasterLocationEntity>>> getMasterLocations();
  Future<DataState<MasterLocationEntity>> getMasterLocationDetail(int id);
}
