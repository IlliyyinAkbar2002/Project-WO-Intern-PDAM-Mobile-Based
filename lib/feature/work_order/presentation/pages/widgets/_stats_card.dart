part of '../landing_page.dart';

class _StatsCard extends StatelessWidget {
  const _StatsCard();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColor>()!;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 147,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1E293B), // slate-900
            const Color(0xFF0F172A), // slate-950
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative pattern
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: CustomPaint(painter: _DecorativePatternPainter()),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'WORK ORDERS',
                        style: textTheme.headlineLarge?.copyWith(
                          color: const Color(0xFF67E8F9), // cyan-300
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'AKTIF HARI INI',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colors.background[100]!.withOpacity(0.7),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Opacity(
                  opacity: 0.3,
                  child: Icon(
                    Icons.assignment_outlined,
                    size: 80,
                    color: colors.background[100],
                  ),
                ),
              ],
            ),
          ),
          // Small decorative icons
          Positioned(
            top: 16,
            right: 20,
            child: Opacity(
              opacity: 0.6,
              child: Icon(
                Icons.trending_up,
                size: 20,
                color: colors.background[100],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DecorativePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Draw some decorative lines
    final path = Path();
    path.moveTo(size.width * 0.7, 0);
    path.lineTo(size.width, size.height * 0.3);

    path.moveTo(size.width * 0.8, 0);
    path.lineTo(size.width, size.height * 0.5);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
