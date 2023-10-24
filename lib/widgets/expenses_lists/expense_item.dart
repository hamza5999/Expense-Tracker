import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;

  const ExpenseItem(this.expense, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          children: [
            Text(expense.title),
            const SizedBox(height: 4),
            Row(
              children: [
                // 1. Used string injection to add dollar sign ($) with amount.
                // 2. Used escape character (\) to print dollar sign because dart
                // thinks that first $ is also used for string injection.
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                // 3. Used toStringAsFixed() to convert the value upto 2 decimal
                // places and then convert that to string - this single method
                // performs both tasks.
                const Spacer(),
                // Spacer is used to take up the entire remaining space; means
                // Text widget took its required space and Row took its space
                // this Spacer will cover up the remaining entire space. In
                // other words, it will add space between.
                Row(
                  children: [
                    const Icon(Icons.alarm),
                    const SizedBox(width: 8),
                    Text(expense.date.toString())
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
