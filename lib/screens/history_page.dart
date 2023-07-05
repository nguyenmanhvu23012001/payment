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
              return HistoryTransactionItem(
                status: history.status,
                transaction: history.transaction,
                icon: _getStatusIcon(history.status),
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

class HistoryTransactionItem extends StatelessWidget {
  final String status;
  final IconData icon;
  final String transaction;

  const HistoryTransactionItem({
    required this.status,
    required this.icon,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        title: Text(status),
        subtitle: Text('$transaction - Đã cọc'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                // Xử lý sự kiện khi nhấn nút "Sửa"
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
    );

  }

  Color _getStatusColor() {
    if (status == 'Thành công') {
      return Colors.green;
    } else if (status == 'Thất bại') {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }

}
