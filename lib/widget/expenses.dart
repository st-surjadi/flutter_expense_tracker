import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/data/expenses.dart';
import 'package:flutter_expense_tracker/widget/create_expense.dart';
import 'package:flutter_expense_tracker/widget/expenses_list/expenses_list.dart';
import 'package:flutter_expense_tracker/model/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = expenseList;

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    print(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context, 
      builder: (ctx) => CreateExpense(
        onAddExpense: _addExpense,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay, 
            icon: const Icon(Icons.add)
          )
        ],
      ),
      body: Column(
        children: [
          const Text('The Chart'),
          Expanded(
            child: ExpensesList(
              expensesList: _registeredExpenses,
              onRemoveExpense: _removeExpense,
            )
          )
        ]
      )
    );
  }
}