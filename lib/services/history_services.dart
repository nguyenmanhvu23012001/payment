import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intermediary_transaction/constants/constans.dart';
import '../models/history.dart';
class HistoryService {
  Future<List<HistoryTransaction>> getAll() async {
    final uri = Uri.http(baseURL, '/slink/v1/historys');
    final response = await http.get(uri);
    if (response.statusCode == 200) {

      final json = jsonDecode(response.body);
      final data = json['data'];
      if (data is List<dynamic>) {
        final historytransaction = data.map((i) {
          return HistoryTransaction(

              transaction:i['transaction'],
              status:i['status'],

          );
        }).toList();
        return historytransaction;
      }
    }
    return [];
  }
}

