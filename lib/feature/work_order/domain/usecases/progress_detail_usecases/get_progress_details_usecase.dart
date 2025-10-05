import 'package:mobile_intern_pdam/core/resource/data_state.dart';
import 'package:mobile_intern_pdam/core/usecase/usecase.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/entities/progress_detail_entity.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/repositories/progress_detail_repository.dart';

class GetProgressDetailsUsecase
    implements UseCase<Future<DataState<List<ProgressDetailEntity>>>, int> {
  final ProgressDetailRepository repository;

  GetProgressDetailsUsecase(this.repository);

  @override
  Future<DataState<List<ProgressDetailEntity>>> call(int workOrderProgressId) {
    return repository.getProgressDetails(workOrderProgressId);
  }
}
