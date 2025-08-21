import 'package:intl/intl.dart';

class CurrencyUtils {
  /// Constructor privado para evitar instanciación.
  CurrencyUtils._();

  static String format(
    num amount, {
    String locale = 'en_US',
    String symbol = '\$',
    int decimalDigits = 2,
  }) {
    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: decimalDigits,
    );
    return formatter.format(amount);
  }

  static String formatWithoutDecimals(
    num amount, {
    String locale = 'en_US',
    String symbol = '\$',
  }) {
    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }
}
