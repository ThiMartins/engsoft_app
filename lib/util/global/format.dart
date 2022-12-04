import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Format {
  static String formatDate(String date, {String format = "MMMM, 'de' yyyy", String current = "yyyy-MM-dd"}) {
    try {
      final dateTime = DateFormat(current).parse(date);

      return DateFormat(format).format(dateTime);
    } catch (e) {
      return "";
    }
  }

  static String formatDateTime(DateTime date, {String format = "MMMM, 'de' yyyy"}) {
    return DateFormat(format).format(date);
  }

  static String formatPhone(String phone) {
    return MaskTextInputFormatter(mask: "(##) #####-####", filter: { "#" : RegExp("[0-9]") }, initialText: phone).getMaskedText();
  }

}
