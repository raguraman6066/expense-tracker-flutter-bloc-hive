import 'package:expensetracker/presentation/widgets/summary_card.dart';
import 'package:expensetracker/utils/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(defaultSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SummaryCard(
            label: "Total balance",
            amount: "\$8000",
            icon: Icons.account_balance,
            color: primaryDark,
          ),
          SizedBox(height: defaultSpacing),
          Row(
            children: [
              Expanded(
                child: SummaryCard(
                  label: "Income",
                  amount: "\$10000",
                  icon: Icons.arrow_upward_rounded,
                  color: secondaryDark,
                ),
              ),
              SizedBox(width: defaultSpacing),
              Expanded(
                child: SummaryCard(
                  label: "Expense",
                  amount: "\$1000",
                  icon: Icons.arrow_downward_rounded,
                  color: accentColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
