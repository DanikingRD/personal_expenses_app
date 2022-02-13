import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/model/transaction.dart';
import 'package:personal_expenses_app/widgets/chart_bar.dart';

class ChartWidget extends StatelessWidget {
  final List<Transaction> weeklyTransactions;
  List<Map<String, Object>> get monthlyTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double sum = 0.0;
      for (int i = 0; i < weeklyTransactions.length; i++) {
        final transaction = weeklyTransactions[i];
        if (transaction.date.day == weekDay.day) {
          if (transaction.date.month == weekDay.month) {
            if (transaction.date.year == weekDay.year) {
              sum += transaction.amount;
            }
          }
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': sum
      };
    });
  }

  ChartWidget(this.weeklyTransactions);

  double get totalSpending {
    return monthlyTransactions.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: monthlyTransactions.map((data) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBarWidget(
              data['day'] as String, 
              (data['amount'] as double),
              totalSpending == 0 ? 0.0 : (data['amount'] as double) / totalSpending),
          );
        }).toList()),
      ),
    );
  }
}
