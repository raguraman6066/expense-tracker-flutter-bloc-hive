import 'package:expensetracker/bloc/add_transaction_bloc/add_transaction_bloc.dart';
import 'package:expensetracker/bloc/add_transaction_bloc/add_transaction_event.dart';
import 'package:expensetracker/bloc/add_transaction_bloc/add_transaction_state.dart';
import 'package:expensetracker/cubit/home_cubit/home_cubit.dart';
import 'package:expensetracker/data/models/category_model.dart';
import 'package:expensetracker/data/models/transaction_model.dart';
import 'package:expensetracker/utils/category_list.dart';
import 'package:expensetracker/utils/constants.dart';
import 'package:expensetracker/utils/format_date.dart';
import 'package:expensetracker/utils/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  TransactionType _selectedType = TransactionType.expense;
  CategoryModel _selectedCategory = expenseCategoryList.first;
  DateTime _selectedDate = DateTime.now();
  int _transactionId = DateTime.now().millisecondsSinceEpoch % (1 << 28);
  final _amountController = TextEditingController(text: "");
  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(DateTime.now().year, 1, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<CategoryModel>> categoryItems =
        _selectedType == TransactionType.expense
        ? expenseCategoryList
              .map((category) => _buildCategoryItem(category))
              .toList()
        : incomeCategoryList
              .map((category) => _buildCategoryItem(category))
              .toList();
    return Scaffold(
      appBar: AppBar(title: Text("Add Transaction")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(defaultSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  _buildRadioButton(TransactionType.expense, "Expense"),
                  SizedBox(width: defaultSpacing),
                  _buildRadioButton(TransactionType.income, "Income"),
                ],
              ),
              SizedBox(height: defaultSpacing),
              DropdownButtonFormField<CategoryModel>(
                items: categoryItems,
                value: _selectedCategory,
                onChanged: (value) {
                  _selectedCategory = value!;
                },
                decoration: InputDecoration(
                  labelText: "Category",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: defaultSpacing),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Amount (\$)",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: defaultSpacing),
              TextButton(
                onPressed: () => _selectDate(context),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(defaultSpacing + 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defaultRadius / 2),
                    side: BorderSide(color: Colors.black),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatDate(_selectedDate),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: defaultFontSize,
                      ),
                    ),
                    Icon(Icons.calendar_today, color: Colors.black),
                  ],
                ),
              ),
              SizedBox(height: defaultSpacing),
              BlocConsumer<AddTransactionBloc, AddTransactionState>(
                listener: (context, state) {
                  if (state is AddTransactionSuccess) {
                    context.read<HomeCubit>().loadTransactions();
                    showSnackBar(context, state.successMessage);
                    setState(() {
                      _amountController.text = "";
                      _selectedDate = DateTime.now();
                      _transactionId =
                          DateTime.now().millisecondsSinceEpoch % (1 << 28);
                    });
                  } else if (state is AddTransactionError) {
                    showSnackBar(context, state.errorMessage);
                  }
                },
                builder: (context, state) {
                  if (state is AddTransactionProgress) {
                    return CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    onPressed: () {
                      if (RegExp(
                            r'[0-9]+(\.[0-9]+)?$',
                          ).hasMatch(_amountController.text.trim()) &&
                          _amountController.text.isNotEmpty) {
                        TransactionModel transactionModel = TransactionModel(
                          id: _transactionId,
                          amount: double.parse(_amountController.text),
                          category: _selectedCategory,
                          type: _selectedType,
                          date: _selectedDate,
                        );
                        context.read<AddTransactionBloc>().add(
                          SubmitTransactionEvent(transactionModel),
                        );
                        // print(_transactionId);
                        // print(_selectedType);
                        // print(_selectedCategory.name);
                        // print(formatDate(_selectedDate));
                        // print(_amountController.text);
                      } else {
                        showSnackBar(
                          context,
                          "Only Integer and decimal amount allowed",
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColorDark,
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: defaultFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioButton(TransactionType type, String label) {
    return Row(
      children: [
        Radio(
          value: type,
          groupValue: _selectedType,
          activeColor: Theme.of(context).primaryColor,
          onChanged: (TransactionType? value) {
            setState(() {
              _selectedType = value!;
              _selectedCategory = value == TransactionType.expense
                  ? expenseCategoryList.first
                  : incomeCategoryList.first;
            });
          },
        ),
        Text(label),
      ],
    );
  }

  DropdownMenuItem<CategoryModel> _buildCategoryItem(CategoryModel category) {
    return DropdownMenuItem(
      value: category,
      child: Row(
        children: [
          Icon(category.icon, color: category.color),
          SizedBox(width: defaultSpacing / 2),
          Text(category.name),
        ],
      ),
    );
  }
}
