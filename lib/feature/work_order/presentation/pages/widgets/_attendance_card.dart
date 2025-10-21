part of '../landing_page.dart';

class _AttendanceCard extends StatelessWidget {
  const _AttendanceCard();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFEFCE8), // yellow-50
        border: Border.all(
          color: const Color(0xFFFDE68A), // yellow-200
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(21),
      child: Row(
        children: [
          // Left side - Check-in/Check-out info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Check-in time
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 4,
                  children: [
                    Text(
                      'Check-in time:',
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF374151), // gray-700
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '31/12/2024',
                      style: textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF374151), // gray-700
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '07:30',
                  style: textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF374151), // gray-700
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),

                // Check-out time
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 4,
                  children: [
                    Text(
                      'Check-out time:',
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF374151), // gray-700
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '-',
                      style: textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF374151), // gray-700
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // View history link
                InkWell(
                  onTap: () {
                    // TODO: Navigate to attendance history
                  },
                  child: Text(
                    'View daily attendance history >',
                    style: textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF2563EB), // blue-600
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Right side - Clock In button
          SizedBox(
            width: 118,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Handle clock in
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB), // blue-600
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                'Clock In',
                style: textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
