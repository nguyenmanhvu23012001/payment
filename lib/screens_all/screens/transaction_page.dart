import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Providers/transaction_provider.dart';
import '../../services/transaction_services.dart';
import '../handle_screen/transaction_screen.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);
  @override
  State<TransactionPage> createState() => _TransactionPageState();

}
class _TransactionPageState extends State<TransactionPage> {
  TextEditingController buyer = TextEditingController();
  TextEditingController seller = TextEditingController();
  TextEditingController goods = TextEditingController();
  TextEditingController transactionmoney = TextEditingController();
  TextEditingController deposit = TextEditingController();

  void resetField() {
    buyer.clear();
    seller.clear();
    goods.clear();
    transactionmoney.clear();
    deposit.clear();
  }

  void clickPostButton() async {
    String buyerValue = buyer.text;
    String sellerValue = seller.text;
    String goodsValue = goods.text;
    double depositValue = double.parse(deposit.text);
    double transactionmoneyValue = double.parse(transactionmoney.text);

    TransactionProvider transactionProvider =
    Provider.of<TransactionProvider>(context, listen: false);

    await TransactionService().createTransaction(
      goods: goodsValue,
      buyer: buyerValue,
      seller: sellerValue,
      deposit: depositValue,
      transactionMoney: transactionmoneyValue,
      transactionProvider: transactionProvider,
    );
  }



  void deletePostButton() async {
    // await TransactionService().deletePost("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/hinh-anh-ve-bien-14.jpg',
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          TransactionList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(

            context: context,
            builder: (BuildContext context) {
              return AddTransactionDialog(
                buyer: buyer,
                seller: seller,
                goods: goods,
                transactionmoney: transactionmoney,
                deposit: deposit,
                onAdd: () {
                  clickPostButton();
                  resetField();
                  Navigator.of(context).pop();
                },
              );
            },
          );
        },
      ),
    );
  }

}
class AddTransactionDialog extends StatelessWidget {
  final TextEditingController buyer;
  final TextEditingController seller;
  final TextEditingController goods;
  final TextEditingController transactionmoney;
  final TextEditingController deposit;
  final VoidCallback onAdd;

  const AddTransactionDialog({
    required this.buyer,
    required this.seller,
    required this.goods,
    required this.transactionmoney,
    required this.deposit,
    required this.onAdd,

  });

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
              controller: transactionmoney,
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
          onPressed: onAdd,
          child: Text('Thêm'),
        ),
      ],
    );
  }
}
