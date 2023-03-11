import 'package:http/http.dart' as http;

class Utils {
  static Future<bool> connectivityCheck({int seconds = 10}) async {
    try {
      Uri url = Uri.parse('https://www.google.com/');
      final response = await http.get(url).timeout(Duration(seconds: seconds));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
