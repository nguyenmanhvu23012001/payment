import 'package:flutter/cupertino.dart';
import 'package:intermediary_transaction/models/history.dart';
import 'package:intermediary_transaction/models/transaction.dart';
import 'package:intermediary_transaction/services/history_services.dart';
import '../services/transaction_services.dart';

class HistoryProvider extends ChangeNotifier{
  final _service = HistoryService();
  bool isLoading = false;

  List<HistoryTransaction> _historytransactions = [];
  List<HistoryTransaction> get historytransaction => _historytransactions;


  TransactionProvider(){
    getAllTransactions();
  }

  Future<void> getAllTransactions() async{
    isLoading = true;

    final response = await _service.getAll();

    _historytransactions = response;
    isLoading=false;
    notifyListeners();
  }
}