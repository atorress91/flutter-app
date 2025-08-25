import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/providers/api_providers.dart';
import 'package:my_app/features/dashboard/data/repositories/network_purchase_repository_impl.dart';
import 'package:my_app/features/dashboard/domain/repositories/network_purchase_repository.dart';
import 'package:my_app/features/dashboard/domain/use_cases/get_network_purchases_use_case.dart';
import 'package:my_app/features/dashboard/presentation/controllers/network_purchase_controller.dart';
import 'package:my_app/features/dashboard/domain/entities/network_purchase_state.dart';

final networkPurchaseRepositoryProvider = Provider<NetworkPurchaseRepository>(
  (ref) => NetworkPurchaseRepositoryImpl(ref.watch(walletServiceProvider)),
);

final getNetworkPurchasesUseCaseProvider = Provider<GetNetworkPurchasesUseCase>(
  (ref) => GetNetworkPurchasesUseCase(ref),
);

final networkPurchaseControllerProvider =
    StateNotifierProvider<NetworkPurchaseController, NetworkPurchaseState>(
      (ref) => NetworkPurchaseController(ref),
    );
