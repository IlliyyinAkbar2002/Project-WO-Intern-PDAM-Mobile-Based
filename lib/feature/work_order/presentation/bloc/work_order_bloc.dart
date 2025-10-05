import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_intern_pdam/core/usecase/usecase.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/entities/work_order_entity.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/usecases/form_usecases/get_forms_usecase.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/usecases/location_type_usecases/get_location_type_detail_usecase.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/usecases/location_type_usecases/get_location_types_usecase.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/usecases/progress_detail_usecases/get_progress_details_usecase.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/usecases/progress_detail_usecases/update_progress_detail_usecase.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/usecases/spl_usecases/get_spl_detail.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/usecases/spl_usecases/update_spl_usecase.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/usecases/user_usecases/get_user_detail_usecase.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/usecases/user_usecases/get_users_usecase.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/usecases/work_order_progress_usecases/get_work_order_progress_detail_usecase.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/usecases/work_order_progress_usecases/get_work_order_progresses_usecases.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/usecases/work_order_progress_usecases/update_work_order_progress_usecase.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/usecases/work_order_type_usecases/get_work_order_type_detail_usecase.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/usecases/work_order_type_usecases/get_work_order_types_usecase.dart';
import '/feature/work_order/domain/usecases/get_work_orders_usecase.dart';
import '/feature/work_order/domain/usecases/get_work_order_detail_usecase.dart';
import '/feature/work_order/domain/usecases/create_work_order_usecase.dart';
import '/feature/work_order/domain/usecases/update_work_order_usecase.dart';
import '/feature/work_order/domain/usecases/delete_work_order_usecase.dart';
import '/core/resource/data_state.dart';
import 'work_order_event.dart';
import 'work_order_state.dart';

class WorkOrderBloc extends Bloc<WorkOrderEvent, WorkOrderState> {
  int currentPage = 1;
  int totalPages = 1;
  bool isFetching = false;

  final GetWorkOrdersUseCase getWorkOrdersUseCase;
  final GetWorkOrderDetailUseCase getWorkOrderDetailUseCase;
  final CreateWorkOrderUseCase createWorkOrderUseCase;
  final UpdateWorkOrderUseCase updateWorkOrderUseCase;
  final DeleteWorkOrderUseCase deleteWorkOrderUseCase;

  //work order type
  final GetWorkOrderTypesUsecase getWorkOrderTypesUsecase;
  final GetWorkOrderTypeDetailUsecase getWorkOrderTypeDetailUsecase;

  //location type
  final GetLocationTypesUsecase getLocationTypesUsecase;
  final GetLocationTypeDetailUsecase getLocationTypeDetailUsecase;

  //user
  final GetUsersUsecase getUsersUsecase;
  final GetUserDetailUsecase getUserDetailUsecase;

  //spl
  // final GetSplsUsecase getSplsUsecase;
  final GetSplDetailUseCase getSplDetailUsecase;
  final UpdateSplUseCase updateSplUsecase;

  //progress
  final GetProgressByWorkOrderIdUsecase getProgressByWorkOrderIdUsecase;
  final GetWorkOrderProgressDetailUsecase getWorkOrderProgressDetailUsecase;
  final UpdateWorkOrderProgressUseCase updateWorkOrderProgressUseCase;

  //progress detail
  final GetProgressDetailsUsecase getProgressDetailsUsecase;
  final UpdateProgressDetailUseCase updateProgressDetailUsecase;

  //form
  final GetFormByWorkOrderTypeIdUsecase getFormByWorkOrderTypeIdUsecase;

  // final UpdateLocationUseCase updateLocationUseCase;
  // final GetCurrentLocationUseCase getCurrentLocationUseCase;
  // final SetManualLocationUseCase setManualLocationUseCase;
  // final CalculateEndDateTime calculateEndDateTime;

  WorkOrderBloc(
    this.getWorkOrdersUseCase,
    this.getWorkOrderDetailUseCase,
    this.createWorkOrderUseCase,
    this.updateWorkOrderUseCase,
    this.deleteWorkOrderUseCase,

    //work order type
    this.getWorkOrderTypesUsecase,
    this.getWorkOrderTypeDetailUsecase,

    //location type
    this.getLocationTypesUsecase,
    this.getLocationTypeDetailUsecase,

    //user
    this.getUsersUsecase,
    this.getUserDetailUsecase,

    //spl
    // this.getSplsUsecase,
    this.getSplDetailUsecase,
    this.updateSplUsecase,

    //progress
    this.getProgressByWorkOrderIdUsecase,
    this.getWorkOrderProgressDetailUsecase,
    this.updateWorkOrderProgressUseCase,

    //progress detail
    this.getProgressDetailsUsecase,
    this.updateProgressDetailUsecase,

    //form
    this.getFormByWorkOrderTypeIdUsecase,

    // this.updateLocationUseCase,
    // this.getCurrentLocationUseCase,
    // this.setManualLocationUseCase,
    // this.calculateEndDateTime,
  ) : super(WorkOrderInitial()) {
    on<GetWorkOrdersEvent>(_onGetWorkOrdersEvent);
    on<LoadMoreWorkOrdersEvent>(_onLoadMoreWorkOrdersEvent);
    on<GetWorkOrderDetailEvent>(_onGetWorkOrderDetailEvent);
    on<CreateWorkOrderEvent>(_onCreateWorkOrderEvent);
    on<UpdateWorkOrderEvent>(_onUpdateWorkOrderEvent);
    on<DeleteWorkOrderEvent>(_onDeleteWorkOrderEvent);
    on<SearchWorkOrdersEvent>(_onSearchWorkOrdersEvent);

    //work order type
    on<GetWorkOrderTypesEvent>(_onGetWorkOrderTypesEvent);
    on<GetWorkOrderTypeDetailEvent>(_onGetWorkOrderTypeDetailEvent);

    //location type
    on<GetLocationTypesEvent>(_onGetLocationTypesEvent);
    on<GetLocationTypeDetailEvent>(_onGetLocationTypeDetailEvent);

    //user
    on<GetUsersEvent>(_onGetUsersEvent);
    on<GetUserDetailEvent>(_onGetUserDetailEvent);

    //spl
    // on<GetSplsEvent>(_onGetSplsEvent);
    on<GetSplDetailEvent>(_onGetSplDetailEvent);
    on<UpdateSplEvent>(_onUpdateSplEvent);

    //progress
    on<GetProgressByWorkOrderIdEvent>(_onGetProgressByWorkOrderIdEvent);
    on<GetWorkOrderProgressDetailEvent>(_onGetWorkOrderProgressDetailEvent);
    on<UpdateWorkOrderProgressEvent>(_onUpdateWorkOrderProgressEvent);

    //progress detail
    on<GetProgressDetailsEvent>(_onGetProgressDetailsEvent);
    on<UpdateProgressDetailEvent>(_onUpdateProgressDetailEvent);

    //form
    on<GetFormByWorkOrderTypeIdEvent>(_onGetFormByWorkOrderTypeIdEvent);

    // on<UpdateLocationEvent>(_onUpdateLocationEvent);
    // on<GetCurrentLocationEvent>(_onGetCurrentLocationEvent);
    // on<SetManualLocationEvent>(_onSetManualLocationEvent);
    // on<CalculateEndDateTimeEvent>(_onCalculateEndDateTimeEvent);
  }

  Future<void> _onGetWorkOrdersEvent(
    GetWorkOrdersEvent event,
    Emitter<WorkOrderState> emit,
  ) async {
    emit(WorkOrderLoading());
    print("🟡 Memuat data Work Order...");
    try {
      currentPage = 1;
      final dataState = await getWorkOrdersUseCase(
        WorkOrderParams(
          page: currentPage,
          limit: 20,
          status: event.status,
          excludeStatus: event.excludeStatus,
          picId: event.picId,
          userId: event.userId,
          type: event.type,
          dateRange: event.dateRange,
          startDate: event.startDate,
          endDate: event.endDate,
        ),
      );
      if (dataState is PaginatedDataSuccess<List<WorkOrderEntity>>) {
        print("📥 Data yang diterima sebelum parsing: ${dataState.data}");
        print("✅ Data Work Order berhasil dimuat: ${dataState.data!.length}");

        if (dataState.data!.isEmpty) {
          print("❌ Data berhasil diambil tetapi kosong setelah parsing!");
        }
        totalPages = dataState.totalPages;
        emit(WorkOrderLoaded(dataState.data!));
      } else if (dataState is DataFailed) {
        print("❌ Gagal memuat Work Order: ${dataState.error}");
        emit(WorkOrderError(dataState.error.toString()));
      }
    } catch (e) {
      print("❌ Error saat mengambil Work Order: $e");
      emit(WorkOrderError("Terjadi kesalahan saat mengambil data: $e"));
    }
  }

  Future<void> _onLoadMoreWorkOrdersEvent(
    LoadMoreWorkOrdersEvent event,
    Emitter<WorkOrderState> emit,
  ) async {
    if (currentPage >= totalPages || isFetching) return;
    isFetching = true;
    currentPage++;

    final dataState = await getWorkOrdersUseCase(
      WorkOrderParams(
        page: currentPage,
        limit: event.limit,
        status: event.status,
        excludeStatus: event.excludeStatus,
        picId: event.picId,
        userId: event.userId,
        type: event.type,
        dateRange: event.dateRange,
        startDate: event.startDate,
        endDate: event.endDate,
      ),
    );

    if (dataState is PaginatedDataSuccess) {
      final updatedList = List<WorkOrderEntity>.from(
        (state as WorkOrderLoaded).workOrders,
      )..addAll(dataState.data!);
      emit(WorkOrderLoaded(updatedList));
    }
    isFetching = false;
  }

  Future<void> _onGetWorkOrderDetailEvent(
    GetWorkOrderDetailEvent event,
    Emitter<WorkOrderState> emit,
  ) async {
    emit(WorkOrderLoading());
    try {
      final dataState = await getWorkOrderDetailUseCase(event.id);
      if (dataState is DataSuccess) {
        emit(WorkOrderDetailLoaded(dataState.data!));
      } else if (dataState is DataFailed) {
        emit(WorkOrderError(dataState.error.toString()));
      }
    } catch (e) {
      emit(
        WorkOrderError("Terjadi kesalahan saat mengambil detail pekerjaan: $e"),
      );
    }
  }

  Future<void> _onCreateWorkOrderEvent(
    CreateWorkOrderEvent event,
    Emitter<WorkOrderState> emit,
  ) async {
    emit(WorkOrderLoading());
    try {
      final dataState = await createWorkOrderUseCase(event.workOrder);
      if (dataState is DataSuccess) {
        emit(WorkOrderCreated(dataState.data!));
      } else if (dataState is DataFailed) {
        emit(WorkOrderError(dataState.error.toString()));
      }
    } catch (e) {
      emit(WorkOrderError("Gagal membuat pekerjaan: $e"));
    }
  }

  Future<void> _onUpdateWorkOrderEvent(
    UpdateWorkOrderEvent event,
    Emitter<WorkOrderState> emit,
  ) async {
    emit(WorkOrderLoading());
    try {
      final dataState = await updateWorkOrderUseCase(event.workOrder);
      if (dataState is DataSuccess) {
        emit(WorkOrderUpdated(dataState.data!));
      } else if (dataState is DataFailed) {
        emit(WorkOrderError(dataState.error.toString()));
      }
    } catch (e) {
      emit(WorkOrderError("Gagal memperbarui pekerjaan: $e"));
    }
  }

  Future<void> _onDeleteWorkOrderEvent(
    DeleteWorkOrderEvent event,
    Emitter<WorkOrderState> emit,
  ) async {
    emit(WorkOrderLoading());
    try {
      final dataState = await deleteWorkOrderUseCase(event.id);
      if (dataState is DataSuccess) {
        emit(WorkOrderDeleted());
      } else if (dataState is DataFailed) {
        emit(WorkOrderError(dataState.error.toString()));
      }
    } catch (e) {
      emit(WorkOrderError("Gagal menghapus pekerjaan: $e"));
    }
  }

  Future<void> _onSearchWorkOrdersEvent(
    SearchWorkOrdersEvent event,
    Emitter<WorkOrderState> emit,
  ) async {
    emit(WorkOrderLoading());
    try {
      final dataState = await getWorkOrdersUseCase(
        WorkOrderParams(
          page: currentPage,
          limit: 20,
          status: event.status,
          excludeStatus: event.excludeStatus,
          picId: event.picId,
          userId: event.userId,
          type: event.type,
          dateRange: event.dateRange,
          startDate: event.startDate,
          endDate: event.endDate,
          search: event.query,
        ),
      );
      if (dataState is PaginatedDataSuccess<List<WorkOrderEntity>>) {
        emit(WorkOrderLoaded(dataState.data!));
      } else if (dataState is DataFailed) {
        emit(WorkOrderError(dataState.error.toString()));
      }
    } catch (e) {
      emit(WorkOrderError("Gagal mencari pekerjaan: $e"));
    }
  }

  //work order type
  Future<void> _onGetWorkOrderTypesEvent(
    GetWorkOrderTypesEvent event,
    Emitter<WorkOrderState> emit,
  ) async {
    emit(WorkOrderLoading());
    try {
      final dataState = await getWorkOrderTypesUsecase(const NoParams());
      if (dataState is DataSuccess) {
        emit(WorkOrderTypesLoaded(dataState.data!));
      } else if (dataState is DataFailed) {
        emit(WorkOrderError(dataState.error.toString()));
      }
    } catch (e) {
      emit(WorkOrderError("Gagal mengambil tipe pekerjaan: $e"));
    }
  }

  Future<void> _onGetWorkOrderTypeDetailEvent(
    GetWorkOrderTypeDetailEvent event,
    Emitter<WorkOrderState> emit,
  ) async {
    emit(WorkOrderLoading());
    try {
      final dataState = await getWorkOrderTypeDetailUsecase(event.id);
      if (dataState is DataSuccess) {
        emit(WorkOrderTypeDetailLoaded(dataState.data!));
      } else if (dataState is DataFailed) {
        emit(WorkOrderError(dataState.error.toString()));
      }
    } catch (e) {
      emit(WorkOrderError("Gagal mengambil detail tipe pekerjaan: $e"));
    }
  }

  //location type
  Future<void> _onGetLocationTypesEvent(
    GetLocationTypesEvent event,
    Emitter<WorkOrderState> emit,
  ) async {
    emit(WorkOrderLoading());
    try {
      final dataState = await getLocationTypesUsecase(const NoParams());
      if (dataState is DataSuccess) {
        emit(LocationTypesLoaded(dataState.data!));
      } else if (dataState is DataFailed) {
        emit(WorkOrderError(dataState.error.toString()));
      }
    } catch (e) {
      emit(WorkOrderError("Gagal mengambil tipe lokasi: $e"));
    }
  }

  Future<void> _onGetLocationTypeDetailEvent(
    GetLocationTypeDetailEvent event,
    Emitter<WorkOrderState> emit,
  ) async {
    emit(WorkOrderLoading());
    try {
      final dataState = await getLocationTypeDetailUsecase(event.id);
      if (dataState is DataSuccess) {
        emit(LocationTypeDetailLoaded(dataState.data!));
      } else if (dataState is DataFailed) {
        emit(WorkOrderError(dataState.error.toString()));
      }
    } catch (e) {
      emit(WorkOrderError("Gagal mengambil detail tipe lokasi: $e"));
    }
  }

  //user
  Future<void> _onGetUsersEvent(
    GetUsersEvent event,
    Emitter<WorkOrderState> emit,
  ) async {
    emit(WorkOrderLoading());
    try {
      final dataState = await getUsersUsecase(const NoParams());
      print("UserBloc - Loaded Users: $dataState");
      if (dataState is DataSuccess) {
        emit(UsersLoaded(dataState.data!));
      } else if (dataState is DataFailed) {
        emit(WorkOrderError(dataState.error.toString()));
      }
    } catch (e) {
      emit(WorkOrderError("Gagal mengambil pengguna: $e"));
    }
  }

  Future<void> _onGetUserDetailEvent(
    GetUserDetailEvent event,
    Emitter<WorkOrderState> emit,
  ) async {
    emit(WorkOrderLoading());
    try {
      final dataState = await getUserDetailUsecase(event.id);
      if (dataState is DataSuccess) {
        emit(UserDetailLoaded(dataState.data!));
      } else if (dataState is DataFailed) {
        emit(WorkOrderError(dataState.error.toString()));
      }
    } catch (e) {
      emit(WorkOrderError("Gagal mengambil detail pengguna: $e"));
    }
  }

  //spl
  Future<void> _onGetSplDetailEvent(
    GetSplDetailEvent event,
    Emitter<WorkOrderState> emit,
  ) async {
    emit(WorkOrderLoading());
    try {
      final dataState = await getSplDetailUsecase(event.id);
      if (dataState is DataSuccess) {
        emit(SplDetailLoaded(dataState.data!));
      } else if (dataState is DataFailed) {
        emit(WorkOrderError(dataState.error.toString()));
      }
    } catch (e) {
      emit(WorkOrderError("Gagal mengambil detail pengguna: $e"));
    }
  }

  Future<void> _onUpdateSplEvent(
    UpdateSplEvent event,
    Emitter<WorkOrderState> emit,
  ) async {
    emit(WorkOrderLoading());
    try {
      final dataState = await updateSplUsecase(event.spl);
      if (dataState is DataSuccess) {
        emit(SplUpdated(dataState.data!));
      } else if (dataState is DataFailed) {
        emit(WorkOrderError(dataState.error.toString()));
      }
    } catch (e) {
      emit(WorkOrderError("Gagal memperbarui detail pengguna: $e"));
    }
  }

  //progress
  Future<void> _onGetProgressByWorkOrderIdEvent(
    GetProgressByWorkOrderIdEvent event,
    Emitter<WorkOrderState> emit,
  ) async {
    emit(WorkOrderLoading());
    try {
      final dataState = await getProgressByWorkOrderIdUsecase(
        event.workOrderId,
      );
      if (dataState is DataSuccess) {
        emit(ProgressesLoaded(dataState.data!));
      } else if (dataState is DataFailed) {
        emit(WorkOrderError(dataState.error.toString()));
      }
    } catch (e) {
      emit(WorkOrderError("Gagal mengambil progres pekerjaan: $e"));
    }
  }

  Future<void> _onGetWorkOrderProgressDetailEvent(
    GetWorkOrderProgressDetailEvent event,
    Emitter<WorkOrderState> emit,
  ) async {
    emit(WorkOrderLoading());
    try {
      final dataState = await getWorkOrderProgressDetailUsecase(event.id);
      if (dataState is DataSuccess) {
        emit(WorkOrderProgressDetailLoaded(dataState.data!));
      } else if (dataState is DataFailed) {
        emit(WorkOrderError(dataState.error.toString()));
      }
    } catch (e) {
      emit(WorkOrderError("Gagal mengambil detail progres: $e"));
    }
  }

  Future<void> _onUpdateWorkOrderProgressEvent(
    UpdateWorkOrderProgressEvent event,
    Emitter<WorkOrderState> emit,
  ) async {
    emit(WorkOrderLoading());
    try {
      final dataState = await updateWorkOrderProgressUseCase(event.progress);
      if (dataState is DataSuccess) {
        emit(WorkOrderProgressUpdated(dataState.data!));
      } else if (dataState is DataFailed) {
        emit(WorkOrderError(dataState.error.toString()));
      }
    } catch (e) {
      emit(WorkOrderError("Gagal memperbarui detail progres: $e"));
    }
  }

  //progress detail
  Future<void> _onGetProgressDetailsEvent(
    GetProgressDetailsEvent event,
    Emitter<WorkOrderState> emit,
  ) async {
    emit(WorkOrderLoading());
    try {
      final dataState = await getProgressDetailsUsecase(
        event.workOrderProgressId,
      );
      if (dataState is DataSuccess) {
        emit(ProgressDetailsLoaded(dataState.data!));
      } else if (dataState is DataFailed) {
        emit(WorkOrderError(dataState.error.toString()));
      }
    } catch (e) {
      emit(WorkOrderError("Gagal mengambil detail progres: $e"));
    }
  }

  Future<void> _onUpdateProgressDetailEvent(
    UpdateProgressDetailEvent event,
    Emitter<WorkOrderState> emit,
  ) async {
    emit(WorkOrderLoading());
    try {
      final dataState = await updateProgressDetailUsecase(event.progressDetail);
      if (dataState is DataSuccess) {
        emit(ProgressDetailUpdated(dataState.data!));
      } else if (dataState is DataFailed) {
        emit(WorkOrderError(dataState.error.toString()));
      }
    } catch (e) {
      emit(WorkOrderError("Gagal memperbarui detail progres: $e"));
    }
  }

  //form
  Future<void> _onGetFormByWorkOrderTypeIdEvent(
    GetFormByWorkOrderTypeIdEvent event,
    Emitter<WorkOrderState> emit,
  ) async {
    emit(WorkOrderLoading());
    try {
      final dataState = await getFormByWorkOrderTypeIdUsecase(
        event.workOrderTypeId,
      );
      if (dataState is DataSuccess) {
        emit(FormsLoaded(dataState.data!));
      } else if (dataState is DataFailed) {
        emit(WorkOrderError(dataState.error.toString()));
      }
    } catch (e) {
      emit(WorkOrderError("Gagal mengambil form: $e"));
    }
  }
}
