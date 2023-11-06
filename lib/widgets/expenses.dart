import 'package:expense_tracker/widgets/chart/chart.dart';
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
    // Adding expense in the setState method so that the UI may update too.
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    // Removing expense in the setState method so that the UI may update too.
    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars(); // Clearing snackbars to
    // show the snackbar of the most previous item in case of multiple deletion.

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text(
          'Expense deleted successfully',
        ),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              // Used insert() instead of add() to add the expense at its
              // previous position back.
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    Widget mainContent = const Center(
      child: Text('No expense found. Try adding one !'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

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
      body: screenWidth < screenHeight
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  // Have to wrap Expanded around it because it became a List
                  // inside a List i.e Column accepts a list of Widgets and
                  // ListView builder was returning also a list. So, flutter
                  // didn't know how to display the inner list. What should be
                  // the allignments? That's why it wasn't showing the ListView
                  // items. To display ListView items we have to wrap Expanded
                  // around it.
                  child: mainContent,
                ),
              ],
            )
          : Row(children: [
              // Have to wrap Expanded widget around this Chart widget
              // because by default Row widget have a width of double.infinity
              // and this Chart widget is also assigned the same width. That's
              // why it wasn't displaying anything. Because the width is
              // double.infinity and flutter is not able to display a UI.
              Expanded(child: Chart(expenses: _registeredExpenses)),

              // Have to wrap Expanded around it because it became a List
              // inside a List i.e Row accepts a list of Widgets and
              // ListView builder was returning also a list. So, flutter
              // didn't know how to display the inner list. What should be
              // the allignments? That's why it wasn't showing the ListView
              // items. To display ListView items we have to wrap Expanded
              // around it.
              Expanded(
                child: mainContent,
              ),
            ]),
    );
  }
}
