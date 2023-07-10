import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intermediary_transaction/services/transaction_services.dart';
import '../../models/transaction.dart';

class UpdateTransactionFormModal extends StatefulWidget {
  final TransactionModel transaction;
  const UpdateTransactionFormModal({required this.transaction});

  @override
  State<UpdateTransactionFormModal> createState() => _UpdateTransactionFormModalState();
}

class _UpdateTransactionFormModalState extends State<UpdateTransactionFormModal> {
  final TextEditingController buyer = TextEditingController();
  final TextEditingController seller = TextEditingController();
  final TextEditingController goods = TextEditingController();
  final TextEditingController transactionMoney = TextEditingController();
  final TextEditingController deposit = TextEditingController();
  final _transationService = TransactionService();

  @override
  void initState() {
    final transaction = widget.transaction;
    buyer.text = transaction.buyer;
    seller.text = transaction.seller;
    goods.text = transaction.goods;
    transactionMoney.text= transaction.transactionmoney.toString();
    deposit.text = transaction.deposit.toString();
  }

  void updatePostButton(String id) async {
    String buyerValue = buyer.text;
    String sellerValue = seller.text;
    String goodsValue = goods.text;
    double depositValue = double.parse(deposit.text);
    double transactionmoneyValue = double.parse(transactionMoney.text);



    await _transationService.updateTransaction(
      id: id,
      goods: goodsValue,
      buyer: buyerValue,
      seller: sellerValue,
      deposit: depositValue,
      transactionMoney: transactionmoneyValue
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Thêm giao dịch"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: buyer,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Người mua',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: seller,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Người bán',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: goods,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Hàng hóa',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: transactionMoney,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Số tiền giao dịch',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: deposit,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Số tiền cọc',
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Hủy'),
        ),
        TextButton(
          onPressed: () {
                updatePostButton(widget.transaction.id ??  "");
          },
          child: Text('Sửa'),
        ),
      ],
    );
  }
}
