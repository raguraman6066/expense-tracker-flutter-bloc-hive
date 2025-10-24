import 'package:expensetracker/data/models/transaction_model.dart';
import 'package:expensetracker/utils/constants.dart';
import 'package:expensetracker/utils/format_date.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transactionModel;
  final VoidCallback onDelete;
  const TransactionCard({
    super.key,
    required this.transactionModel,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultRadius),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(defaultSpacing),
        child: Row(
          children: [
            Icon(
              transactionModel.category.icon,
              size: defaultIconSize,
              color: transactionModel.category.color,
            ),
            SizedBox(width: defaultSpacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transactionModel.category.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: defaultFontSize,
                    ),
                  ),
                  SizedBox(height: defaultSpacing / 4),
                  Text(
                    formatDate(transactionModel.date),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: defaultFontSize - 4,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${transactionModel.type == TransactionType.income ? '+ ' : "- "}"
                  "\$${transactionModel.amount.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: transactionModel.type == TransactionType.income
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: defaultFontSize,
                  ),
                ),
                SizedBox(height: defaultSpacing / 4),
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.delete),
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
