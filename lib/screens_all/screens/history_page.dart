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
      appBar: AppBar(
        title: const Text('Lịch sử'),
        centerTitle: true,
      ),
      body: Consumer<HistoryProvider>(
        builder: (context, value, child) {
          final historytransaction = value.historytransaction;

          return ListView.builder(
            itemCount: historytransaction.length,
            itemBuilder: (BuildContext context, int index) {
              var history = historytransaction[index];
              return  Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                        Text(history.id),
                        Text(history.transaction),
                      ],
                    ),
                    subtitle: Column(
                      children: [
                        Text(history.status),
                        Text(
                          "\$${history.description}",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(history.creatat),
                      ],
                    ),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // updatePostButton();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // deletePostButton();
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
        onPressed: () {
          // Xử lý sự kiện khi nhấn nút "Thêm"
        },
      ),
    );
  }

  IconData _getStatusIcon(String status) {
    if (status == 'Thành công') {
      return Icons.check_circle;
    } else if (status == 'Thất bại') {
      return Icons.error;
    } else {
      return Icons.access_time;
    }
  }
}

