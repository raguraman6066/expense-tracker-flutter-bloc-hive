import 'dart:math';

import 'package:expensetracker/cubit/home_cubit/home_cubit.dart';
import 'package:expensetracker/cubit/home_cubit/home_state.dart';
import 'package:expensetracker/data/models/transaction_model.dart';
import 'package:expensetracker/presentation/widgets/message_widget.dart';
import 'package:expensetracker/presentation/widgets/summary_card.dart';
import 'package:expensetracker/presentation/widgets/transaction_card.dart';
import 'package:expensetracker/utils/category_list.dart';
import 'package:expensetracker/utils/constants.dart';
import 'package:expensetracker/utils/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().loadTransactions();
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeDeleteSuccessState) {
          context.read<HomeCubit>().loadTransactions();
          showSnackBar(context, state.homeDeleteSuccessMessage);
        }
      },
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is HomeLoadedState) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(defaultSpacing),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SummaryCard(
                    label: "Total balance",
                    amount: "\$${state.summary.totalBalance}",
                    icon: Icons.account_balance,
                    color: primaryDark,
                  ),
                  SizedBox(height: defaultSpacing),
                  Row(
                    children: [
                      Expanded(
                        child: SummaryCard(
                          label: "Income",
                          amount: "\$${state.summary.totalIncome}",
                          icon: Icons.arrow_upward_rounded,
                          color: secondaryDark,
                        ),
                      ),
                      SizedBox(width: defaultSpacing),
                      Expanded(
                        child: SummaryCard(
                          label: "Expense",
                          amount: "\$${state.summary.totalExpenses}",
                          icon: Icons.arrow_downward_rounded,
                          color: accentColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: defaultSpacing * 2),
                  Text(
                    "Recent Transactions",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: defaultSpacing),
                  state.transactions.isEmpty
                      ? SizedBox(
                          height: 250,
                          child: MessageWidget(
                            icon: Icons.money_off,
                            message: "No transaction added yet",
                          ),
                        )
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.transactions.length,
                          itemBuilder: (context, index) {
                            return TransactionCard(
                              transactionModel: state.transactions[index],
                              // TransactionModel(
                              //   id: DateTime.now().millisecondsSinceEpoch,
                              //   amount: Random().nextInt(1000) + 50,
                              //   category: index % 2 == 0
                              //       ? incomeCategoryList[index %
                              //             incomeCategoryList.length]
                              //       : expenseCategoryList[index %
                              //             expenseCategoryList.length],

                              //   type: index % 2 == 0
                              //       ? TransactionType.income
                              //       : TransactionType.expense,
                              //   date: DateTime.now().subtract(
                              //     Duration(days: Random().nextInt(90)),
                              //   ),
                              // ),
                              onDelete: () {
                                context.read<HomeCubit>().deleteTransaction(
                                  state.transactions[index].id,
                                );
                              },
                            );
                          },
                        ),
                ],
              ),
            ),
          );
        } else if (state is HomeErrorState) {
          return MessageWidget(
            icon: Icons.error_rounded,
            message: state.errorMessage,
          );
        } else {
          return MessageWidget(
            icon: Icons.broken_image,
            message: "Something went wront",
          );
        }
      },
    );
  }
}
