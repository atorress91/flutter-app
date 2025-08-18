import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_app/core/providers/auth_providers.dart';

class ProfileInfoCard extends ConsumerWidget {
  const ProfileInfoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSession = ref.watch(authNotifierProvider);
    final user = asyncSession.value?.user; // UsersAffiliatesDto?

    final email = user?.email ?? '—';
    // UsersAffiliatesDto doesn't expose phone/address; show placeholders
    final phone = '—';
    final address = '—';
    final createdAt = user?.createdAt;
    final createdAtText = createdAt != null
        ? DateFormat.yMMMd('es_CR').add_jm().format(createdAt)
        : '—';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        children: [
          _buildInfoRow(
            context,
            Icons.phone_outlined,
            'Teléfono',
            phone,
          ),
          const Divider(),
          _buildInfoRow(
            context,
            Icons.location_on_outlined,
            'Dirección',
            address,
          ),
          const Divider(),
          _buildInfoRow(
            context,
            Icons.email_outlined,
            'Correo',
            email,
          ),
          const Divider(),
          _buildInfoRow(
            context,
            Icons.calendar_today_outlined,
            'Fecha Registro',
            createdAtText,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String title,
    String value,
  ) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 16),
          Text(title, style: textTheme.bodyMedium),
          const Spacer(),
          Expanded(
            flex: 2,
            child: Text(
              value,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
