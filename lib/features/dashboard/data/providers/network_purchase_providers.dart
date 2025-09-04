import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/providers/api_providers.dart';
import 'package:my_app/features/dashboard/data/repositories/network_purchase_repository_impl.dart';
import 'package:my_app/features/dashboard/domain/repositories/network_purchase_repository.dart';
import 'package:my_app/features/dashboard/domain/use_cases/get_network_purchases_use_case.dart';

final networkPurchaseRepositoryProvider = Provider<NetworkPurchaseRepository>(
  (ref) => NetworkPurchaseRepositoryImpl(ref.watch(walletServiceProvider)),
);

final getNetworkPurchasesUseCaseProvider =
    Provider<GetNetworkPurchasesUseCase>((ref){
      final networkPurchaseRepository = ref.watch(networkPurchaseRepositoryProvider);
      return GetNetworkPurchasesUseCase(networkPurchaseRepository);
    });


