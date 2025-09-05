import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/features/dashboard/data/providers/invoice_providers.dart';
import 'package:my_app/features/dashboard/presentation/controllers/purchases_screen_controller.dart';
import 'package:my_app/features/dashboard/presentation/states/purchases_state.dart';

final purchasesScreenControllerProvider =
    StateNotifierProvider<PurchasesScreenController, PurchasesState>(
      (ref) =>
          PurchasesScreenController(ref.watch(getInvoicesUseCaseProvider), ref),
    );
