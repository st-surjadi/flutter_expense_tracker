import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/model/expense.dart';
import 'package:flutter_expense_tracker/widget/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expensesList,
    required this.onRemoveExpense
  });

  final List<Expense> expensesList;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expensesList.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.vertical
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          ),
        ),
        key: ValueKey(expensesList[index]),
        onDismissed: (direction) {
          onRemoveExpense(expensesList[index]);
        },
        child: ExpenseItem(expensesList[index])
      )
    );
  }
}