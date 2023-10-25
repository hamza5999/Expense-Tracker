import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // TextEditingController() does all the heavy lifting of storing the entered
  // user input and so on. We don't have to do it manually.
  final _titleController = TextEditingController();

  // When you create a TextEditingController you always have to tell Flutter to
  // delete it when it is not needed anymore. And its done using this dispose().
  // Otherwise, it will consume memory even though when not in use. And whole
  // device memory will be taken up by these controllers, causing app to crash.
  @override
  void dispose() {
    // Always dispose the TextEditingController before calling super.dispose().
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              labelText: "Title",
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  print(_titleController.text);
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
