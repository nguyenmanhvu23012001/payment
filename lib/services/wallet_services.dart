import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intermediary_transaction/constants/constans.dart';
import 'package:intermediary_transaction/models/walletbalance.dart';
class WalletService {
  Future<List<WalletBalanceModel>> getAll() async {
    final uri = Uri.http(baseURL, '/slink/v1/wallets');
    final response = await http.get(uri);
    if (response.statusCode == 200) {

      final json = jsonDecode(response.body);
      final data = json['data'];
      if (data is List<dynamic>) {
        final walletbalances = data.map((e) {
          return WalletBalanceModel(
            name: e['user'],
            deposit:e['deposit'],
            debit:e['debit'],
            id: e['_id'],
              creatat: e['created_at']
          );

          //       name: map['user'],
          //       depositAmount: double.parse(map['deposit'].toString()),
          //       deductedAmount: double.parse(map['deposit'].toString()),
          //       transferDate: DateTime.now());

        }).toList();
        return walletbalances;
      }
    }
    return [];
  }
}