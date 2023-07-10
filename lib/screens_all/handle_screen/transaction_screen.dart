import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Providers/transaction_provider.dart';
import '../../services/transaction_services.dart';

class TransactionList extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.all(16.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          Consumer<TransactionProvider>(
            builder: (context, value, child) {
              final transaction = value.transaction;

              return Column(
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: transaction.length,
                    itemBuilder: (context, index) {
                      final tran = transaction[index];
                      // var userId = tran['_id'].toString();
                      return ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Người mua: ${tran.buyer}"),
                            Text("Người bán: ${tran.seller}"),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Hàng hóa: ${tran.goods}"),
                            Text(
                                "Số tiền giao dịch: \$${tran.transactionmoney}"),
                            Text("Số tiền cọc: \$${tran.deposit}"),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AddTransactionDialog(
                                      buyer: TextEditingController(text: tran.buyer),
                                      seller: TextEditingController(text: tran.seller),
                                      goods: TextEditingController(text: tran.goods),
                                      transactionmoney: TextEditingController(text: tran.transactionmoney.toString()),
                                      deposit: TextEditingController(text: tran.deposit.toString()),
                                      onAdd: () {},
                                      onEdit: () {},
                                    );
                                  },
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // Xử lý xóa giao dịch tại đây
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ]),
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
  final VoidCallback onEdit;
  const AddTransactionDialog({
    required this.buyer,
    required this.seller,
    required this.goods,
    required this.transactionmoney,
    required this.deposit,
    required this.onAdd,
    required this.onEdit,
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
