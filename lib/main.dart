/*
Harrison Stadler
Mobile App Dev
CSC 4360 
HW02 - CalculatorApp
*/

import 'package:flutter/material.dart';

void main() => runApp(const CalculatorApp());

// Main app widget that initializes and runs the app.
class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp is the root widget of your app. It provides a context for Material Design.
    return MaterialApp(
      title: 'Basic Calculator',
      // Scaffold provides the high-level structure for a screen.
      home: Scaffold(
        appBar: AppBar(title: const Text('Basic Calculator')),  // Title displayed in the AppBar.
        body: const CalculatorHome(), // Body containing the main functionality of the calculator.
      ),
    );
  }
}

// Stateful widget that manages the state of the calculator operations.
class CalculatorHome extends StatefulWidget {
  const CalculatorHome({super.key});

  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String _display = '0';  // The text displayed on the calculator screen.

  // Variables to store the operands and the operator for calculations.
  double? _firstOperand;
  double? _secondOperand;
  String? _operator;

  // Method to handle button presses, updating the state based on the input.
  void _onPressed(String value) {
    setState(() {
      if (value == 'C') {
        _clear();  // Clears the display and resets the operation if 'C' is pressed.
      } else if ('0123456789'.contains(value)) {
        // Handles numeric input by updating the display with the pressed number.
        _display = _display == '0' ? value : _display + value;
      } else if ('+-*/'.contains(value)) {
        // Sets the first operand and the operator for the calculation.
        _firstOperand = double.parse(_display);
        _operator = value;
        _display = '0'; // Clears the display for the next number.
      } else if (value == '=') {
        // Triggers the calculation when '=' is pressed.
        if (_firstOperand != null && _operator != null && _display != '0') {
          _secondOperand = double.parse(_display);
          _calculate();
        }
      }
    });
  }

  // Performs the arithmetic calculation based on the operator and updates the display.
  void _calculate() {
    double result = 0; // Initializes the result variable.
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
          _display = 'Error - divide by zero';  // Handles division by zero error.
          return;
        }
        break;
    }
    _display = result.toString();  // Updates the display with the result.
    _firstOperand = null; // Clears the first operand for new calculations.
    _operator = null; // Clears the operator.
    _secondOperand = null; // Clears the second operand.
  }

  // Clears the display and all calculations.
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
        ..._buildButtonRows(),  // Dynamically generates rows of buttons for the calculator.
      ],
    );
  }

  // Generates rows of calculator buttons dynamically.
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
                  child: Text(label, style: const TextStyle(fontSize: 24)),  // Styling and function binding for each button.
                ),
              ),
            );
          }).toList(),
        ),
      );
    }).toList();
  }
}
