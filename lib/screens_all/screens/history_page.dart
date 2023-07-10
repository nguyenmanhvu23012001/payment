import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intermediary_transaction/Providers/history_provider.dart';
import 'package:intermediary_transaction/models/history.dart';
import 'package:provider/provider.dart';

class TransactionHistoryPage extends StatefulWidget {
  @override
  _TransactionHistoryPageState createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final historyProvider = Provider.of<HistoryProvider>(context, listen: false);
      historyProvider.getAllTransactions();
    });
  }

  int _currentIndex = 0;

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
          Consumer<HistoryProvider>(
            builder: (context, value, child) {
              final historytransaction = value.historytransaction;

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    var history = historytransaction[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
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
                            children: [
                              Text(history.transaction),
                            ],
                          ),
                          subtitle: Column(
                            children: [
                              Text(history.status),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  // Xử lý sự kiện khi nhấn nút "Chỉnh sửa"
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  // Xử lý sự kiện khi nhấn nút "Xóa"
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: historytransaction.length,
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Xử lý sự kiện khi nhấn nút "Thêm"
        },
      ),
    );
  }
}
