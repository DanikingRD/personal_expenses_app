import 'package:flutter/material.dart';
import 'package:personal_expenses_app/model/transaction.dart';
import 'package:personal_expenses_app/widgets/chart.dart';
import 'package:personal_expenses_app/widgets/transaction_entry.dart';
import 'package:personal_expenses_app/widgets/transaction_list.dart';

void main(List<String> args) {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Expenses",
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'OpenSans',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                titleMedium: TextStyle(fontFamily: 'OpenSans', fontSize: 20),
              ),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [];

  void _addTransaction(String title, double amount) {
    final transaction =
        Transaction(DateTime.now().toString(), title, amount, DateTime.now());
    setState(() {
      _transactions.add(transaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personal Expenses by Daniel',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChartWidget(_recentTransactions),
            TransactionListWidget(_transactions)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showTransaction(context),
      ),
    );
  }

  void _showTransaction(BuildContext ctx) {
    showModalBottomSheet<dynamic>(
        context: ctx,
        isScrollControlled: true,
        builder: (_) {
          return Container(
            height: MediaQuery.of(ctx).size.height * 0.80,
            child: GestureDetector(
              onTap: () {},
              child: TransactionEntry(_addTransaction),
              behavior: HitTestBehavior.opaque,
            ),
          );
        });
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }
}
