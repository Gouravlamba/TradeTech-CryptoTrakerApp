import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_urls.dart';

class CoinImageService {
  Future<String?> getCoinImage(String coinId) async {
    try {
      final url = '${ApiUrls.base}/coins/$coinId';
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        return data['image']?['small'] ?? data['image']?['thumb'];
      }
    } catch (e) {
      print(' Image fetch failed for $coinId: $e');
    }
    return null;
  }
}
