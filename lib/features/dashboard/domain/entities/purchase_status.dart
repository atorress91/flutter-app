enum PurchaseStatus { completado, procesando, devuelto }

extension PurchaseStatusExtension on PurchaseStatus {
  String get displayName {
    switch (this) {
      case PurchaseStatus.completado:
        return 'Completado';
      case PurchaseStatus.procesando:
        return 'Procesando';
      case PurchaseStatus.devuelto:
        return 'Devuelto';
    }
  }
}