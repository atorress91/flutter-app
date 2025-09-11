enum PurchaseStatus { completado, devuelto }

extension PurchaseStatusExtension on PurchaseStatus {
  String get displayName {
    switch (this) {
      case PurchaseStatus.completado:
        return 'Completado';
      case PurchaseStatus.devuelto:
        return 'Devuelto';
    }
  }
}