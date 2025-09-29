import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/data/request/wallet_request.dart';
import 'package:my_app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:my_app/features/dashboard/data/providers/account_providers.dart';
import 'package:my_app/features/dashboard/presentation/states/request_payment_state.dart';
import 'package:my_app/features/dashboard/data/providers/configuration_providers.dart';


class RequestPaymentController extends StateNotifier<RequestPaymentState> {
  final Ref _ref;

  RequestPaymentController(this._ref) : super(const RequestPaymentState());

  Future<void> loadConfiguration() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final getConfiguration = _ref.read(getWithdrawalWalletConfigurationUseCaseProvider);
      final configuration = await getConfiguration.execute();
      state = state.copyWith(isLoading: false, configuration: configuration);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Ocurrió un error al cargar la configuración.',
      );
    }
  }

  Future<bool> generateVerificationCode() async {
    final userId = _ref.read(authNotifierProvider).value?.user.id;
    if (userId == null) {
      state = state.copyWith(error: 'Usuario no autenticado');
      return false;
    }
    try {
      final generateCodeUseCase = _ref.read(generateVerificationCodeUseCaseProvider);
      final result = await generateCodeUseCase.execute(userId);
      return result;
    } catch (e) {
      state = state.copyWith(error: 'Error al generar el código de verificación.');
      return false;
    }
  }

  Future<bool> createWalletRequest(WalletRequest request) async {
    try {
      final createWalletRequestUseCase =
      _ref.read(createWalletRequestUseCaseProvider);
      final result = await createWalletRequestUseCase.execute(request);
      return result;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  Future<bool> getWalletRequestByAffiliateId(int userId) async {
    try {
      final getWalletRequestByAffiliateIdUseCase =
      _ref.read(getWalletRequestUseCaseProvider);
      final result = await getWalletRequestByAffiliateIdUseCase.execute(userId);
      return result;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }
}

final requestPaymentControllerProvider =
StateNotifierProvider<RequestPaymentController, RequestPaymentState>(
      (ref) => RequestPaymentController(ref),
);