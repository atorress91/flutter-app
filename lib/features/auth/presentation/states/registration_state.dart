class RegistrationState {
  final bool isLoading;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final bool acceptedTerms;
  final String? selectedCountry;
  final String? error;

  const RegistrationState({
    this.isLoading = false,
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.acceptedTerms = false,
    this.selectedCountry,
    this.error,
  });

  RegistrationState copyWith({
    bool? isLoading,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    bool? acceptedTerms,
    String? selectedCountry,
    String? error,
  }) {
    return RegistrationState(
      isLoading: isLoading ?? this.isLoading,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
      acceptedTerms: acceptedTerms ?? this.acceptedTerms,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      error: error ?? this.error,
    );
  }
}