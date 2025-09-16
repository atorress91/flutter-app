import 'package:flutter/material.dart';
import 'package:my_app/core/common/widgets/custom_text_field.dart';
import 'package:my_app/core/l10n/app_localizations.dart';

class PersonalInfoSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController lastNameController;

  const PersonalInfoSection({
    super.key,
    required this.nameController,
    required this.lastNameController,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.editProfilePersonalInfoTitle, style: textTheme.titleLarge),
        const SizedBox(height: 16),
        CustomTextField(
          controller: nameController,
          labelText: l10n.editProfileNameLabel,
          icon: Icons.person_outline,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: lastNameController,
          labelText: l10n.editProfileLastNameLabel,
          icon: Icons.person_outline,
        ),
      ],
    );
  }
}