/*
Harrison Stadler
Mobile App Dev
CSC 4360 
HW02 - CalculatorApp
*/

import 'package:flutter/material.dart';

void main() => runApp(const CalculatorApp());

// Main widget for the application. Sets up the theme and structure of the app.
class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp is the root of your app that follows the Material Design.
    return MaterialApp(
      title: 'Basic Calculator',
      // Scaffold provides a framework for material design layouts with app bars, body, etc.
      home: Scaffold(
        appBar: AppBar(title: const Text('Basic Calculator')), // Top app bar with title.
        body: const CalculatorHome(), // Main content of the app where the calculator is displayed.
      ),
    );
  }
}

// Stateful widget for the calculator home screen that manages state of inputs and calculations.
class CalculatorHome extends StatefulWidget {
  const CalculatorHome({super.key});

  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String _display = '0'; // Displayed text in the calculator screen, starts with '0'.

  // Variables to store the first operand, the second operand, and the operator.
  double? _firstOperand;
  double? _secondOperand;
  String? _operator;

  // Method that handles logic when a button is pressed.
  void _onPressed(String value) {
    setState(() {
      if ('0123456789'.contains(value)) {
        // Handles numeric button press.
        _display = _display == '0' ? value : _display + value;
      } else if ('+-*/'.contains(value)) {
        // Handles operation button press (e.g., +, -, *, /).
        _firstOperand = double.parse(_display); // Store the current number as the first operand.
        _operator = value; // Store the operator.
        _display = '0'; // Reset display for the next number.
      } else if (value == '=') {
        // Handles equals button press.
        if (_firstOperand != null && _operator != null && _display != '0') {
          _secondOperand = double.parse(_display); // Store the current number as the second operand.
          _calculate(); // Perform the calculation.
        }
      } else if (value == 'C') {
        // Handles clear button press.
        _clear(); // Clear the display and reset variables.
      }
    });
  }

  // Method that calculates the result based on the operator and operands.
  void _calculate() {
    double result = 0; // Result of the calculation.
    switch (_operator) {
      case '+':
        result = _firstOperand! + _secondOperand!;
        break;
      case '-':
        result = _firstOperand! - _secondOperand!;
        break;
      case '*':
        result = _firstOperand! * _secondOperand!;
        break;
      case '/':
        if (_secondOperand != 0) {
          result = _firstOperand! / _secondOperand!;
        } else {
          _display = 'Error - divide by zero'; // Handle divide by zero error.
          return;
        }
        break;
    }
    _display = result.toString(); // Display the result.
    _firstOperand = null; // Reset the first operand.
    _operator = null; // Reset the operator.
    _secondOperand = null; // Reset the second operand.
  }

  // Method that clears all variables and resets the display.
  void _clear() {
    _display = '0';
    _firstOperand = null;
    _operator = null;
    _secondOperand = null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          // Container for the display.
          child: Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Text(
              _display,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              overflow: TextOverflow.visible,
            ),
          ),
        ),
        ..._buildButtonRows(), // Generate rows of buttons.
      ],
    );
  }

  // Generates rows of calculator buttons.
  List<Widget> _buildButtonRows() {
    const buttons = [
      ['7', '8', '9', '/'],
      ['4', '5', '6', '*'],
      ['1', '2', '3', '-'],
      ['C', '0', '=', '+'],
    ];
    return buttons.map((row) {
      return Expanded(
        child: Row(
          children: row.map((label) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: ElevatedButton(
                  onPressed: () => _onPressed(label),
                  child: Text(label, style: const TextStyle(fontSize: 24)),
                ),
              ),
            );
          }).toList(),
        ),
      );
    }).toList();
  }
}
