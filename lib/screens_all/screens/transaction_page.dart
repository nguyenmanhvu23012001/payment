import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intermediary_transaction/Providers/transaction_provider.dart';
import '../../services/transaction_services.dart';

import 'package:provider/provider.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  Color? blue800 = Colors.blue[800];
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController buyer = TextEditingController();
  TextEditingController seller = TextEditingController();
  TextEditingController goods = TextEditingController();
  TextEditingController transactionmoney = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController deposit = TextEditingController();

  @override
  void initState() {
    super.initState();

    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    transactionProvider.getAllTransactions();
  }

  void clickPostButton() async {
    String buyerValue = buyer.text;
    String sellerValue = seller.text;
    String goodsValue = goods.text;
    String timeValue = time.text;
    double depositValue = double.parse(deposit.text);

    double transactionmoneyValue = double.parse(transactionmoney.text);
    await TransactionService().createTransaction(
        goods: goodsValue,
        buyer: buyerValue,
        seller: sellerValue,
        deposit: depositValue,
        transactionMoney: depositValue);
  }

  void updatePostButton() async {
    await TransactionService().updatePost("");
  }

  void deletePostButton() async {
    await TransactionService().deletePost("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Tạo giao dịch",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            scaffoldKey.currentState?.openDrawer();
          },
          child: Icon(
            Icons.menu,
            size: 30,
            color: blue800,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: blue800),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        // Thêm SingleChildScrollView
        child: Consumer<TransactionProvider>(
          builder: (context, value, child) {
            final transaction = value.transaction;

            return Column(
              children: [
                ListView.builder(
                  shrinkWrap:
                      true, // Thêm shrinkWrap: true để giảm chiều cao của ListView
                  itemCount: transaction.length,
                  itemBuilder: (context, index) {
                    final tran = transaction[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.white10, Colors.white],
                          ),
                        ),
                        child: ListTile(
                          title: Column(
                            children: [
                              ElevatedButton(onPressed: (), child: Container(
                              )),
                              Text("Người mua: ${tran.buyer}"),
                              Text("Người bán: ${tran.seller}"),
                            ],
                          ),
                          subtitle: Column(
                            children: [
                              Text("Hàng hóa: ${tran.goods}"),
                              Text(
                                  "Số tiền giao dịch: \$${tran.transactionmoney}"),
                              Text("Số tiền cọc: \$${tran.deposit}"),
                              Text(tran.creatat),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
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
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: seller,
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Người bán',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: goods,
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Hàng hóa',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: transactionmoney,
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Số tiền giao dịch',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: deposit,
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Số tiền cọc',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: time,
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Ngày giao dịch',
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {},
                      child: Text('Hủy'),
                    ),
                    TextButton(
                      onPressed: () {
                        clickPostButton();
                      },
                      child: Text('Thêm'),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
