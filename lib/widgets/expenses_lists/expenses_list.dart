import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_lists/expense_item.dart';
import 'package:flutter/cupertino.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;

  const ExpensesList({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    // We should use ListView.builder() when number of list items are unknown,
    // because it will create item only when it is about to become visible. So,
    // it is efficient.

    // And when they are known or are limited then use ListView(), because it
    // creates all list items at once. Not when they are about to be visible.
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => ExpenseItem(expenses[index]),
    );
  }
}
