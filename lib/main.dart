import 'package:flutter/material.dart';

void main() {
  runApp(ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExpenseTrackerHome(),
    );
  }
}

class ExpenseTrackerHome extends StatefulWidget {
  @override
  _ExpenseTrackerHomeState createState() => _ExpenseTrackerHomeState();
}

class _ExpenseTrackerHomeState extends State<ExpenseTrackerHome> {
  final List<Map<String, dynamic>> _expenses = [];
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  double get _totalSpent =>
      _expenses.fold(0.0, (sum, item) => sum + item['amount']);

  void _addExpense() {
    final double? amount = double.tryParse(_amountController.text);
    final String description = _descriptionController.text;
    if (amount != null && amount > 0 && description.isNotEmpty) {
      setState(() {
        _expenses.add({'amount': amount, 'description': description});
      });
      _amountController.clear();
      _descriptionController.clear();
    }
  }

  void _clearExpenses() {
    setState(() {
      _expenses.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Expense Tracker")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Total Spent: \$${_totalSpent.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Amount"),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: "Description"),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _addExpense,
                  child: Text("Add Expense"),
                ),
                ElevatedButton(
                  onPressed: _clearExpenses,
                  child: Text("Clear All"),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _expenses.length,
                itemBuilder: (context, index) {
                  final expense = _expenses[index];
                  return ListTile(
                    title: Text(expense['description']),
                    subtitle: Text(
                      "Amount: \$${expense['amount'].toStringAsFixed(2)}",
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
