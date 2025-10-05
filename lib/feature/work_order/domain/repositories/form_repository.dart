import 'package:mobile_intern_pdam/core/resource/data_state.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/entities/form_entity.dart';

abstract class FormRepository {
  Future<DataState<List<FormEntity>>> getFormByWorkOrderTypeId(
    int workOrderTypeId,
  );
  // Future<DataState<FormEntity>> getFormDetail(int id);
}
