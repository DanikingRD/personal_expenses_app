import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/model/transaction.dart';

class TransactionListWidget extends StatelessWidget {
  final List<Transaction> _transactions;

  TransactionListWidget(this._transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        child: _transactions.isEmpty
            ? Column(
                children: [
                  Center(
                    child: Text('No transactions added yet!',
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  SizedBox(height: 10),
                  Container(
                      height: 150,
                      child: Image.asset(
                        'assets/images/empty_list.jpg',
                        fit: BoxFit.cover,
                      )),
                ],
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    child: Card(
                      elevation: 5,
                      child: Row(children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 8,
                          ),
                          child: Text(
                            '\$${_transactions[index].amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _transactions[index].title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              DateFormat.yMMMd()
                                  .format(_transactions[index].date),
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 14),
                            ),
                          ],
                        )
                      ]),
                    ),
                  );
                },
                itemCount: _transactions.length,
              ));
  }
}
