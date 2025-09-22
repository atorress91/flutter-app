import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

String _shortenAddress(String address) {
  if (address.length < 12) return address;
  return '${address.substring(0, 6)}...${address.substring(address.length - 4)}';
}

class ContractDetails extends StatelessWidget {
  const ContractDetails({super.key});

  @override
  Widget build(BuildContext context) {
    const String fullContractAddress = '0x7c482FF834dfb546A8E48C14f3C34652E9826723';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow(
            context,
            title: 'Contrato',
            value: _shortenAddress(fullContractAddress),
            trailingIcon: Icons.copy_all_outlined,
            onCopy: () async {
              await Clipboard.setData(
                const ClipboardData(text: fullContractAddress),
              );
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Contrato copiado al portapapeles'),
                  ),
                );
              }
            },
          ),
          const Divider(),
          _buildDetailRow(context, title: 'Venta pública', value: '01-08-2026'),
          const Divider(),
          _buildDetailRow(context, title: 'Red', value: 'BNB Smart Chain'),
        ],
      ),
    );
  }
}

Widget _buildDetailRow(
  BuildContext context, {
  required String title,
  required String value,
  IconData? trailingIcon,
  VoidCallback? onCopy,
}) {
  final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);

  Widget rowContent = Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textTheme.bodyMedium?.copyWith(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withAlpha((255 * 0.7).toInt()),
          ),
        ),
        Row(
          children: [
            Text(
              value,
              style: textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (trailingIcon != null) ...[
              const SizedBox(width: 8),
              Icon(
                trailingIcon,
                size: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ],
        ),
      ],
    ),
  );

  if (onCopy != null) {
    return GestureDetector(onTap: onCopy, child: rowContent);
  }

  return rowContent;
}
