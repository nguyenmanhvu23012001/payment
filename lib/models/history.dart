import 'package:flutter/cupertino.dart';

class HistoryTransaction{
  final String id;
  final String transaction;
  final String status;
  final String? description;

  HistoryTransaction({
    required this.id,
    required this.transaction,
    required this.status,
    this.description,
}
   );


}