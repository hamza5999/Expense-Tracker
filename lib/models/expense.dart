import 'package:uuid/uuid.dart';

// External package to generate unique Ids
const uuid = Uuid();

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
  }) : id = uuid.v4(); // Used this syntax known as Initializer List to
  // initialize a value i.e id at the time of constructor call
}
