import 'package:equatable/equatable.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/entities/location_type_entity.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/entities/status_entity.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/entities/user_entity.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/entities/work_order_type_entity.dart';

class WorkOrderEntity extends Equatable {
  final int? id;
  final String title;
  final DateTime? startDateTime;
  final int? duration;
  final String? durationUnit;
  final DateTime? endDateTime;
  final double? longitude;
  final double? latitude;
  final int? creator;
  final int? assigneeId;
  final int? statusId; //Mengambil dari Status
  final int? workOrderTypeId; //Mengambil dari WorkOrderType
  final int? splId;
  final int? locationTypeId; //Mengambil dari LocationType
  final bool requiresApproval;
  final List<int>? assigneeIds;
  final UserEntity? assignee;
  final List<UserEntity>? assignees;
  final LocationTypeEntity? locationType;
  final WorkOrderTypeEntity? workOrderType;
  final StatusEntity? status;

  // final AssigneesEntity? assignees;
  // final String? description;
  // final LocationEntity? location;
  // final DepartmentEntity? department;

  const WorkOrderEntity({
    this.id,
    required this.title,
    this.startDateTime,
    this.duration,
    this.durationUnit,
    this.endDateTime,
    this.longitude,
    this.latitude,
    this.creator,
    this.assigneeId,
    this.statusId,
    this.workOrderTypeId,
    this.splId,
    this.locationTypeId,
    this.requiresApproval = false,
    this.assigneeIds,
    this.assignee,
    this.assignees,
    this.locationType,
    this.workOrderType,
    this.status,

    // this.description,
    // this.location,
    // this.department,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    startDateTime,
    duration,
    durationUnit,
    endDateTime,
    longitude,
    latitude,
    creator,
    assigneeId,
    statusId,
    workOrderTypeId,
    splId,
    locationTypeId,
    requiresApproval,
    assigneeIds,
    assignee,
    assignees,
    locationType,
    workOrderType,
    status,
  ];

  WorkOrderEntity copyWith({
    int? id,
    String? title,
    DateTime? startDateTime,
    int? duration,
    String? durationUnit,
    DateTime? endDateTime,
    double? longitude,
    double? latitude,
    int? creator,
    int? assigneeId,
    int? statusId,
    int? workOrderTypeId,
    int? splId,
    int? locationTypeId,
    bool? requiresApproval,
    List<int>? assigneeIds,
    UserEntity? assignee,
    List<UserEntity>? assignees,
    LocationTypeEntity? locationType,
    WorkOrderTypeEntity? workOrderType,
    StatusEntity? status,
  }) {
    return WorkOrderEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      startDateTime: startDateTime ?? this.startDateTime,
      duration: duration ?? this.duration,
      durationUnit: durationUnit ?? this.durationUnit,
      endDateTime: endDateTime ?? this.endDateTime,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      creator: creator ?? this.creator,
      assigneeId: assigneeId ?? this.assigneeId,
      statusId: statusId ?? this.statusId,
      workOrderTypeId: workOrderTypeId ?? this.workOrderTypeId,
      splId: splId ?? this.splId,
      locationTypeId: locationTypeId ?? this.locationTypeId,
      requiresApproval: requiresApproval ?? this.requiresApproval,
      assigneeIds: assigneeIds ?? this.assigneeIds,
      assignee: assignee ?? this.assignee,
      assignees: assignees ?? this.assignees,
      locationType: locationType ?? this.locationType,
      workOrderType: workOrderType ?? this.workOrderType,
      status: status ?? this.status,
    );
  }
}
