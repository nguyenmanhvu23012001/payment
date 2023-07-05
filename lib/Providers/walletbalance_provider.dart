import 'package:flutter/cupertino.dart';
import 'package:intermediary_transaction/models/transaction.dart';
import 'package:intermediary_transaction/models/walletbalance.dart';
import 'package:intermediary_transaction/services/wallet_services.dart';
import '../services/transaction_services.dart';

class WalletBalanceProvider extends ChangeNotifier{
  final _service = WalletService();
  bool isLoading = false;

  List<WalletBalanceModel> _wallets = [];
  List<WalletBalanceModel> get wallet => _wallets;


  WalletBalanceProvider(){
    getAllWallets();
  }




  Future<void> getAllWallets() async{
    isLoading = true;
    notifyListeners();

    final response = await _service.getAll();

    _wallets = response;
    isLoading=false;
    notifyListeners();
  }
}