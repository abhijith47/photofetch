import 'package:http/http.dart' as http;

class Utils {
  static Future<bool> connectivityCheck({int seconds = 10}) async {
    //to check internet connectivity on device
    //creating a custom internet checker which returns a bool
    //checking if a response is getting from google.com with 10 seconds timeout
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
