import 'package:expensetracker/presentation/screens/add_transaction_screen.dart';
import 'package:expensetracker/presentation/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String dashboard = "/";
  static const String addTransaction = "/add_transaction";
}

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.dashboard:
        return MaterialPageRoute(builder: (context) => DashboardScreen());
      case AppRoutes.addTransaction:
        return MaterialPageRoute(
          builder: (context) => AddTransactionScreen(),
          fullscreenDialog: true,
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text(
                "Something went wrong! \n No route defined for '${settings.name}'",
              ),
            ),
          ),
        );
    }
  }
}
