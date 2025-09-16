import 'package:flutter/material.dart';
import 'package:my_app/core/common/widgets/custom_text_field.dart';
import 'package:my_app/core/l10n/app_localizations.dart';

class ContactInfoSection extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController addressController;

  const ContactInfoSection({
    super.key,
    required this.phoneController,
    required this.addressController,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.editProfileContactInfoTitle, style: textTheme.titleLarge),
        const SizedBox(height: 16),
        CustomTextField(
          controller: phoneController,
          labelText: l10n.editProfilePhoneLabel,
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: addressController,
          labelText: l10n.editProfileAddressLabel,
          icon: Icons.location_on_outlined,
        ),
      ],
    );
  }
}