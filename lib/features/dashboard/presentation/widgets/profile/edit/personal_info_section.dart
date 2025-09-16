import 'package:flutter/material.dart';
import 'package:my_app/core/common/widgets/custom_text_field.dart';

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Información Principal', style: textTheme.titleLarge),
        const SizedBox(height: 16),
        CustomTextField(
          controller: nameController,
          labelText: 'Nombre',
          icon: Icons.person_outline,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: lastNameController,
          labelText: 'Apellido',
          icon: Icons.person_outline,
        ),
      ],
    );
  }
}