import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/errors/exceptions.dart';
import 'package:my_app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:my_app/features/dashboard/domain/use_cases/get_withdrawal_wallet_configuration_use_case.dart';
import 'package:my_app/features/dashboard/presentation/states/request_payment_state.dart';

class RequestPaymentScreenController extends StateNotifier<RequestPaymentState> {
  final GetWithdrawalWalletConfigurationUseCase _getWithdrawalWalletConfigurationUseCase;
  final Ref _ref;

  RequestPaymentScreenController(this._getWithdrawalWalletConfigurationUseCase, this._ref) : super(const RequestPaymentState());

  Future<void> loadPaymentRequests() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final userId = _ref.read(authNotifierProvider).value?.user.id;
      if (userId == null) {
        throw Exception('Usuario no autenticado');
      }

      final requests = await _getWithdrawalWalletConfigurationUseCase.execute();
      state = state.copyWith(isLoading: false, configuration: requests);
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Ocurrió un error al cargar la configuración.',
      );
    }
  }
}