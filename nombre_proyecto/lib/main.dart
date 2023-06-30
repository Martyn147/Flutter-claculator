import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _displayText = '0';
  double? _firstOperand;
  double? _secondOperand;
  String? _operator;
  bool _shouldClearDisplay = false;

  void _onDigitPress(String digit) {
    setState(() {
      if (_displayText == '0' || _shouldClearDisplay) {
        _displayText = digit;
        _shouldClearDisplay = false;
      } else {
        _displayText += digit;
      }
    });
  }

  void _onOperatorPress(String operator) {
    setState(() {
      _firstOperand = double.tryParse(_displayText);
      _operator = operator;
      _shouldClearDisplay = true;
    });
  }

  void _onEqualPress() {
    setState(() {
      _secondOperand = double.tryParse(_displayText);
      if (_firstOperand != null &&
          _secondOperand != null &&
          _operator != null) {
        switch (_operator) {
          case '+':
            _displayText = (_firstOperand! + _secondOperand!).toString();
            break;
          case '-':
            _displayText = (_firstOperand! - _secondOperand!).toString();
            break;
          case '*':
            _displayText = (_firstOperand! * _secondOperand!).toString();
            break;
          case '/':
            _displayText = (_firstOperand! / _secondOperand!).toString();
            break;
        }
      }
      _shouldClearDisplay = true;
    });
  }

  void _onClearPress() {
    setState(() {
      _displayText = '0';
      _firstOperand = null;
      _secondOperand = null;
      _operator = null;
      _shouldClearDisplay = false;
    });
  }

  void _onTrigFunctionPress(String function) {
    setState(() {
      double value = double.tryParse(_displayText) ?? 0.0;
      double radians = value * (pi / 180); // Convert degrees to radians

      switch (function) {
        case 'sin':
          _displayText = sin(radians).toString();
          break;
        case 'cos':
          _displayText = cos(radians).toString();
          break;
        case 'tan':
          _displayText = tan(radians).toString();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: [
          SizedBox(height: 16.0),
          Text(
            _getDisplayOperation(),
            style: TextStyle(fontSize: 24.0),
          ),
          SizedBox(height: 8.0),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _displayText,
                style: TextStyle(fontSize: 48.0),
              ),
            ),
          ),
          Divider(height: 1.0, color: Colors.grey),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCalculatorButton('7', Colors.blue),
              SizedBox(width: 8.0),
              _buildCalculatorButton('8', Colors.blue),
              SizedBox(width: 8.0),
              _buildCalculatorButton('9', Colors.blue),
              SizedBox(width: 8.0),
              _buildOperatorButton('/', Colors.red),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCalculatorButton('4', Colors.blue),
              SizedBox(width: 8.0),
              _buildCalculatorButton('5', Colors.blue),
              SizedBox(width: 8.0),
              _buildCalculatorButton('6', Colors.blue),
              SizedBox(width: 8.0),
              _buildOperatorButton('*', Colors.red),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCalculatorButton('1', Colors.blue),
              SizedBox(width: 8.0),
              _buildCalculatorButton('2', Colors.blue),
              SizedBox(width: 8.0),
              _buildCalculatorButton('3', Colors.blue),
              SizedBox(width: 8.0),
              _buildOperatorButton('-', Colors.red),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCalculatorButton('0', Colors.blue),
              SizedBox(width: 8.0),
              _buildEqualButton(),
              SizedBox(width: 8.0),
              _buildOperatorButton('+', Colors.red),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTrigFunctionButton('sin', Colors.green),
              SizedBox(width: 8.0),
              _buildTrigFunctionButton('cos', Colors.green),
              SizedBox(width: 8.0),
              _buildTrigFunctionButton('tan', Colors.green),
            ],
          ),
          SizedBox(height: 8.0),
          _buildClearButton(),
        ],
      ),
    );
  }

  Widget _buildCalculatorButton(String text, Color color) {
    return Expanded(
      child: Container(
        height: 80.0,
        child: ElevatedButton(
          onPressed: () => _onDigitPress(text),
          style: ElevatedButton.styleFrom(
            primary: color,
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 24.0, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildOperatorButton(String text, Color color) {
    return Expanded(
      child: Container(
        height: 80.0,
        child: ElevatedButton(
          onPressed: () => _onOperatorPress(text),
          style: ElevatedButton.styleFrom(
            primary: color,
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 24.0, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildEqualButton() {
    return Expanded(
      child: Container(
        height: 80.0,
        child: ElevatedButton(
          onPressed: _onEqualPress,
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
          child: Text(
            '=',
            style: TextStyle(fontSize: 24.0, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildTrigFunctionButton(String text, Color color) {
    return Expanded(
      child: Container(
        height: 80.0,
        child: ElevatedButton(
          onPressed: () => _onTrigFunctionPress(text),
          style: ElevatedButton.styleFrom(
            primary: color,
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 24.0, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildClearButton() {
    return Container(
      width: double.infinity,
      height: 80.0,
      child: ElevatedButton(
        onPressed: _onClearPress,
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
        ),
        child: Text(
          'Clear',
          style: TextStyle(fontSize: 24.0, color: Colors.white),
        ),
      ),
    );
  }

  String _getDisplayOperation() {
    String operation = '';

    if (_firstOperand != null && _operator != null) {
      operation = '$_firstOperand $_operator ';
    }

    return operation;
  }
}
