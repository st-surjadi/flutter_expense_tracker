import 'package:flutter_expense_tracker/model/expense.dart';

final List<Expense> expenseList = [
  Expense(
    title: 'Flutter Course', 
    amount: 19.99, 
    date: DateTime.now(), 
    category: Category.work
  ),
  Expense(
    title: 'Cinema', 
    amount: 15.69, 
    date: DateTime.now(), 
    category: Category.leisure
  ),
];