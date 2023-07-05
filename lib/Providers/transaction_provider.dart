import 'package:flutter/cupertino.dart';
import 'package:intermediary_transaction/models/transaction.dart';
import '../services/transaction_services.dart';

class TransactionProvider extends ChangeNotifier {
  final _service = TransactionService();
  bool isLoading = false;

  List<TransactionModel> _transactions = [];
  List<TransactionModel> get transaction => _transactions;

  TransactionProvider() {
    getAllTransactions();
  }

  Future<void> getAllTransactions() async {
    print(" Đang lấy dữ liệu");
    isLoading = true;

    final response = await _service.getAll();
    _transactions = response;
    isLoading = false;
    notifyListeners();
  }

  addTransaction(TransactionModel transactionModel){
    _transactions.add(transactionModel);
    notifyListeners();

  }

}
