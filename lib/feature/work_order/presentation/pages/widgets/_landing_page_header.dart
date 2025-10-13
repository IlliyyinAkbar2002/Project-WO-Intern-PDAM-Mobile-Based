part of '../landing_page.dart';

class _LandingPageHeader extends StatelessWidget {
  const _LandingPageHeader();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColor>()!;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colors.primary[500]!, colors.primary[700]!],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: colors.background[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.water_drop,
                  color: colors.primary[500],
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PDAM Surya Sembada',
                      style: textTheme.titleLarge?.copyWith(
                        color: colors.background[100],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Work Order Management',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colors.background[100]!.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_outlined,
                  color: colors.background[100],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Selamat Datang',
            style: textTheme.headlineLarge?.copyWith(
              color: colors.background[100],
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Pilih peran Anda untuk melanjutkan',
            style: textTheme.bodyMedium?.copyWith(
              color: colors.background[100]!.withOpacity(0.85),
            ),
          ),
        ],
      ),
    );
  }
}
