import 'package:equatable/equatable.dart';

sealed class AddTransactionState extends Equatable {
  const AddTransactionState();
  @override
  List<Object?> get props => [];
}

class AddTransactionInitial extends AddTransactionState {}

class AddTransactionProgress extends AddTransactionState {}

class AddTransactionSuccess extends AddTransactionState {
  final String successMessage;
  AddTransactionSuccess(this.successMessage);
}

class AddTransactionError extends AddTransactionState {
  final String errorMessage;
  AddTransactionError(this.errorMessage);
}
