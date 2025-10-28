import 'package:equatable/equatable.dart';
import 'package:expensetracker/data/models/transaction_model.dart';

sealed class StatsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StatsLoadingState extends StatsState {}

class StatsLoadedState extends StatsState {
  final List<TransactionModel> transactions;
  final Set<DateTime> statsDates;
  StatsLoadedState({required this.statsDates, required this.transactions});
  @override
  List<Object?> get props => [transactions, statsDates];
}

class StatsErrorState extends StatsState {
  final String errorMessage;
  StatsErrorState(this.errorMessage);
}

class StatsDeleteSuccessState extends StatsState {
  final String statsDeleteSuccessMessage;
  StatsDeleteSuccessState(this.statsDeleteSuccessMessage);
}
