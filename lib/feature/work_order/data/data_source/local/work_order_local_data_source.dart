import 'package:postgres/postgres.dart';
import '/core/resource/data_state.dart';
import '/core/resource/local_data_source.dart';
import '/feature/work_order/data/models/work_order_model.dart';

class WorkOrderLocalDataSource extends LocalDataSource<WorkOrderModel> {
  final Connection database;

  WorkOrderLocalDataSource(this.database);

  @override
  Future<DataState<List<WorkOrderModel>>> fetchAll() async {
    try {
      final result = await database.execute('SELECT * FROM work_orders');
      print("📂 Data dari database lokal: $result"); // ✅ Log isi database

      final data = result.map((row) {
        final map = row.toColumnMap();
        return WorkOrderModel.fromMap(map);
      }).toList();

      print("✅ Work Order ditemukan: ${data.length}");
      return DataSuccess(data);
    } catch (e) {
      print("❌ Gagal mengambil data dari database: $e");
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<WorkOrderModel>> fetchById(int id) async {
    try {
      final result = await database.execute(
        Sql.named('SELECT * FROM work_orders WHERE id = @id'),
        parameters: {'id': id},
      );

      if (result.isNotEmpty) {
        final map = result.first.toColumnMap();
        return DataSuccess(WorkOrderModel.fromMap(map));
      } else {
        return const DataFailed('WorkOrder not found');
      }
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<void>> create(WorkOrderModel workOrder) async {
    try {
      final data = workOrder.toMap();

      await database.execute(
        Sql.named('''
          INSERT INTO work_orders (
            title, startDateTime, duration, durationUnit, endDateTime,
            latitude, longitude, creator, statusId, workOrderTypeId,
            locationTypeId, requiresApproval
          ) VALUES (
            @title, @startDateTime, @duration, @durationUnit, @endDateTime,
            @latitude, @longitude, @creator, @statusId, @workOrderTypeId,
            @locationTypeId, @requiresApproval
          )
        '''),
        parameters: {
          'title': data['judul_pekerjaan'],
          'startDateTime': data['waktu_penugasan'],
          'duration': data['estimasi_durasi'],
          'durationUnit': data['unit_waktu'],
          'endDateTime': data['estimasi_selesai'],
          'latitude': data['latitude'],
          'longitude': data['longitude'],
          'creator': data['pic_id'],
          'statusId': data['status_id'],
          'workOrderTypeId': data['jenis_workorder_id'],
          'locationTypeId': data['jenis_lokasi_id'],
          'requiresApproval': data['tipe_workorder_id'] == 2 ? 1 : 0,
        },
      );

      print("✅ Work Order berhasil disimpan: ${workOrder.toMap()}");
      return const DataSuccess(null);
    } catch (e) {
      print("❌ Gagal menyimpan Work Order: $e");
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<void>> update(WorkOrderModel workOrder) async {
    try {
      final data = workOrder.toMap();

      await database.execute(
        Sql.named('''
          UPDATE work_orders SET
            title = @title,
            startDateTime = @startDateTime,
            duration = @duration,
            durationUnit = @durationUnit,
            endDateTime = @endDateTime,
            latitude = @latitude,
            longitude = @longitude,
            creator = @creator,
            statusId = @statusId,
            workOrderTypeId = @workOrderTypeId,
            locationTypeId = @locationTypeId,
            requiresApproval = @requiresApproval
          WHERE id = @id
        '''),
        parameters: {
          'id': workOrder.id,
          'title': data['judul_pekerjaan'],
          'startDateTime': data['waktu_penugasan'],
          'duration': data['estimasi_durasi'],
          'durationUnit': data['unit_waktu'],
          'endDateTime': data['estimasi_selesai'],
          'latitude': data['latitude'],
          'longitude': data['longitude'],
          'creator': data['pic_id'],
          'statusId': data['status_id'],
          'workOrderTypeId': data['jenis_workorder_id'],
          'locationTypeId': data['jenis_lokasi_id'],
          'requiresApproval': data['tipe_workorder_id'] == 2 ? 1 : 0,
        },
      );

      return const DataSuccess(null);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<void>> delete(int id) async {
    try {
      await database.execute(
        Sql.named('DELETE FROM work_orders WHERE id = @id'),
        parameters: {'id': id},
      );
      return const DataSuccess(null);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
