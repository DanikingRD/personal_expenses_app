import 'package:flutter/material.dart';

class TransactionEntry extends StatefulWidget {
  final Function(String, double) addTransaction;

  TransactionEntry(this.addTransaction);

  @override
  State<TransactionEntry> createState() => _TransactionEntryState();
}

class _TransactionEntryState extends State<TransactionEntry> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void sendTransaction() {
    if (titleController.text.isNotEmpty && amountController.text.isNotEmpty) {
      final amount = double.parse(amountController.text);
      if (!amount.isNegative) {
        widget.addTransaction(
            titleController.text, double.parse(amountController.text));
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => sendTransaction,
            ),
            Container(
              height: 60,
              child: Row(
                children: [
                  Text('No Date Chosen!'),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {},
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: OutlineButton(
                child: const Text('Add Transaction'),
                onPressed: sendTransaction,
                textColor: Theme.of(context).textTheme.button!.color,
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
