import 'package:flutter_riverpod/flutter_riverpod.dart';
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
}

final requestPaymentControllerProvider =
StateNotifierProvider<RequestPaymentController, RequestPaymentState>(
      (ref) => RequestPaymentController(ref),
);