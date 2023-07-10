import 'package:flutter/material.dart';
import 'package:intermediary_transaction/models/transaction.dart';
import 'package:intermediary_transaction/screens_all/handle_screen/transaction_form_modal.dart';
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
                                    return UpdateTransactionFormModal(
                                    transaction: tran,
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





