part of '../landing_page.dart';

class _LandingPageBody extends StatelessWidget {
  final int? selectedPicId;
  final int? selectedUserId;
  final ValueChanged<int?> onPicIdChanged;
  final ValueChanged<int?> onUserIdChanged;

  const _LandingPageBody({
    required this.selectedPicId,
    required this.selectedUserId,
    required this.onPicIdChanged,
    required this.onUserIdChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColor>()!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _RoleSelector(
            title: 'Pengajuan Work Order',
            description: 'Untuk membuat dan mengelola work order',
            icon: Icons.assignment_outlined,
            selectedId: selectedPicId,
            idList: [1, 2, 3],
            onIdChanged: onPicIdChanged,
            dropdownLabel: 'Pilih PIC ID',
            buttonLabel: 'Buka Pengajuan',
            gradientColors: [colors.primary[500]!, colors.primary[600]!],
            onNavigate: () {
              if (selectedPicId == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Silakan pilih PIC ID terlebih dahulu'),
                    backgroundColor: colors.warning,
                  ),
                );
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AssignerWorkOrderPage(picId: selectedPicId!),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          _RoleSelector(
            title: 'Penugasan Work Order',
            description: 'Untuk melihat dan menyelesaikan tugas',
            icon: Icons.task_alt_outlined,
            selectedId: selectedUserId,
            idList: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
            onIdChanged: onUserIdChanged,
            dropdownLabel: 'Pilih User ID',
            buttonLabel: 'Buka Penugasan',
            gradientColors: [colors.status[7]!, colors.status[8]!],
            onNavigate: () {
              if (selectedUserId == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'Silakan pilih User ID terlebih dahulu',
                    ),
                    backgroundColor: colors.warning,
                  ),
                );
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AssigneeWorkOrderPage(userId: selectedUserId!),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
