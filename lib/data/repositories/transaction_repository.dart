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
        throw Exception("Amount should be greater than 0");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  List<TransactionModel> getAllTransactions() {
    return _transactionBox.values.toList();
  }

  List<TransactionModel> getLatestTransactions({int count = 10}) {
    final allTransaction = getAllTransactions();
    final latestTransaction = allTransaction.reversed.take(count).toList();
    return latestTransaction;
  }

  double getTotalIncome() {
    final allTransaction = getAllTransactions();
    return allTransaction
        .where((transaction) => transaction.type == TransactionType.income)
        .fold(0, (sum, transaction) => sum + transaction.amount);
  }

  double getTotalExpenses() {
    final allTransaction = getAllTransactions();
    return allTransaction
        .where((transaction) => transaction.type == TransactionType.expense)
        .fold(0, (sum, transaction) => sum + transaction.amount);
  }

  double getTotalBalance() {
    double totalIncome = getTotalIncome();
    double totalExpenses = getTotalExpenses();
    return totalIncome - totalExpenses;
  }

  Future<void> deleteTransaction(int transactionId) async {
    try {
      await _transactionBox.delete(transactionId);
    } catch (e) {
      throw Exception("Failed to delete transaction: $e");
    }
  }
}
