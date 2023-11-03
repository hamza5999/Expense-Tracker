import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_lists/expense_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;

  final void Function(Expense expense) onRemoveExpense;

  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  @override
  Widget build(BuildContext context) {
    // We should use ListView.builder() when number of list items are unknown,
    // because it will create item only when it is about to become visible. So,
    // it is efficient.

    // And when they are known or are limited then use ListView(), because it
    // creates all list items at once. Not when they are about to be visible.
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
        ),
        key: ValueKey(expenses[index]), // ValueKey want a parameter that can
        // be used as a unique indentofication value. That's why passed the
        // complete expense object into it.
        onDismissed: (direction) => onRemoveExpense(expenses[index]), // Had to
        // add this onDismissed function parameter because else the app crashes
        // because flutter says that the items were dismissed but why are they
        // still there. And thats because items are still there in the
        // _registeredExpenses list. So, we have to remove the item from there
        // too to make sure this error don't occur.
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}
