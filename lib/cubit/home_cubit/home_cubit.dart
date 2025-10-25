import 'package:expensetracker/cubit/home_cubit/home_state.dart';
import 'package:expensetracker/data/models/summary_model.dart';
import 'package:expensetracker/data/repositories/transaction_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final TransactionRepository transactionRepository;
  HomeCubit(this.transactionRepository) : super(HomeLoadingState());

  SummaryModel calculateSummary() {
    double totalIncome = transactionRepository.getTotalIncome();
    double totalExpenses = transactionRepository.getTotalExpenses();
    double totalBalance = transactionRepository.getTotalBalance();
    return SummaryModel(
      totalIncome: totalIncome,
      totalExpenses: totalExpenses,
      totalBalance: totalBalance,
    );
  }

  Future<void> loadTransactions() async {
    try {
      final transactions = transactionRepository.getLatestTransactions();
      final summary = calculateSummary();
      emit(HomeLoadedState(transactions, summary));
    } catch (e) {
      emit(HomeErrorState("Failed to load transactions"));
    }
  }

  Future<void> deleteTransaction(int transactionId) async {
    await transactionRepository.deleteTransaction(transactionId);
    emit(HomeDeleteSuccessState("Transaction deleted successfully"));
  }
}
