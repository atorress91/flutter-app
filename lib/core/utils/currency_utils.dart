import 'package:intl/intl.dart';

/// Un conjunto de utilidades para el formato de monedas y números.
///
/// Las funciones se llaman de forma estática, sin crear una instancia.
/// Ejemplo: `CurrencyUtils.format(1250.75)`
class CurrencyUtils {
  // El constructor privado previene que se puedan crear instancias de esta clase.
  CurrencyUtils._();

  /// Formatea un número a un formato de moneda, por defecto colones (CRC).
  ///
  /// Ejemplo: `format(1250.75)` devuelve `₡1,250.75`
  static String format(
      num amount, {
        String locale = 'es_CR', // Formato para Costa Rica
        String symbol = '₡',   // Símbolo del colón
        int decimalDigits = 2,
      }) {
    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: decimalDigits,
    );
    return formatter.format(amount);
  }
}