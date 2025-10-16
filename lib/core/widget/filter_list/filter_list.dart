import 'package:flutter/material.dart';
import 'package:mobile_intern_pdam/core/widget/app_state_page.dart';

class CustomFilterDialog extends StatefulWidget {
  const CustomFilterDialog({super.key});

  @override
  State<CustomFilterDialog> createState() => _CustomFilterDialogState();
}

class _CustomFilterDialogState extends AppStatePage<CustomFilterDialog> {
  String? selectedWorkOrderType;
  String? selectedStatus;
  String? selectedAssignee;
  DateTime? startDate;
  DateTime? endDate;
  String? selectedQuickDate;

  int _getFilterCount() {
    int count = 0;
    if (selectedWorkOrderType != null) count++;
    if (selectedStatus != null) count++;
    if (selectedAssignee != null && selectedAssignee!.isNotEmpty) count++;
    if (startDate != null || endDate != null || selectedQuickDate != null) {
      count++;
    }
    return count;
  }

  void _resetAllFilters() {
    setState(() {
      selectedWorkOrderType = null;
      selectedAssignee = null;
      selectedStatus = null;
      startDate = null;
      endDate = null;
      selectedQuickDate = null;
    });
  }

  @override
  Widget buildPage(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22.5, vertical: 13.5),
      height: MediaQuery.of(context).size.height * 0.95,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
        boxShadow: [
          BoxShadow(
            color: Color(0x0F878787),
            blurRadius: 32.74,
            offset: Offset(0, -117.43),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 34,
              height: 4.5,
              decoration: BoxDecoration(
                color: const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 27),
          const Text(
            'Filter by:',
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w400,
              color: Color(0xFF555E67),
            ),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWorkOrderTypeFilter(),
                  _buildDivider(),
                  _buildAssigneeFilter(),
                  _buildDivider(),
                  _buildStatusFilter(),
                  _buildDivider(),
                  _buildDateFilter(),
                  _buildDivider(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          _buildActionButtons(),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      width: double.infinity,
      color: const Color(0xFFECEDF0),
      margin: const EdgeInsets.symmetric(vertical: 18),
    );
  }

  Widget _buildWorkOrderTypeFilter() {
    return _buildSection(
      title: 'Pilih Work Order',
      onReset: () {
        setState(() => selectedWorkOrderType = null);
      },
      child: Row(
        children: [
          Expanded(
            child: _filterButton(
              'Normal',
              selectedWorkOrderType == 'Normal',
              () {
                setState(() => selectedWorkOrderType = 'Normal');
              },
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: _filterButton(
              'Lembur',
              selectedWorkOrderType == 'Lembur',
              () {
                setState(() => selectedWorkOrderType = 'Lembur');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssigneeFilter() {
    return _buildSection(
      title: 'Nama Petugas',
      onReset: () {
        setState(() => selectedAssignee = null);
      },
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFFE9EFF6),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          decoration: const InputDecoration(
            hintText: 'Cari nama petugas...',
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            suffixIcon: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black,
              size: 20,
            ),
          ),
          onChanged: (value) => setState(() => selectedAssignee = value),
        ),
      ),
    );
  }

  Widget _buildStatusFilter() {
    return _buildSection(
      title: 'Status',
      onReset: () {
        setState(() => selectedStatus = null);
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _filterButton(
              'Belum\ndisetujui',
              selectedStatus == 'Belum disetujui',
              () {
                setState(() => selectedStatus = 'Belum disetujui');
              },
            ),
            const SizedBox(width: 11),
            _filterButton('Disetujui', selectedStatus == 'Disetujui', () {
              setState(() => selectedStatus = 'Disetujui');
            }),
            const SizedBox(width: 11),
            _filterButton('Revisi', selectedStatus == 'Revisi', () {
              setState(() => selectedStatus = 'Revisi');
            }),
            const SizedBox(width: 11),
            _filterButton('Ditolak', selectedStatus == 'Ditolak', () {
              setState(() => selectedStatus = 'Ditolak');
            }),
            const SizedBox(width: 11),
            _filterButton('Selesai', selectedStatus == 'Selesai', () {
              setState(() => selectedStatus = 'Selesai');
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildDateFilter() {
    return _buildSection(
      title: 'Tanggal',
      onReset: () {
        setState(() {
          startDate = null;
          endDate = null;
          selectedQuickDate = null;
        });
      },
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dari',
                      style: TextStyle(
                        fontSize: 13.5,
                        color: Color(0xFF555E67),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 11),
                    _datePickerButton(
                      'Dari',
                      startDate,
                      (date) => setState(() => startDate = date),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sampai',
                      style: TextStyle(
                        fontSize: 13.5,
                        color: Color(0xFF555E67),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 11),
                    _datePickerButton(
                      'Sampai',
                      endDate,
                      (date) => setState(() => endDate = date),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 11),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _quickDateButton('Hari Ini'),
                const SizedBox(width: 11),
                _quickDateButton('Minggu Ini'),
                const SizedBox(width: 11),
                _quickDateButton('Bulan Ini'),
                const SizedBox(width: 11),
                _quickDateButton('3 Bulan'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    final filterCount = _getFilterCount();
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: _resetAllFilters,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF3F0FF),
              foregroundColor: const Color(0xFF2D499B),
              padding: const EdgeInsets.symmetric(vertical: 16.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.5),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Atur Ulang',
              style: TextStyle(
                fontSize: 15.8,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D499B),
              ),
            ),
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context, {
              'workOrderType': selectedWorkOrderType,
              'assignee': selectedAssignee,
              'status': selectedStatus,
              'startDate': startDate,
              'endDate': endDate,
              'quickDate': selectedQuickDate,
            }),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2D499B),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.5),
              ),
              elevation: 0,
            ),
            child: Text(
              filterCount > 0 ? 'Terapkan($filterCount)' : 'Terapkan',
              style: const TextStyle(
                fontSize: 15.8,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required Widget child,
    VoidCallback? onReset,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15.8,
                fontWeight: FontWeight.bold,
                color: Color(0xFF31373D),
              ),
            ),
            if (onReset != null)
              GestureDetector(
                onTap: onReset,
                child: const Text(
                  'Atur Ulang',
                  style: TextStyle(
                    fontSize: 15.8,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D499B),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 18),
        child,
      ],
    );
  }

  Widget _filterButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5.5),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFD0E8FA) : Colors.white,
          borderRadius: BorderRadius.circular(13.5),
          border: Border.all(color: const Color(0xFFECEDF0), width: 1.13),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.bold,
              color: Color(0xFF555E67),
            ),
          ),
        ),
      ),
    );
  }

  Widget _datePickerButton(
    String label,
    DateTime? date,
    Function(DateTime) onDateSelected,
  ) {
    String formatDate(DateTime date) {
      return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
    }

    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: date ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          onDateSelected(pickedDate);
        }
      },
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(13.5),
          border: Border.all(color: const Color(0xFFECEDF0), width: 1.13),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: Text(
                  date == null ? '' : formatDate(date),
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF555E67),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.5),
              padding: const EdgeInsets.all(13.5),
              decoration: BoxDecoration(
                color: const Color(0xFFEFEFEF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.calendar_today,
                size: 14.5,
                color: Color(0xFF555E67),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quickDateButton(String text) {
    final isSelected = selectedQuickDate == text;
    return GestureDetector(
      onTap: () {
        setState(() => selectedQuickDate = text);
      },
      child: Container(
        height: 54,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5.5),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFD0E8FA) : Colors.white,
          borderRadius: BorderRadius.circular(13.5),
          border: Border.all(color: const Color(0xFFECEDF0), width: 1.13),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.bold,
              color: Color(0xFF555E67),
            ),
          ),
        ),
      ),
    );
  }
}
