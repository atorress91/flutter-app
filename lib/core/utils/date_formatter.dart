import 'package:intl/intl.dart';

/// Un conjunto de utilidades para el formato y manipulación de fechas.
///
/// Las funciones se llaman de forma estática, sin crear una instancia.
/// Ejemplo: `DateUtils.ddMMyyyy(DateTime.now())`
class DateFormatter {
  DateFormatter._();

  static String ddMMyyyy(DateTime? d) {
    if (d == null) return '';
    return DateFormat('dd/MM/yyyy').format(d);
  }

  static String yyyyMMdd(DateTime? d) {
    if (d == null) return '';
    return DateFormat('yyyy-MM-dd').format(d);
  }

  static String long(DateTime? d) {
    if (d == null) return '';
    return DateFormat.yMMMMd('es').format(d);
  }
}
