import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_intern_pdam/core/widget/app_state_page.dart';
import 'package:mobile_intern_pdam/core/widget/custom_form.dart';

class TimeEstimate extends StatefulWidget {
  final bool isOvertime;
  final bool isReadOnly;
  final Function(DateTime?, int?, String?, DateTime?) onChanged;
  final DateTime? startDateTime;
  final int? duration;
  final String? durationUnit;
  final DateTime? endDateTime;
  final int? status;

  const TimeEstimate({
    super.key,
    required this.isOvertime,
    this.isReadOnly = false,
    required this.onChanged,
    this.startDateTime,
    this.duration,
    this.durationUnit,
    this.endDateTime,
    this.status,
  });

  @override
  State<TimeEstimate> createState() => _TimeEstimateState();
}

class _TimeEstimateState extends AppStatePage<TimeEstimate> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _durationTypeController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateTime? endDateTime;
  int _duration = 0;
  String _selectedDurationType = '';
  final List<String> normalDurationOptions = ['Jam', 'Hari', 'Bulan'];

  @override
  void initState() {
    super.initState();
    _updateDurationType();
    _initialValue();
  }

  @override
  void didUpdateWidget(TimeEstimate oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOvertime != oldWidget.isOvertime) {
      _updateDurationType();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (selectedTime != null) {
      _timeController.text = selectedTime!.format(
        context,
      ); // ✅ Pindahkan ke sini
    }
  }

  void _initialValue() {
    selectedDate = widget.startDateTime;
    selectedTime = widget.startDateTime != null
        ? TimeOfDay.fromDateTime(widget.startDateTime!)
        : null;

    _duration = widget.duration ?? 0;
    _selectedDurationType =
        widget.durationUnit ?? (widget.isOvertime ? "Jam" : "");
    endDateTime = widget.endDateTime;

    _dateController.text = selectedDate != null
        ? DateFormat('yyyy-MM-dd').format(selectedDate!)
        : '';
    _durationController.text = _duration > 0 ? _duration.toString() : '';
    _durationTypeController.text = _selectedDurationType;
  }

  void _updateDurationType() {
    setState(() {
      _selectedDurationType = widget.isOvertime ? 'Jam' : '';
      _durationTypeController.text = _selectedDurationType; // Update text field
    });
  }

  @override
  Widget buildPage(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color.foreground[400]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Estimasi Waktu WO",
                style: textTheme.headlineLarge?.copyWith(
                  color: color.primary[500],
                ),
              ),
              Row(
                children: [
                  // Pilih Tanggal
                  SizedBox(
                    width: 50,
                    child: Text("Mulai", style: textTheme.titleMedium),
                  ),

                  Expanded(
                    child: CustomForm(
                      controller: _dateController,
                      hintText: 'Pilih Tanggal',
                      labelText: "",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tanggal tidak boleh kosong';
                        }
                        return null;
                      },
                      readOnly: true,
                      onTap: (widget.isReadOnly)
                          ? null
                          : () {
                              _selectDate();
                            },
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Pilih Jam
                  Expanded(
                    child: CustomForm(
                      controller: _timeController,
                      hintText: 'Pilih Jam',
                      labelText: "",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Jam tidak boleh kosong';
                        }
                        return null;
                      },
                      readOnly: true,
                      onTap: (widget.isReadOnly)
                          ? null
                          : () {
                              _selectTime();
                            },
                    ),
                  ),
                ],
              ),

              // Durasi
              Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Text("Durasi", style: textTheme.titleMedium),
                  ),

                  // Input angka durasi
                  Expanded(
                    child: CustomForm(
                      controller: _durationController,
                      hintText: 'Durasi',
                      labelText: "",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Durasi tidak boleh kosong';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        _duration = int.tryParse(value) ?? 0;
                        _calculateEndDateTime();
                      },
                      readOnly: widget.isReadOnly,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: widget.isOvertime
                        ? CustomForm(
                            controller: _durationTypeController,
                            hintText: 'Jam',
                            labelText: '',
                            enabled: false,
                          )
                        : CustomForm(
                            controller: _durationTypeController,
                            hintText: 'J/H/B',
                            labelText: '',
                            inputType: (widget.isReadOnly)
                                ? InputType.text
                                : InputType.dropdown,
                            readOnly: widget.isReadOnly,
                            dropdownItems: normalDurationOptions
                                .map(
                                  (duration) => DropdownMenuItem(
                                    value: duration,
                                    child: Text(duration),
                                  ),
                                )
                                .toList(),
                            dropdownValue: _selectedDurationType.isNotEmpty
                                ? _selectedDurationType
                                : null,
                            onDropdownChanged: (value) {
                              setState(() {
                                _selectedDurationType = value!;
                                _calculateEndDateTime();
                              });
                            },
                          ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Selesai", style: textTheme.titleMedium),
                  Text(
                    (endDateTime != null &&
                            _duration != 0 &&
                            _selectedDurationType.isNotEmpty)
                        ? _formatEndDateTime(endDateTime!)
                        : "-",
                    style: textTheme.titleMedium,
                  ), //dihitung dari tanggal mulai + durasi
                ],
              ),
            ],
          ),
        ),
        // !widget.isReadOnly ? const SizedBox() : _buildButton(),
        // Text("${widget.status}")
      ],
    );
  }

  Widget _buildButton() {
    switch (widget.status) {
      case 1:
        return ElevatedButton(
          onPressed: () {},
          child: const Text('Belum disetujui'),
        );
      case 2:
        return const Text('Disetujui');
      case 3:
        return const Text('Revisi');
      case 4:
        return const Text('Ditolak');
      case 5:
        return const Text('Pengecekan');
      case 6:
        return const Text('Selesai');
      case 7:
        return const Text('In Progress');
      case 8:
        return const Text('Freeze');
      default:
        return const Text('Ajukan');
    }
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 10),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        _dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
        _calculateEndDateTime();
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
        _timeController.text = pickedTime.format(context);
        _calculateEndDateTime();
      });
    }
  }

  void _calculateEndDateTime() {
    if (selectedDate != null && selectedTime != null) {
      DateTime startDateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );

      DateTime calculatedEndDateTime;
      int durationValue = int.tryParse(_durationController.text) ?? 0;

      if (_selectedDurationType == 'Jam') {
        calculatedEndDateTime = startDateTime.add(
          Duration(hours: durationValue),
        );
      } else if (_selectedDurationType == 'Hari') {
        calculatedEndDateTime = startDateTime.add(
          Duration(days: durationValue),
        );
      } else if (_selectedDurationType == 'Bulan') {
        calculatedEndDateTime = DateTime(
          startDateTime.year,
          startDateTime.month + durationValue, // ✅ Tambahkan bulan langsung
          startDateTime.day,
          startDateTime.hour,
          startDateTime.minute,
        );
      } else {
        calculatedEndDateTime =
            startDateTime; // Jika unit tidak dikenal, biarkan tetap sama
      }

      setState(() {
        endDateTime = calculatedEndDateTime;
      });

      widget.onChanged(
        startDateTime,
        durationValue,
        _selectedDurationType,
        endDateTime,
      );
    }
  }

  String _formatEndDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('EEEE, dd MMMM yyyy HH:mm \'WIB\'');
    return formatter.format(dateTime);
  }
}
