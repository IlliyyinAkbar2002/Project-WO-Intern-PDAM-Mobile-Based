import 'package:mobile_intern_pdam/core/resource/data_state.dart';
import 'package:mobile_intern_pdam/core/usecase/usecase.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/entities/progress_detail_entity.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/repositories/progress_detail_repository.dart';

class GetProgressDetailUsecase
    implements UseCase<Future<DataState<ProgressDetailEntity>>, int> {
  final ProgressDetailRepository repository;

  GetProgressDetailUsecase(this.repository);

  @override
  Future<DataState<ProgressDetailEntity>> call(int id) {
    return repository.getProgressDetail(id);
  }
}
