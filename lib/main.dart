import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(LoanCalculatorApp());
}

class LoanCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loan Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoanCalculatorScreen(),
    );
  }
}

class LoanCalculatorScreen extends StatefulWidget {
  @override
  _LoanCalculatorScreenState createState() => _LoanCalculatorScreenState();
}

class _LoanCalculatorScreenState extends State<LoanCalculatorScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _interestController = TextEditingController();
  double _months = 1;
  double _monthlyPayment = 0;

  void _calculateMonthlyPayment() {
    final double amount = double.tryParse(_amountController.text) ?? 0;
    final double interest = double.tryParse(_interestController.text) ?? 0;

    if (amount > 0 && interest > 0 && _months > 0) {
      double monthlyInterest = interest / 100;
      _monthlyPayment = amount * monthlyInterest / (1 - pow(1 + monthlyInterest, -_months));
    } else {
      _monthlyPayment = 0;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loan Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Loan calculator',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('Enter amount', style: TextStyle(fontSize: 16)),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                hintText: 'Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Text('Enter number of months', style: TextStyle(fontSize: 16)),
            Slider(
              value: _months,
              min: 1,
              max: 60,
              divisions: 59,
              label: '${_months.toInt()} luni',
              onChanged: (value) {
                setState(() {
                  _months = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text('Enter % per month', style: TextStyle(fontSize: 16)),
            TextField(
              controller: _interestController,
              decoration: InputDecoration(
                hintText: 'Percent',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'You will pay the approximate amount monthly:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    _monthlyPayment.toStringAsFixed(2) + '€',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _calculateMonthlyPayment,
                child: Text(
                  'Calculate',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
