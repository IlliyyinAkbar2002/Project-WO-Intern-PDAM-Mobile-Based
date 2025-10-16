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
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Card Section
          Transform.translate(
            offset: const Offset(0, -28),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _StatsCard(),
            ),
          ),
          const SizedBox(height: 8),

          // Role Selection Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _RoleSelectionCard(
              selectedPicId: selectedPicId,
              selectedUserId: selectedUserId,
              onPicIdChanged: onPicIdChanged,
              onUserIdChanged: onUserIdChanged,
            ),
          ),
          const SizedBox(height: 24),

          // Quick Access Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Quick Access',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: colors.foreground[900],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Navigation Grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _NavigationGrid(
              selectedPicId: selectedPicId,
              selectedUserId: selectedUserId,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
