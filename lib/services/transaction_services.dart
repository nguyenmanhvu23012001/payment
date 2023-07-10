import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:intermediary_transaction/Providers/transaction_provider.dart';
import 'package:intermediary_transaction/constants/constans.dart';
import '../models/transaction.dart';

class TransactionService {
  Future<List<TransactionModel>> getAll() async {
    final uri = Uri.http(baseURL, '/slink/v1/transactions');
    final response = await http.get(uri);
    // print(response.statusCode.toString());
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      // print(json);
      final data = json['data'];
      if (data is List<dynamic>) {
        final transactions = data.map((e) {
          return TransactionModel(
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

  Future<void> createTransaction({
    required String buyer,
    required String seller,
    required String goods,
    required double transactionMoney,
    required double deposit,
    required TransactionProvider transactionProvider,
  }) async {
    Map<String, dynamic> data = {
      "buyer": '64892d954ba6a1be37e1f7c4',
      "seller": '64896f704ba6a1be37d5290f',
      "goods": goods,
      "transaction_money": transactionMoney,
      "deposit": deposit,
    };
    Response response = await dio.post(
      httpUrl + baseURL + '/slink/v1/transactions',
      data: data,
    );

    if (response.statusCode == 200) {
      var transactionData = response.data['data'];
      TransactionModel transaction = TransactionModel(
        goods: transactionData['goods'],
        buyer: transactionData['buyer'],
        seller: transactionData['seller'],
        deposit: double.parse(transactionData['deposit'].toString()),
        transactionmoney:
        double.parse(transactionData['transaction_money'].toString()),
      );

      transactionProvider.addTransaction(transaction);
    } else {
      print("thất bại");
    }
  }


  Future<void> updateTransaction({
    required String id,
    required String buyer,
    required String seller,
    required String goods,
    required double transactionMoney,
    required double deposit,
    required TransactionProvider transactionProvider,
  }) async {
    final url = '$httpUrl$baseURL/slink/v1/transactions/64897ef5edb33d709a022d00'; // Thay đổi đường dẫn API tương ứng với cấu trúc API của bạn
    final data = {
      'buyer': buyer,
      'seller': seller,
      'goods': goods,
      'transaction_money': transactionMoney,
      'deposit': deposit,
    };

    try {
      final response = await dio.put(
        url,
        data: data,
      );

      if (response.statusCode == 200) {
        print('Update transaction success!');
      } else {
        print('Update transaction failed!');
      }
    } catch (error) {
      print('Update transaction error: $error');
    }
  }


  Future<void> deletePost(String reponseString) async {
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