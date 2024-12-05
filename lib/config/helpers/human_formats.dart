import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double value, [ decimal = 0]) =>
     NumberFormat.compactCurrency(
      decimalDigits: decimal,
      symbol: "",
      locale: "en",
    ).format(value);
}
