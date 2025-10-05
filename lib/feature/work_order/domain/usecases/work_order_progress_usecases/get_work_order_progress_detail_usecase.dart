import 'package:mobile_intern_pdam/core/resource/data_state.dart';
import 'package:mobile_intern_pdam/core/usecase/usecase.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/entities/work_order_progress_entity.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/repositories/work_order_progress_repository.dart';

class GetWorkOrderProgressDetailUsecase
    implements UseCase<Future<DataState<WorkOrderProgressEntity>>, int> {
  final WorkOrderProgressRepository repository;

  GetWorkOrderProgressDetailUsecase(this.repository);

  @override
  Future<DataState<WorkOrderProgressEntity>> call(int id) {
    return repository.getWorkOrderProgressDetail(id);
  }
}
