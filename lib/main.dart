import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _display = "0";
  String _operand = "";
  double _num1 = 0.0;
  double _num2 = 0.0;

  void _buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      _display = "0";
      _operand = "";
      _num1 = 0.0;
      _num2 = 0.0;
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
      _num1 = double.parse(_output);
      _operand = buttonText;
      _display = "$_num1 $_operand"; // Show the first number with the operator
      _output = ""; // Prepare for the next input
    } else if (buttonText == "=") {
      if (_operand.isNotEmpty) {
        _num2 = double.parse(_output);
        switch (_operand) {
          case "+":
            _output = (_num1 + _num2).toString();
            break;
          case "-":
            _output = (_num1 - _num2).toString();
            break;
          case "×":
            _output = (_num1 * _num2).toString();
            break;
          case "÷":
            _output = (_num1 / _num2).toString();
            break;
        }
        _display = _output; // Update the display to show the result
        _operand = ""; // Reset the operator
      }
    } else {
      if (_output == "0") {
        _output = buttonText;
      } else {
        _output += buttonText;
      }
      if (_operand.isNotEmpty) {
        _display = "$_num1 $_operand $_output"; // Show the full expression
      } else {
        _display = _output; // Show the current input
      }
    }

    setState(() {});
  }

  Widget _buildButton(String text, Color color, Color textColor) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _buttonPressed(text),
        child: Container(
          margin: const EdgeInsets.all(8.0),
          height: 70,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(2, 5),
              ),
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 24, color: textColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Calculator"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Text(
                _display,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildButton("7", Colors.grey[300]!, Colors.black87),
                    _buildButton("8", Colors.grey[300]!, Colors.black87),
                    _buildButton("9", Colors.grey[300]!, Colors.black87),
                    _buildButton("÷", Colors.teal, Colors.white),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("4", Colors.grey[300]!, Colors.black87),
                    _buildButton("5", Colors.grey[300]!, Colors.black87),
                    _buildButton("6", Colors.grey[300]!, Colors.black87),
                    _buildButton("×", Colors.teal, Colors.white),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("1", Colors.grey[300]!, Colors.black87),
                    _buildButton("2", Colors.grey[300]!, Colors.black87),
                    _buildButton("3", Colors.grey[300]!, Colors.black87),
                    _buildButton("-", Colors.teal, Colors.white),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("C", Colors.red, Colors.white),
                    _buildButton("0", Colors.grey[300]!, Colors.black87),
                    _buildButton("=", Colors.green, Colors.white),
                    _buildButton("+", Colors.teal, Colors.white),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
