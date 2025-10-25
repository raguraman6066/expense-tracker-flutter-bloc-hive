import 'package:expensetracker/bloc/add_transaction_bloc/add_transaction_bloc.dart';
import 'package:expensetracker/config/routes/app_route.dart';
import 'package:expensetracker/config/theme/app_theme.dart';
import 'package:expensetracker/data/models/transaction_model.dart';
import 'package:expensetracker/data/repositories/transaction_repository.dart';
import 'package:expensetracker/utils/category_model_adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(TransactionTypeAdapter());
  Hive.registerAdapter(TransactionModelAdapter());
  Box<TransactionModel> transactionBox = await Hive.openBox<TransactionModel>(
    "transaction",
  );
  runApp(MyApp(transactionBox: transactionBox));
}

class MyApp extends StatelessWidget {
  final Box<TransactionModel> transactionBox;
  const MyApp({super.key, required this.transactionBox});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TransactionRepository(transactionBox),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AddTransactionBloc(context.read<TransactionRepository>()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Expensive Tracker',
          theme: appTheme,
          initialRoute: AppRoutes.dashboard,
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
