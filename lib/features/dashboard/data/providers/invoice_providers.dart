import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/providers/api_providers.dart';
import 'package:my_app/features/dashboard/data/repositories/invoice_repository_impl.dart';
import 'package:my_app/features/dashboard/domain/repositories/invoice_repository.dart';
import 'package:my_app/features/dashboard/domain/use_cases/get_invoices_use_case.dart';

final invoiceRepositoryProvider = Provider<InvoiceRepository>(
      (ref) => InvoiceRepositoryImpl(ref.watch(invoiceServiceProvider)),
);

final getInvoicesUseCaseProvider = Provider<GetInvoicesUseCase>((ref) {
  final invoiceRepository = ref.watch(invoiceRepositoryProvider);
  return GetInvoicesUseCase(invoiceRepository);
});