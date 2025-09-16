import 'package:flutter/material.dart';
import 'package:my_app/core/common/widgets/custom_text_field.dart';
import 'package:my_app/core/l10n/app_localizations.dart';

class BeneficiaryInfoSection extends StatelessWidget {
  final TextEditingController beneficiaryNameController;
  final TextEditingController beneficiaryEmailController;
  final TextEditingController beneficiaryPhoneController;

  const BeneficiaryInfoSection({
    super.key,
    required this.beneficiaryNameController,
    required this.beneficiaryEmailController,
    required this.beneficiaryPhoneController,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.editProfileBeneficiaryInfoTitle, style: textTheme.titleLarge),
        const SizedBox(height: 16),
        CustomTextField(
          controller: beneficiaryNameController,
          labelText: l10n.editProfileBeneficiaryNameLabel,
          icon: Icons.favorite_border,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: beneficiaryEmailController,
          labelText: l10n.editProfileBeneficiaryEmailLabel,
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: beneficiaryPhoneController,
          labelText: l10n.editProfileBeneficiaryPhoneLabel,
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }
}