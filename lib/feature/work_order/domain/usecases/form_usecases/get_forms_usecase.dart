import 'package:mobile_intern_pdam/core/resource/data_state.dart';
import 'package:mobile_intern_pdam/core/usecase/usecase.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/entities/form_entity.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/repositories/form_repository.dart';

class GetFormByWorkOrderTypeIdUsecase
    implements UseCase<Future<DataState<List<FormEntity>>>, int> {
  final FormRepository repository;

  GetFormByWorkOrderTypeIdUsecase(this.repository);

  @override
  Future<DataState<List<FormEntity>>> call(int workOrderTypeId) {
    return repository.getFormByWorkOrderTypeId(workOrderTypeId);
  }
}
