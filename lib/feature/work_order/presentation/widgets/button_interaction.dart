import 'package:flutter/material.dart';
import 'package:mobile_intern_pdam/core/widget/app_state_page.dart';

class ButtonInteraction extends StatefulWidget {
  final int? status;
  final Function(String)? onPressed;
  final VoidCallback? onDefaultPressed;
  final bool isDisabled;

  const ButtonInteraction({
    super.key,
    this.status,
    this.onPressed,
    this.onDefaultPressed,
    this.isDisabled = false,
  });

  @override
  State<ButtonInteraction> createState() => _ButtonInteractionState();
}

class _ButtonInteractionState extends AppStatePage<ButtonInteraction> {
  @override
  Widget buildPage(BuildContext context) {
    return widget.onPressed != null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: color.danger),
                onPressed: () => _showConfirmationDialog(),
                child: const Text('Tolak'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: color.status[2],
                ),
                onPressed: () => widget.onPressed?.call('Accept'),
                child: const Text('Terima'),
              ),
            ],
          )
        : ElevatedButton(
            onPressed: widget.isDisabled ? null : widget.onDefaultPressed,
            child: _buttonText(),
          );
  }

  Widget _buttonText() {
    switch (widget.status) {
      case 1:
        return const Text('Belum disetujui');
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

  void _showConfirmationDialog() {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Apakah Anda yakin ingin melanjutkan aksi ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                widget.onPressed?.call('Reject');
                Navigator.of(context).pop(true);
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }
}
