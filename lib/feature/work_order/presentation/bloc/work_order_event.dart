import 'package:mobile_intern_pdam/feature/work_order/data/models/work_order_progress_model.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/entities/progress_detail_entity.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/entities/spl_entity.dart';

import '/feature/work_order/domain/entities/work_order_entity.dart';

abstract class WorkOrderEvent {}

class GetWorkOrdersEvent extends WorkOrderEvent {
  final List<int>? status;
  final List<int>? excludeStatus;
  final int? picId;
  final int? userId;
  final int? type;
  final String? dateRange;
  final String? startDate;
  final String? endDate;
  final String? search;

  GetWorkOrdersEvent({
    this.status,
    this.excludeStatus,
    this.picId,
    this.userId,
    this.type,
    this.dateRange,
    this.startDate,
    this.endDate,
    this.search,
  });
}

class LoadMoreWorkOrdersEvent extends WorkOrderEvent {
  final int page;
  final int limit;
  final List<int>? status;
  final List<int>? excludeStatus;
  final int? picId;
  final int? userId;
  final int? type;
  final String? dateRange;
  final String? startDate;
  final String? endDate;

  LoadMoreWorkOrdersEvent(
    this.page,
    this.limit, {
    this.status,
    this.excludeStatus,
    this.picId,
    this.userId,
    this.type,
    this.dateRange,
    this.startDate,
    this.endDate,
  });
}

class SearchWorkOrdersEvent extends WorkOrderEvent {
  final String query;
  final List<int>? status;
  final List<int>? excludeStatus;
  final int? picId;
  final int? userId;
  final int? type;
  final String? dateRange;
  final String? startDate;
  final String? endDate;

  SearchWorkOrdersEvent(
    this.query, {
    this.status,
    this.excludeStatus,
    this.picId,
    this.userId,
    this.type,
    this.dateRange,
    this.startDate,
    this.endDate,
  });
}

class GetWorkOrderDetailEvent extends WorkOrderEvent {
  final int id;

  GetWorkOrderDetailEvent(this.id);
}

class CreateWorkOrderEvent extends WorkOrderEvent {
  final WorkOrderEntity workOrder;

  CreateWorkOrderEvent(this.workOrder);
}

class UpdateWorkOrderEvent extends WorkOrderEvent {
  final WorkOrderEntity workOrder;

  UpdateWorkOrderEvent(this.workOrder);
}

class DeleteWorkOrderEvent extends WorkOrderEvent {
  final int id;

  DeleteWorkOrderEvent(this.id);
}

//work order type
class GetWorkOrderTypesEvent extends WorkOrderEvent {}

class GetWorkOrderTypeDetailEvent extends WorkOrderEvent {
  final int id;

  GetWorkOrderTypeDetailEvent(this.id);
}

//location type
class GetLocationTypesEvent extends WorkOrderEvent {}

class GetLocationTypeDetailEvent extends WorkOrderEvent {
  final int id;

  GetLocationTypeDetailEvent(this.id);
}

//user
class GetUsersEvent extends WorkOrderEvent {}

class GetUserDetailEvent extends WorkOrderEvent {
  final int id;

  GetUserDetailEvent(this.id);
}

//spl
class GetSplDetailEvent extends WorkOrderEvent {
  final int id;

  GetSplDetailEvent(this.id);
}

class UpdateSplEvent extends WorkOrderEvent {
  final SplEntity spl;

  UpdateSplEvent(this.spl);
}

//progress
class GetProgressByWorkOrderIdEvent extends WorkOrderEvent {
  final int workOrderId;

  GetProgressByWorkOrderIdEvent(this.workOrderId);
}

class GetWorkOrderProgressDetailEvent extends WorkOrderEvent {
  final int id;

  GetWorkOrderProgressDetailEvent(this.id);
}

class UpdateWorkOrderProgressEvent extends WorkOrderEvent {
  final WorkOrderProgressModel progress;

  UpdateWorkOrderProgressEvent(this.progress);
}

//progress detail
class GetProgressDetailsEvent extends WorkOrderEvent {
  final int workOrderProgressId;

  GetProgressDetailsEvent(this.workOrderProgressId);
}

class UpdateProgressDetailEvent extends WorkOrderEvent {
  final ProgressDetailEntity progressDetail;

  UpdateProgressDetailEvent(this.progressDetail);
}

//form
class GetFormByWorkOrderTypeIdEvent extends WorkOrderEvent {
  final int workOrderTypeId;

  GetFormByWorkOrderTypeIdEvent(this.workOrderTypeId);
}

//master location
class GetMasterLocationsEvent extends WorkOrderEvent {}

class GetMasterLocationDetailEvent extends WorkOrderEvent {
  final int id;

  GetMasterLocationDetailEvent(this.id);
}
