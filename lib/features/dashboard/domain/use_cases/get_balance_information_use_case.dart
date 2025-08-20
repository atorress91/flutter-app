import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:my_app/features/dashboard/domain/entities/balance_information.dart';
import 'package:my_app/features/dashboard/data/providers/balance_providers.dart';

class GetBalanceInformationUseCase {
  final Ref _ref;

  GetBalanceInformationUseCase(this._ref);

  Future<BalanceInformation> execute() async {
    final authState = _ref.read(authNotifierProvider);
    final userId = authState.value?.user.id;

    if (userId == null) {
      throw Exception("User not authenticated");
    }

    final balanceRepository = _ref.read(balanceRepositoryProvider);
    return await balanceRepository.getBalanceInformation(userId);
  }
}
