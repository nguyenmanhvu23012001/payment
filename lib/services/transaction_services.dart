import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:intermediary_transaction/Providers/transaction_provider.dart';
import 'package:intermediary_transaction/constants/constans.dart';
import '../models/transaction.dart';

class TransactionService {
  Future<List<TransactionModel>> getAll() async {
    final uri = Uri.http(baseURL, '/slink/v1/transactions');
    final response = await http.get(uri);
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print(json);
      final data = json['data'];
      if (data is List<dynamic>) {
        final transactions = data.map((e) {
          return TransactionModel(
            id: e['_id'],
            // transferDate: DateTime.parse(e['created_at']),
            buyer: e['buyer'],
            seller: e['seller'],
            transactionmoney: double.parse(e['transaction_money'].toString()),
            deposit: double.parse(e['deposit'].toString()),
            goods: e['goods'],
          );
        }).toList();
        return transactions;
      }
    }
    return [];
  }

  final dio = Dio();
  Future createTransaction(String responseString) async {
    Map data = {
      "buyer": "64892d954ba6a1be37e1f7c4",
      "seller": "64896f704ba6a1be37d5290f",
      "goods": "da ok7",
      "transaction_money": 1000000000,
      "deposit": 1000000
    };


      Response response = await dio
          .post(httpUrl + baseURL + '/slink/v1/transactions', data: data);

      if (response.statusCode == 200) {
        var transactionData = response.data['data'];
        TransactionModel transaction = TransactionModel(
            id: transactionData['_id'],
            goods: transactionData['goods'],
            buyer: transactionData['buyer'],
            seller: transactionData['seller'],
            deposit: double.parse(transactionData['deposit'].toString()),
            transactionmoney: double.parse(transactionData['transaction_money'].toString()));
        TransactionProvider().addTransaction(transaction);

      } else {
        print("thất bại");
      }


  }

  Future updatePost(String reponseString) async {
    Map<String, dynamic> request = {
      "buyer": "64892d954ba6a1be37e1f7c4",
      "seller": "64896f704ba6a1be37d5290f",
      "goods": "Phap",
      "transaction_money": 1000000000,
      "deposit": 1000000
    };
    final uri = Uri.http(
      baseURL,
      '/slink/v1/transactions',
    );
    final reponse = await http.post(uri, body: request);
    if (reponse.statusCode == 200) {
      print("thanh cong");
    } else {
      print(" update that bai");
    }
  }

  Future deletePost(String reponseString) async {
    final uri = Uri.http(
      baseURL,
      '/slink/v1/transactions',
    );
    final reponse = await http.delete(uri);
    if (reponse.statusCode == 200) {
      return null;
    } else {
      throw Exception('Fail to load post');
    }
  }
}
