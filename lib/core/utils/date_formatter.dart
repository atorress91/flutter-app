import 'package:intl/intl.dart';

/// Un conjunto de utilidades para el formato y manipulación de fechas.
///
/// Las funciones se llaman de forma estática, sin crear una instancia.
/// Ejemplo: `DateUtils.ddMMyyyy(DateTime.now())`
class DateFormatter {
  // El constructor privado previene que se puedan crear instancias de esta clase.
  DateFormatter._();

  /// Formatea una fecha al estilo `dd/MM/yyyy`.
  ///
  /// Ejemplo: `12/08/2025`
  static String ddMMyyyy(DateTime d) {
    return DateFormat('dd/MM/yyyy').format(d);
  }

  /// Formatea una fecha al estilo `yyyy-MM-dd`.
  ///
  /// Ejemplo: `2025-08-12`
  static String yyyyMMdd(DateTime d) {
    return DateFormat('yyyy-MM-dd').format(d);
  }

  /// Formatea una fecha a un formato largo y legible.
  ///
  /// Ejemplo: `12 de agosto de 2025`
  /// Requiere que el locale esté configurado en la app (ej. 'es' o 'es_CR').
  static String long(DateTime d) {
    // 'es' para español genérico.
    return DateFormat.yMMMMd('es').format(d);
  }
}

