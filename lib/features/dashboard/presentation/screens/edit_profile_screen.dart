import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/common/widgets/avatar_updater.dart';
import 'package:my_app/core/common/widgets/primary_button.dart';
import 'package:my_app/features/auth/domain/entities/user.dart';
import 'package:my_app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:my_app/features/dashboard/presentation/controllers/profile_screen_controller.dart';
import 'package:my_app/features/dashboard/presentation/widgets/profile/edit/beneficiary_info_section.dart';
import 'package:my_app/features/dashboard/presentation/widgets/profile/edit/contact_info_section.dart';
import 'package:my_app/features/dashboard/presentation/widgets/profile/edit/personal_info_section.dart';
import 'package:my_app/features/dashboard/presentation/widgets/profile/profile_header.dart';
import 'package:my_app/features/dashboard/presentation/providers/edit_profile_form_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  // Solo mantiene los controladores para sincronizar con el provider
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _beneficiaryNameController = TextEditingController();
  final _beneficiaryEmailController = TextEditingController();
  final _beneficiaryPhoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeFormFields();
    _setupListeners();
  }

  void _initializeFormFields() {
    // Lee el estado del provider y sincroniza con los controladores
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final formState = ref.read(editProfileFormProvider);
      _nameController.text = formState.name;
      _lastNameController.text = formState.lastName;
      _phoneController.text = formState.phone;
      _addressController.text = formState.address;
      _beneficiaryNameController.text = formState.beneficiaryName;
      _beneficiaryEmailController.text = formState.beneficiaryEmail;
      _beneficiaryPhoneController.text = formState.beneficiaryPhone;
    });
  }

  void _setupListeners() {
    _nameController.addListener(_onFieldChanged);
    _lastNameController.addListener(_onFieldChanged);
    _phoneController.addListener(_onFieldChanged);
    _addressController.addListener(_onFieldChanged);
    _beneficiaryNameController.addListener(_onFieldChanged);
    _beneficiaryEmailController.addListener(_onFieldChanged);
    _beneficiaryPhoneController.addListener(_onFieldChanged);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _beneficiaryNameController.dispose();
    _beneficiaryEmailController.dispose();
    _beneficiaryPhoneController.dispose();
    super.dispose();
  }

  void _onFieldChanged() {
    // Actualiza el provider cuando cambien los campos
    ref
        .read(editProfileFormProvider.notifier)
        .update(
      name: _nameController.text,
      lastName: _lastNameController.text,
      phone: _phoneController.text,
      address: _addressController.text,
      beneficiaryName: _beneficiaryNameController.text,
      beneficiaryEmail: _beneficiaryEmailController.text,
      beneficiaryPhone: _beneficiaryPhoneController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        actions: [
          TextButton(onPressed: _saveChanges, child: const Text('Guardar')),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Avatar
            AvatarUpdater(
              child: ProfileHeader(
                onEdit: () {
                  context.goNamed('edit-profile');
                },
              ),
              onSuccess: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('¡Foto de perfil actualizada!')),
                );
              },
              onError: (error) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(error)));
              },
            ),
            const SizedBox(height: 32),

            // Secciones modulares sin callbacks
            PersonalInfoSection(
              nameController: _nameController,
              lastNameController: _lastNameController,
            ),
            const SizedBox(height: 32),

            ContactInfoSection(
              phoneController: _phoneController,
              addressController: _addressController,
            ),
            const SizedBox(height: 32),

            BeneficiaryInfoSection(
              beneficiaryNameController: _beneficiaryNameController,
              beneficiaryEmailController: _beneficiaryEmailController,
              beneficiaryPhoneController: _beneficiaryPhoneController,
            ),

            const SizedBox(height: 40),
            PrimaryButton(text: 'Guardar Cambios', onPressed: _saveChanges),
          ],
        ),
      ),
    );
  }

  void _saveChanges() async {
    final formState = ref.read(editProfileFormProvider);
    final profileNotifier = ref.read(profileScreenControllerProvider);
    final user = ref.read(authNotifierProvider).value?.user;

    if (user != null) {
      final updatedUser = User(
        id: user.id,
        userName: user.userName,
        identification: user.identification,
        email: user.email,
        name: formState.name,
        lastName: formState.lastName,
        phone: formState.phone,
        address: formState.address,
        beneficiaryName: formState.beneficiaryName,
        beneficiaryEmail: formState.beneficiaryEmail,
        beneficiaryPhone: formState.beneficiaryPhone,
        isActive: user.isActive,
        createdAt: user.createdAt,
        isAffiliate: user.isAffiliate,
        imageUrl: user.imageUrl,
        birthDay: user.birthDay,
      );
      await profileNotifier.updateUserProfile(updatedUser);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Perfil actualizado con éxito')),
        );
        context.pop();
      }
    }
  }
}