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

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context, 
      builder: (ctx) => const CreateExpense()
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
            child: ExpensesList(expensesList: _registeredExpenses)
          )
        ]
      )
    );
  }
}