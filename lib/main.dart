/*
Harrison Stadler
Mobile App Dev
CSC 4360 
HW02 - CalculatorApp
*/

import 'package:flutter/material.dart';

void main() => runApp(const CalculatorApp());

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Main widget that sets up the Material App for the calculator.
    return MaterialApp(
      title: 'Basic Calculator',
      home: Scaffold(
        appBar: AppBar(title: const Text('Basic Calculator')), // App bar at the top.
        body: const CalculatorHome(), // Body of the app which contains the calculator's functionality.
      ),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  const CalculatorHome({super.key});

  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String _display = ''; // This string holds the digits and operations entered by the user.

  // Method that updates the display whenever a button is pressed.
  void _onPressed(String value) {
    setState(() {
      _display += value; // Append the pressed button's value to the display string.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24), // Adjusted padding to better fit the display.
            child: Text(
              _display,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold), // Adjusted font size to prevent clipping.
              overflow: TextOverflow.visible, // Ensures text does not get clipped.
            ),
          ),
        ),
        ..._buildButtonRows(), // Builds the rows of buttons dynamically.
      ],
    );
  }

  // Helper method to create rows of buttons based on a predefined list.
  List<Widget> _buildButtonRows() {
    const buttons = [
      ['7', '8', '9', '/'],
      ['4', '5', '6', '*'],
      ['1', '2', '3', '-'],
      ['C', '0', '=', '+'],
    ]; // Each sub-array represents a row of buttons on the calculator.
    return buttons.map((row) {
      return Expanded(
        child: Row(
          children: row.map((label) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: ElevatedButton(
                  onPressed: () => _onPressed(label), // Handle press event.
                  child: Text(label, style: const TextStyle(fontSize: 24)), // Style of the button labels.
                ),
              ),
            );
          }).toList(),
        ),
      );
    }).toList();
  }
}
