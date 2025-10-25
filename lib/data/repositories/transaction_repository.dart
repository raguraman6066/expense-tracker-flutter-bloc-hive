import 'package:expensetracker/data/models/transaction_model.dart';
import 'package:hive_flutter/adapters.dart';

class TransactionRepository {
  late final Box<TransactionModel> _transactionBox;
  TransactionRepository(Box<TransactionModel> transactionBox) {
    _transactionBox = transactionBox;
  }
  Future<void> addTransaction(TransactionModel transaction) async {
    try {
      if (transaction.amount > 0) {
        await _transactionBox.put(transaction.id, transaction);
      } else {
        throw Exception("Amount should be grater than 0");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
