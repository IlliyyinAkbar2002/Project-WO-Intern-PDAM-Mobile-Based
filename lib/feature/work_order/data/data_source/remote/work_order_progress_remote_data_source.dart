import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_intern_pdam/core/resource/data_state.dart';
import 'package:mobile_intern_pdam/core/resource/remote_data_source.dart';
import 'package:mobile_intern_pdam/feature/work_order/data/models/work_order_progress_model.dart';

class WorkOrderProgressRemoteDataSource extends RemoteDatasource {
  WorkOrderProgressRemoteDataSource() : super();

  String basename(String path) => p.basename(path);

  Future<DataState<List<WorkOrderProgressModel>>> fetchProgressByWorkOrderId(
    int workOrderId,
  ) async {
    try {
      // Use parent class's get() method which includes auth headers
      final response = await get(
        path: '/v1/progress-workorder',
        queryParameters: {'workorder_id': workOrderId},
      );
      if (response.data is Map<String, dynamic>) {
        final progressModel = WorkOrderProgressModel.fromMap(response.data);
        return DataSuccess([progressModel]); // Bungkus dalam List
      } else {
        // Jika response.data adalah List (opsional, untuk fleksibilitas)
        final data = (response.data as List)
            .map<WorkOrderProgressModel>(
              (json) => WorkOrderProgressModel.fromMap(json),
            )
            .toList();
        return DataSuccess(data);
      }
    } catch (e) {
      return DataFailed(
        DioException(
          error: e,
          requestOptions: RequestOptions(path: '/v1/progress-workorder'),
        ),
      );
    }
  }

  Future<DataState<WorkOrderProgressModel>> getWorkOrderProgressDetail(
    int id,
  ) async {
    try {
      // Use parent class's get() method which includes auth headers
      final response = await get(path: '/v1/progress-workorder/$id');
      final data = WorkOrderProgressModel.fromMap(response.data);
      return DataSuccess(data);
    } catch (e) {
      return DataFailed(
        DioException(
          error: e,
          requestOptions: RequestOptions(path: '/v1/progress-workorder/$id'),
        ),
      );
    }
  }

  Future<DataState<WorkOrderProgressModel>> updateWorkOrderProgressDetail(
    WorkOrderProgressModel workOrderProgress,
  ) async {
    try {
      final formData = FormData();
      // final token = RemoteDatasource.authTokenGetter();
      // debugPrint("🔑 Token: $token");

      // Tambah fields
      formData.fields.addAll([
        const MapEntry('_method', 'PUT'),
        MapEntry('hasil_pengerjaan', workOrderProgress.description ?? ''),
        MapEntry(
          'waktu_submit',
          workOrderProgress.submitTime?.toIso8601String() ??
              DateTime.now().toUtc().toIso8601String(),
        ),
      ]);

      // Add photos to FormData
      debugPrint(
        "📸 photos runtimeType: ${workOrderProgress.photos.runtimeType}",
      );
      if (workOrderProgress.photos != null) {
        debugPrint("📸 First photo: ${workOrderProgress.photos!.first}");
      }
      if (workOrderProgress.photos != null &&
          workOrderProgress.photos!.isNotEmpty) {
        for (var photo in workOrderProgress.photos!) {
          try {
            final file = File(photo.path);
            if (await file.exists()) {
              debugPrint("📷 Adding file photos: ${photo.path}");
              formData.files.add(
                MapEntry(
                  'foto[]',
                  await MultipartFile.fromFile(
                    photo.path,
                    filename: basename(photo.path),
                  ),
                ),
              );
            } else {
              debugPrint("❌ File not found: ${photo.path}");
            }
          } catch (e) {
            debugPrint("❌ Error adding file ${photo.path}: $e");
          }
        }
      } else {
        debugPrint("⚠️ No photos provided");
      }

      if (workOrderProgress.progressDetails != null &&
          workOrderProgress.progressDetails!.isNotEmpty) {
        for (int i = 0; i < workOrderProgress.progressDetails!.length; i++) {
          final detailItem = workOrderProgress.progressDetails![i];

          // Pastikan detail_form_id ada untuk membentuk kunci
          if (detailItem.detailFormId == null) {
            debugPrint(
              "⚠️ Skipping detail_progress item at index $i due to null detailFormId.",
            );
            continue;
          }

          // Tambahkan detail_form_id untuk item saat ini
          formData.fields.add(
            MapEntry(
              'detail_progress[$i][detail_form_id]',
              detailItem.detailFormId.toString(), // Backend mengharapkan string
            ),
          );

          // Tentukan 'value' untuk payload
          String valueForPayload;
          if (detailItem.image != null) {
            // Jika ini adalah item gambar, backend mengharapkan value string kosong
            valueForPayload = "";
          } else {
            // Jika bukan item gambar, gunakan value dari model,
            // atau string kosong jika value di model adalah null.
            valueForPayload = detailItem.value ?? "";
          }
          formData.fields.add(
            MapEntry(
              'detail_progress[$i][value]',
              valueForPayload, // Ini sudah string
            ),
          );
        }
        debugPrint("📋 Detail Progress fields constructed in indexed format.");
      }

      if (workOrderProgress.progressDetails != null) {
        // Tambah detail_progress_images (single-image)
        for (var detail in workOrderProgress.progressDetails!) {
          if (detail.image != null && detail.detailFormId != null) {
            try {
              final file = File(detail.image!.path);
              if (await file.exists()) {
                debugPrint(
                  "🖼️ Adding image for form ${detail.detailFormId}: ${detail.image!.path}",
                );
                formData.files.add(
                  MapEntry(
                    'detail_progress_images[${detail.detailFormId}]',
                    await MultipartFile.fromFile(
                      detail.image!.path,
                      filename: basename(detail.image!.path),
                    ),
                  ),
                );
              } else {
                debugPrint("❌ Image file not found: ${detail.image!.path}");
              }
            } catch (e) {
              debugPrint("❌ Error adding image ${detail.image!.path}: $e");
            }
          }
        }
      } else {
        formData.fields.add(MapEntry('detail_progress', jsonEncode([])));
        debugPrint("⚠️ No progress details provided");
      }

      debugPrint("📤 Sending payload: ${formData.fields}");
      debugPrint(
        "📤 Sending files: ${formData.files.map((e) => e.key).toList()}",
      );

      // Use parent class's post() method which includes auth headers
      final response = await post(
        path: '/v1/progress-workorder/${workOrderProgress.id}',
        data: formData,
        contentType: ContentType.multipart,
      );

      final data = WorkOrderProgressModel.fromMap(response.data);
      return DataSuccess(data);
    } catch (e) {
      return DataFailed(
        DioException(
          error: e,
          requestOptions: RequestOptions(
            path: '/v1/progress-workorder/${workOrderProgress.id}',
          ),
        ),
      );
    }
  }
}
