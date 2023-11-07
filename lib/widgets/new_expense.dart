import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class NewExpense extends StatefulWidget {
  final void Function(Expense expense) onAddExpense;

  const NewExpense({required this.onAddExpense, super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // TextEditingController() does all the heavy lifting of storing the entered
  // user input and so on. We don't have to do it manually.
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory = Category.leisure;

  // When you create a TextEditingController you always have to tell Flutter to
  // delete it when it is not needed anymore. And its done using this dispose().
  // Otherwise, it will consume memory even though when not in use. And whole
  // device memory will be taken up by these controllers, causing app to crash.
  @override
  void dispose() {
    // Always dispose the TextEditingController before calling super.dispose().
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final currentDate = DateTime.now();

    final datePicked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(
        currentDate.year - 1,
        currentDate.month,
        currentDate.day,
      ),
      lastDate: currentDate,
    );

    setState(() {
      _selectedDate = datePicked;
    });
  }

  void _alertDialog() {
    // Used Platform class to access a specific platform like IOS in this case
    if (Platform.isIOS) {
      // "Cupertino is simply the name of the IOS styling language"
      showCupertinoDialog(
        context: context,
        // CupertinoDialog is the native dialog used in IOS devices. Showing
        // IOS native dialog for IOS devices
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              "Enter a valid title, amount, date and category please"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        // Showing Android native dialog for Android devices
        builder: (context) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              "Enter a valid title, amount, date and category please"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    // double.tryParse is a method to convert a string to double. It works like:
    // double.tryParse("hello") => null, double.tryParse("12.20") => 12.20
    // Means, if the number is parsable then it returns the number in double &
    // if it is not, then it returns null. Like the above example.

    final titleIsInvalid = _titleController.text.trim().isEmpty;
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    final dateIsInvalid = _selectedDate == null;

    if (titleIsInvalid || amountIsInvalid || dateIsInvalid) {
      _alertDialog();
      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory!,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // viewInsets gives us the space of the element taking up the space or
    // overlaping with other elements in the direction we specified that is
    // "bottom" and that element is our "keyboard" in this case

    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (context, constraints) {
      final screenWidth = constraints.maxWidth;
      final screenHeight = constraints.maxHeight;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                // If-else syntax to use in lists - without any curly braces
                if (screenWidth > screenHeight)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          maxLength: 50,
                          decoration: const InputDecoration(
                            labelText: "Title",
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        // Wrapped Textfield inside a Row with Expanded because
                        // TextField tries to take as much space as possible and
                        // Row by default don't stops it; Thus, it can cause
                        // problems.
                        child: TextField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: const InputDecoration(
                            labelText: "Amount",
                            // $ is a special character used for string injection.
                            // We can't use it to print dollar currency sign.
                            // So, we have to add a escape character (\) before it
                            // in order to use it properly.
                            prefixText: "\$ ",
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      labelText: "Title",
                    ),
                  ),
                if (screenWidth > screenHeight)
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }

                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? "No date selected"
                                  : formatter.format(
                                      _selectedDate!), // Added null check
                              // here to tell flutter that it won't be null here
                              // because format() wants a non null argument.
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        // Wrapped Textfield inside a Row with Expanded because
                        // TextField tries to take as much space as possible and
                        // Row by default don't stops it; Thus, it can cause
                        // problems.
                        child: TextField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: const InputDecoration(
                            labelText: "Amount",
                            // $ is a special character used for string injection.
                            // We can't use it to print dollar currency sign.
                            // So, we have to add a escape character (\) before it
                            // in order to use it properly.
                            prefixText: "\$ ",
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Making custom date field as no such field is present by
                      // default.

                      // Wrapped inner Row widget with Expanded because a Row
                      // inside a Row can cause problems.
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? "No date selected"
                                  : formatter.format(
                                      _selectedDate!), // Added null check
                              // here to tell flutter that it won't be null here
                              // because format() wants a non null argument.
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                const SizedBox(height: 20),
                if (screenWidth > screenHeight)
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text("Save"),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }

                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text("Save"),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
