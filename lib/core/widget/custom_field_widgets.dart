import 'package:flutter/material.dart';
import 'package:mobile_intern_pdam/core/widget/input_chip/editable_chip_field.dart';
import 'package:mobile_intern_pdam/core/widget/location_picker.dart';
import 'package:mobile_intern_pdam/feature/work_order/presentation/widgets/time_estimate.dart';

typedef CustomFieldBuilder =
    Widget Function(
      Map<String, dynamic> field,
      Map<String, dynamic> formData,
      Function(String, dynamic) onFieldChanged,
    );

class CustomFieldWidgets {
  static final Map<String, CustomFieldBuilder> fields = {
    "locationPicker": (field, formData, onFieldChanged) => LocationPicker(
      isStatic: true,
      isReadOnly: field["isReadOnly"] ?? false,
      latitude: formData["latitude"],
      longitude: formData["longitude"],
      onLocationSelected: (lat, long) {
        if (!(field["isReadOnly"] ?? false)) {
          onFieldChanged("latitude", lat);
          onFieldChanged("longitude", long);
        }
      },
    ),
    "timeEstimate": (field, formData, onFieldChanged) => TimeEstimate(
      isOvertime: field["isOvertime"] ?? false, // ✅ Ambil dari formData
      isReadOnly: field["isReadOnly"] ?? false,
      status: field["status"],
      startDateTime: formData["startDateTime"], // ✅ Data awal
      duration: formData["duration"], // ✅ Data awal
      durationUnit: formData["durationUnit"], // ✅ Data awal
      endDateTime: formData["endDateTime"], // ✅ Data awal
      onChanged: (startDateTime, duration, durationUnit, endDateTime) {
        if (!(field["isReadOnly"] ?? false)) {
          onFieldChanged("startDateTime", startDateTime);
          onFieldChanged("duration", duration);
          onFieldChanged("durationUnit", durationUnit);
          onFieldChanged("endDateTime", endDateTime);
        }
      },
    ),
    // "estimateEditor": (field, formData, onFieldChanged) => EstimateEditor(),
    "assignees": (field, formData, onFieldChanged) => EditableChipField(
      isReadOnly: field["isReadOnly"] ?? false,
      userList: field["options"] ?? [],
      initialSelectedUsers: formData["assignees"] ?? [], // ✅ Data awal
      onChanged: (selectedUsers) {
        onFieldChanged("assignees", selectedUsers); // ✅ Update formData
      },
      key: ValueKey(formData["assignees"]), // 🔹 Supaya UI ter-refresh
    ),

    "assignee": (field, formData, onFieldChanged) => EditableChipField(
      isReadOnly: field["isReadOnly"] ?? false,
      userList: field["options"] ?? [],
      initialSelectedUsers: formData["assignee"] ?? [], // ✅ Data awal
      onChanged: (selectedUsers) {
        onFieldChanged("assignee", selectedUsers); // ✅ Update formData
      },
      key: ValueKey(formData["assignee"]), // 🔹 Supaya UI ter-refresh
    ),
  };
}
