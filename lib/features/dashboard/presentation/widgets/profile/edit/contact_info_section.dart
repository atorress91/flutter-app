import 'package:flutter/material.dart';
import 'package:my_app/core/common/widgets/custom_text_field.dart';

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Datos de Contacto', style: textTheme.titleLarge),
        const SizedBox(height: 16),
        CustomTextField(
          controller: phoneController,
          labelText: 'Teléfono',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: addressController,
          labelText: 'Dirección',
          icon: Icons.location_on_outlined,
        ),
      ],
    );
  }
}