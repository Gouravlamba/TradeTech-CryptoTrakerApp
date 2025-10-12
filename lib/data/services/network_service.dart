import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkService {
  Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    final response = await http.get(Uri.parse(url), headers: headers);
    print('🔗 GET $url [${response.statusCode}]');
    if (response.statusCode == 200) {
      try {
        return json.decode(response.body);
      } catch (e) {
        print(' JSON decode failed: $e');
      }
    } else {
      print(' HTTP error ${response.statusCode}');
    }
    return null;
  }
}
