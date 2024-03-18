import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/model/expense.dart';
import 'package:flutter_expense_tracker/widget/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expensesList
  });

  final List<Expense> expensesList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expensesList.length,
      itemBuilder: (ctx, index) => ExpenseItem(expensesList[index])
    );
  }
}