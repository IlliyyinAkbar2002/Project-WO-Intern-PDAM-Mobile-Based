part of '../landing_page.dart';

class _RoleSelector extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final int? selectedId;
  final List<int> idList;
  final ValueChanged<int?> onIdChanged;
  final String dropdownLabel;
  final String buttonLabel;
  final List<Color> gradientColors;
  final VoidCallback onNavigate;

  const _RoleSelector({
    required this.title,
    required this.description,
    required this.icon,
    required this.selectedId,
    required this.idList,
    required this.onIdChanged,
    required this.dropdownLabel,
    required this.buttonLabel,
    required this.gradientColors,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColor>()!;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.background[100],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colors.foreground[200]!.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: gradientColors,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: colors.background[100], size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colors.foreground[900],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: textTheme.bodySmall?.copyWith(
                        color: colors.foreground[400],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<int>(
            value: selectedId,
            decoration: InputDecoration(
              labelText: dropdownLabel,
              prefixIcon: Icon(
                Icons.person_outline,
                color: colors.primary[500],
                size: 20,
              ),
            ),
            items: idList
                .map(
                  (id) => DropdownMenuItem(value: id, child: Text('ID: $id')),
                )
                .toList(),
            onChanged: onIdChanged,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: onNavigate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradientColors),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    buttonLabel,
                    style: textTheme.titleMedium?.copyWith(
                      color: colors.background[100],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
