import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_lists/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: "Learn Dart",
      amount: 10,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "Learn Flutter",
      amount: 15.50,
      date: DateTime.now(),
      category: Category.work,
    ),
  ];

  void _addExpense(Expense expense) {
    // Adding expense in the setState method so that the UI may update too means
    // the Expense list should be updated.

    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // To make the modal cover the entire space
      builder: (context) => NewExpense(onAddExpense: _addExpense),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text("Chart"),
          Expanded(
            // Have to wrap Expanded around it because it became a List inside
            // a List i.e Column accepts a list of Widgets and ListView builder
            // was returning also a list. So, flutter didn't know how to
            // display the inner list. What should be the allignments. That's
            // it wasn't showing the ListView items. To display ListView items
            // we have to wrap Expanded around it.
            child: ExpensesList(expenses: _registeredExpenses),
          ),
        ],
      ),
    );
  }
}
