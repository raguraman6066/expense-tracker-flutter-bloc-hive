// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:expensetracker/data/models/category_model.dart';

enum TransactionType { income, expense }

class TransactionModel {
  final int id;
  final double amount;
  final CategoryModel category;
  final TransactionType type;
  final DateTime date;
  TransactionModel({
    required this.id,
    required this.amount,
    required this.category,
    required this.type,
    required this.date, 
  });
}
