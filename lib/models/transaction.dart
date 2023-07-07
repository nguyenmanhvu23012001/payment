class TransactionModel {
  final String id;
  // final DateTime transferDate;
  final String buyer;
  final String seller;
  final double deposit;
  final double transactionmoney;
  final String goods;
  final String creatat;

  TransactionModel(  {
    required this.creatat,
    required this.goods,
    required this.id,
    required this.buyer,
    required this.seller,
    required this.deposit,
    required this.transactionmoney,
  });

  // static TransactionModel fromMap(Map<String, dynamic> map) {
  //   return TransactionModel(
  //     id: map['_id'],
  //     transferDate: DateTime.parse(map['created_at']),
  //     buyer: map['buyer'],
  //     seller: map['seller'],
  //     transactionmoney: double.parse(map['transaction_money'].toString()),
  //     deposit: double.parse(map['deposit'].toString()),
  //   );
  // }
}