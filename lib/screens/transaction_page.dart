import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intermediary_transaction/Providers/transaction_provider.dart';
import '../models/transaction.dart';
import '../services/transaction_services.dart';
import 'package:provider/provider.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  Color? blue800 = Colors.blue[800];
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    TransactionProvider transactionProvider =
    Provider.of<TransactionProvider>(context, listen: false);
    transactionProvider.getAllTransactions();
  }

  void clickPostButton() async {
    await TransactionService().createTransaction("");
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
        body: Consumer<TransactionProvider>(
          builder: (context, value, child) {
            final transaction = value.transaction;
            print(transaction.length);
            return ListView.builder(
              itemCount: transaction.length,
              itemBuilder: (context, index) {
                final tran = transaction[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                      leading: CircleAvatar(
                        child: Icon(
                          Icons.people_alt_rounded,
                          size: 30,
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Buyer:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(tran.buyer),
                          SizedBox(height: 8),
                          Text(
                            'Seller:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(tran.seller),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Goods:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            tran.goods,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Transaction Money:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "\$${tran.transactionmoney}",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              updatePostButton();
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              deletePostButton();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),

        floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          clickPostButton();
        },
      ),
    );
  }
}
