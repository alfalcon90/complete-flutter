import 'package:flutter/material.dart';
import 'package:expense/models/transaction.dart';
import 'package:expense/widgets/transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, i) {
              Transaction transaction = transactions[i];
              return TransactionItem(
                  transaction: transaction,
                  deleteTransaction: deleteTransaction);
            },
            itemCount: transactions.length,
          );
  }
}
