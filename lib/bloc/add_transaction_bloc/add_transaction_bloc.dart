import 'package:expensetracker/bloc/add_transaction_bloc/add_transaction_event.dart';
import 'package:expensetracker/bloc/add_transaction_bloc/add_transaction_state.dart';
import 'package:expensetracker/data/repositories/transaction_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTransactionBloc
    extends Bloc<AddTransactionEvent, AddTransactionState> {
  TransactionRepository transactionRepository;
  AddTransactionBloc(this.transactionRepository)
    : super(AddTransactionInitial()) {
    on<SubmitTransactionEvent>((event, emit) async {
      emit(AddTransactionProgress());
      try {
        await transactionRepository.addTransaction(event.transaction);
        emit(AddTransactionSuccess("Transaction added successfully"));
      } catch (e) {
        emit(AddTransactionError(e.toString()));
      }
    });
  }
}
