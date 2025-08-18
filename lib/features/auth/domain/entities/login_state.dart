class LoginState {
  final bool isLoading;
  final bool obscurePassword;
  final String? error;

  const LoginState({
    this.isLoading = false,
    this.obscurePassword = true,
    this.error,
  });

  LoginState copyWith({bool? isLoading, bool? obscurePassword, String? error}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      error: error ?? this.error,
    );
  }
}
