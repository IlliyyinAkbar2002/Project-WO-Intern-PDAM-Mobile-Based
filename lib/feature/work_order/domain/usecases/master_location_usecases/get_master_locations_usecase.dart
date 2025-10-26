import 'package:mobile_intern_pdam/core/resource/data_state.dart';
import 'package:mobile_intern_pdam/core/usecase/usecase.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/entities/master_location_entity.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/repositories/master_location_repository.dart';

class GetMasterLocationsUsecase
    implements UseCase<Future<DataState<List<MasterLocationEntity>>>, void> {
  final MasterLocationRepository repository;

  GetMasterLocationsUsecase(this.repository);

  @override
  Future<DataState<List<MasterLocationEntity>>> call(void params) {
    return repository.getMasterLocations();
  }
}

