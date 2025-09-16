class EditProfileFormState {
  final String name;
  final String lastName;
  final String phone;
  final String address;
  final String beneficiaryName;
  final String beneficiaryEmail;
  final String beneficiaryPhone;

  const EditProfileFormState({
    this.name = '',
    this.lastName = '',
    this.phone = '',
    this.address = '',
    this.beneficiaryName = '',
    this.beneficiaryEmail = '',
    this.beneficiaryPhone = '',
  });

  EditProfileFormState copyWith({
    String? name,
    String? lastName,
    String? phone,
    String? address,
    String? beneficiaryName,
    String? beneficiaryEmail,
    String? beneficiaryPhone,
  }) {
    return EditProfileFormState(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      beneficiaryName: beneficiaryName ?? this.beneficiaryName,
      beneficiaryEmail: beneficiaryEmail ?? this.beneficiaryEmail,
      beneficiaryPhone: beneficiaryPhone ?? this.beneficiaryPhone,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EditProfileFormState &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          lastName == other.lastName &&
          phone == other.phone &&
          address == other.address &&
          beneficiaryName == other.beneficiaryName &&
          beneficiaryEmail == other.beneficiaryEmail &&
          beneficiaryPhone == other.beneficiaryPhone;

  @override
  int get hashCode =>
      name.hashCode ^
      lastName.hashCode ^
      phone.hashCode ^
      address.hashCode ^
      beneficiaryName.hashCode ^
      beneficiaryEmail.hashCode ^
      beneficiaryPhone.hashCode;
}
