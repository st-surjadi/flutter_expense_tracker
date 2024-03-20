import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/model/expense.dart';

class CreateExpense extends StatefulWidget {
  const CreateExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _CreateExpenseState();
  }
}

class _CreateExpenseState extends State<CreateExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category _selectedCategory = Category.leisure;
  DateTime? _selectedDate;

  void _presentDatepicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);
    final date = await showDatePicker(
      context: context, 
      initialDate: now,
      firstDate: firstDate, 
      lastDate: lastDate,
    );
    setState(() {
      _selectedDate = date;
    });
  }

  void _submitExpenseData() {
    final amount = double.tryParse(_amountController.text);
    final isAmounInvalid = amount == null || amount <= 0;
    if (
      _titleController.text.trim().isEmpty || 
      isAmounInvalid || 
      _selectedDate == null
    ) {
      showDialog(context: context, builder: (ctx) => AlertDialog(
        title: const Text('Invalid input.'),
        content: const Text('Please fill the field correctly!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            }, 
            child: const Text('Okay')
          )
        ],
      ));
      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text, 
        amount: amount, 
        date: _selectedDate!, 
        category: _selectedCategory
      )
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      print(width);

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Title')
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixText: '\$ ',
                          label: Text('Amount')
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_selectedDate == null ? 'Select Date' : formatter.format(_selectedDate!)),
                          IconButton(
                            onPressed: _presentDatepicker, 
                            icon: const Icon(Icons.calendar_month)
                          )
                        ],
                      )
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    DropdownButton(
                      value: _selectedCategory,
                      items: Category.values.map((category) => 
                        DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toString().toUpperCase())
                        )
                      ).toList(), 
                      onChanged: (value) {
                        setState(() {
                          if (value == null) return;
                          setState(() {
                            _selectedCategory = value;
                          });
                        });
                      }
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      }, 
                      child: const Text('Cancel')
                    ),
                    ElevatedButton(
                      onPressed: _submitExpenseData, 
                      child: const Text('Save Expense')
                    )
                  ],
                )
              ],
            )
          ),
        ),
      ); 
    });
  }
}