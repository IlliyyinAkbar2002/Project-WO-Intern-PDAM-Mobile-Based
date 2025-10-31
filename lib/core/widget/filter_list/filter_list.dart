import 'package:flutter/material.dart';
import 'package:mobile_intern_pdam/core/widget/app_state_page.dart';
import 'package:mobile_intern_pdam/core/resource/data_state.dart';
import 'package:mobile_intern_pdam/feature/work_order/data/data_source/remote/user_remote_data_source.dart';
import 'package:mobile_intern_pdam/feature/work_order/data/models/user_model.dart';

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
      child: GestureDetector(
        onTap: () => _showOfficerSearchBottomSheet(),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFE9EFF6),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedAssignee ?? 'Cari nama petugas...',
                style: TextStyle(
                  fontSize: 16,
                  color: selectedAssignee != null
                      ? Colors.black
                      : Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showOfficerSearchBottomSheet() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          OfficerSearchSheet(selectedOfficer: selectedAssignee),
    );

    if (result != null) {
      setState(() {
        selectedAssignee = result;
      });
    }
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

/// Officer Search Bottom Sheet Widget
/// This bottom sheet allows users to search and select an officer from a list
class OfficerSearchSheet extends StatefulWidget {
  final String? selectedOfficer;

  const OfficerSearchSheet({super.key, this.selectedOfficer});

  @override
  State<OfficerSearchSheet> createState() => _OfficerSearchSheetState();
}

class _OfficerSearchSheetState extends State<OfficerSearchSheet> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<UserModel> _allOfficers = [];
  List<UserModel> _filteredOfficers = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchOfficers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchOfficers() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final dataSource = UserRemoteDataSource();
      final result = await dataSource.fetchUsers();

      if (result is DataSuccess<List<UserModel>>) {
        setState(() {
          _allOfficers = result.data ?? [];
          _filteredOfficers = _allOfficers;
          _isLoading = false;
        });
      } else if (result is DataFailed) {
        setState(() {
          _errorMessage = 'Gagal memuat data petugas';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Terjadi kesalahan: $e';
        _isLoading = false;
      });
    }
  }

  void _filterOfficers(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredOfficers = _allOfficers;
      } else {
        _filteredOfficers = _allOfficers.where((officer) {
          final name = officer.employee?.name?.toLowerCase() ?? '';
          final nip = officer.employee?.nip?.toLowerCase() ?? '';
          final searchLower = query.toLowerCase();
          return name.contains(searchLower) || nip.contains(searchLower);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Navigation Bar
          _buildNavigationBar(),

          // Search TextField
          _buildSearchField(),

          const SizedBox(height: 16),

          // Divider
          Container(height: 1, color: const Color(0xFFECEDF0)),

          // List View (Empty for now - ready for API data)
          Expanded(child: _buildOfficerList()),
        ],
      ),
    );
  }

  Widget _buildNavigationBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Cancel Button
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(60, 40),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D499B),
              ),
            ),
          ),

          // Title
          const Text(
            'Pilih Petugas',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Color(0xFF31373D),
            ),
          ),

          // Empty space for symmetry
          const SizedBox(width: 60),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (value) {
            _filterOfficers(value);
          },
          decoration: InputDecoration(
            hintText: 'Cari nama petugas...',
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey.shade600,
              size: 22,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _searchQuery = '';
                      });
                    },
                  )
                : null,
          ),
        ),
      ),
    );
  }

  Widget _buildOfficerList() {
    // Show loading indicator
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF2D499B)),
      );
    }

    // Show error message
    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red.shade400),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchOfficers,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D499B),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text(
                'Coba Lagi',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }

    // Show empty state when no officers found
    if (_filteredOfficers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              _searchQuery.isEmpty
                  ? 'Tidak ada data petugas'
                  : 'Tidak ditemukan petugas',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _searchQuery.isEmpty
                  ? 'Data petugas masih kosong'
                  : 'Coba kata kunci lain',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            ),
          ],
        ),
      );
    }

    // Show list of officers
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: _filteredOfficers.length,
      itemBuilder: (context, index) {
        final officer = _filteredOfficers[index];
        final employee = officer.employee;
        final name = employee?.name ?? 'Nama tidak tersedia';
        final nip = employee?.nip ?? '-';

        return InkWell(
          onTap: () {
            // Return the selected officer name to the caller
            Navigator.pop(context, name);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
            ),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D499B).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      name.isNotEmpty ? name[0].toUpperCase() : '?',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D499B),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Name and NIP
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF31373D),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'NIP: $nip',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                // Checkmark for selected officer
                if (widget.selectedOfficer == name)
                  const Icon(
                    Icons.check_circle,
                    color: Color(0xFF2D499B),
                    size: 24,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
