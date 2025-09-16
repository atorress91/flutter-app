import 'package:flutter/material.dart';
import 'package:my_app/core/common/widgets/custom_text_field.dart';

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Información del Beneficiario', style: textTheme.titleLarge),
        const SizedBox(height: 16),
        CustomTextField(
          controller: beneficiaryNameController,
          labelText: 'Nombre del Beneficiario',
          icon: Icons.favorite_border,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: beneficiaryEmailController,
          labelText: 'Correo del Beneficiario',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: beneficiaryPhoneController,
          labelText: 'Teléfono del Beneficiario',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }
}