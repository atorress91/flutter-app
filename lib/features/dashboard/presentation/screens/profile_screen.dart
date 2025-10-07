import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/core/l10n/app_localizations.dart';
import 'package:my_app/core/utils/date_formatter.dart';
import 'package:my_app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:my_app/features/dashboard/presentation/controllers/profile_screen_controller.dart';
import 'package:my_app/features/dashboard/presentation/widgets/profile/profile_header.dart';
import 'package:my_app/features/dashboard/presentation/widgets/profile/profile_info_card.dart';
import 'package:my_app/features/dashboard/presentation/widgets/sidebar/sidebar_navigation.dart';

class ProfileScreen extends ConsumerWidget {
  final VoidCallback? onRequestClose;

  const ProfileScreen({super.key, this.onRequestClose});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final asyncSession = ref.watch(authNotifierProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.profileTitle,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        foregroundColor: colorScheme.onSurface,
      ),
      backgroundColor: colorScheme.surface,
      body: asyncSession.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stackTrace) =>
            Center(child: Text('${l10n.profileErrorOccurred}: $err')),
        data: (session) {
          final user = session?.user;

          if (user == null) {
            return Center(
              child: Text(l10n.profileNoUserDataFound),
            );
          }

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                children: [
                  ProfileHeader(
                    onAvatarTap: () => _updateAvatar(context, ref),
                    onEditIconTap: () => _updateAvatar(context, ref),
                  ),
                  const SizedBox(height: 32),
                  ProfileInfoCard(
                    title: l10n.profileMainDataTitle,
                    icon: Icons.person_outline,
                    info: {
                      l10n.profileUserLabel: user.userName,
                      l10n.profileEmailLabel: user.email,
                      l10n.profileIdentificationLabel: user.identification,
                      l10n.profileRegistrationDateLabel: DateFormatter.ddMMyyyy(
                        user.createdAt,
                      ),
                      l10n.profileBirthDateLabel: user.birthDay != null
                          ? DateFormatter.ddMMyyyy(user.birthDay)
                          : l10n.profileNotSpecified,
                    },
                  ),
                  const SizedBox(height: 16),

                  ProfileInfoCard(
                    title: l10n.profileSecondaryDataTitle,
                    icon: Icons.location_on_outlined,
                    info: {
                      l10n.profileNameLabel: user.name ?? '',
                      l10n.profileLastNameLabel: user.lastName ?? '',
                      l10n.profileAddressLabel: user.address ?? '',
                      l10n.profilePhoneLabel: user.phone ?? '',
                    },
                  ),
                  const SizedBox(height: 16),

                  ProfileInfoCard(
                    title: l10n.profileAdditionalDataTitle,
                    icon: Icons.favorite_border,
                    info: {
                      l10n.profileBeneficiaryNameLabel: user.beneficiaryName ?? '',
                      l10n.profileBeneficiaryEmailLabel: user.beneficiaryEmail ?? '',
                      l10n.profileBeneficiaryPhoneLabel: user.beneficiaryPhone ?? '',
                    },
                  ),

                  const SizedBox(height: 32),
                  _buildActionButtons(context, ref),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _updateAvatar(BuildContext context, WidgetRef ref) async {
    final profileController = ref.read(profileScreenControllerProvider);
    final l10n = AppLocalizations.of(context);

    try {
      final success = await profileController.updateProfilePicture();

      if (success && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.profilePhotoUpdated)),
        );
      }
    } catch (e) {
      if (context.mounted) {
        final errorMessage = '${l10n.profileErrorOccurred}: $e';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    }
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            icon: const Icon(Icons.edit_outlined),
            label: Text(l10n.profileEditButton),
            onPressed: () {
              context.goNamed('edit-profile');
            },
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: TextButton.icon(
            icon: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.error,
            ),
            label: Text(
              l10n.profileLogoutButton,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            onPressed: () => SidebarNavigation.navigate(
              context,
              '/auth/login',
              onRequestClose: onRequestClose,
            ),
          ),
        ),
      ],
    );
  }
}
