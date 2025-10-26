import 'package:flutter/material.dart';
import 'package:mobile_intern_pdam/core/resource/data_state.dart';
import 'package:mobile_intern_pdam/feature/work_order/data/data_source/remote/master_location_remote_data_source.dart';
import 'package:mobile_intern_pdam/feature/work_order/data/models/master_location_model.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/entities/master_location_entity.dart';
import 'package:mobile_intern_pdam/feature/work_order/domain/repositories/master_location_repository.dart';

class MasterLocationRepositoryImpl implements MasterLocationRepository {
  final MasterLocationRemoteDataSource remoteDataSource;

  MasterLocationRepositoryImpl(this.remoteDataSource);

  @override
  Future<DataState<List<MasterLocationEntity>>> getMasterLocations() async {
    try {
      final response = await remoteDataSource.fetchMasterLocations();
      debugPrint("📥 Data dari RemoteDataSource: $response");
      if (response is DataSuccess<List<MasterLocationModel>>) {
        final entities = response.data!
            .map((model) => model.toEntity())
            .toList();
        return DataSuccess(entities);
      } else {
        return DataFailed(response.error!);
      }
    } catch (e) {
      return DataFailed("Terjadi kesalahan: $e");
    }
  }

  @override
  Future<DataState<MasterLocationEntity>> getMasterLocationDetail(
    int id,
  ) async {
    try {
      final response = await remoteDataSource.fetchMasterLocationDetail(id);
      debugPrint("📥 Data dari RemoteDataSource: $response");
      if (response is DataSuccess<MasterLocationModel>) {
        final entity = response.data!.toEntity();
        return DataSuccess(entity);
      } else {
        return DataFailed(response.error!);
      }
    } catch (e) {
      return DataFailed("Terjadi kesalahan: $e");
    }
  }
}
