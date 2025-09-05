import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/errors/exceptions.dart';
import 'package:my_app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:my_app/features/dashboard/domain/use_cases/get_invoices_use_case.dart';
import 'package:my_app/features/dashboard/presentation/states/purchases_state.dart';

class PurchasesScreenController extends StateNotifier<PurchasesState> {
  final GetInvoicesUseCase _getInvoicesUseCase;
  final Ref _ref;

  PurchasesScreenController(this._getInvoicesUseCase, this._ref)
      : super(const PurchasesState());

  Future<void> loadInvoices() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final userId = _ref.read(authNotifierProvider).value?.user.id;
      if (userId == null) {
        throw Exception('Usuario no autenticado');
      }

      final invoices = await _getInvoicesUseCase.execute(userId: userId);
      state = state.copyWith(isLoading: false, invoices: invoices);
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Ocurrió un error al cargar las facturas.');
    }
  }
}