import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HW2: Calculator Layout',
      theme: ThemeData(primarySwatch: Colors.blueGrey), 
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";

  Color getButtonColor(String buttonText) {
    if (['C', 'del'].contains(buttonText)) {
      return Colors.red.shade300; 
    } 
    else if (['+', '-', 'x', '/', '=', '%'].contains(buttonText)) {
      return Colors.blue.shade700; 
    } 
    else {
      return Colors.grey.shade800; 
    }
  }

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _output = "0";
      } else if (buttonText == 'del') {
        _output = _output.length > 1 ? _output.substring(0, _output.length - 1) : "0";
        if (_output.isEmpty) _output = "0";
      } else if (['+', '-', 'x', '/', '%', '=', '.'].contains(buttonText)) {
        _output = buttonText;
      } else {
        if (_output == "0" || ['+', '-', 'x', '/', '%', '=', '.'].contains(_output)) {
          _output = buttonText;
        } else {
          _output += buttonText;
        }
      }
    });
  }

  Widget _buildButton(String buttonText, int flex) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: getButtonColor(buttonText),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), 
            padding: const EdgeInsets.all(20),
          ),
          onPressed: () => _buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HW2: Calculator (1030-1)"),
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.grey.shade900,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              child: Text(
                _output,
                style: const TextStyle(
                  fontSize: 55.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          
          const Divider(color: Colors.white24, height: 1.0),

          Expanded(
            flex: 5,
            child: Column(
              children: [
                Row(
                  children: [
                    _buildButton('C', 1),
                    _buildButton('%', 1),
                    _buildButton('/', 1),
                    _buildButton('del', 1), 
                  ],
                ),
                Row(
                  children: [
                    _buildButton('7', 1),
                    _buildButton('8', 1),
                    _buildButton('9', 1),
                    _buildButton('x', 1),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('4', 1),
                    _buildButton('5', 1),
                    _buildButton('6', 1),
                    _buildButton('-', 1),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('1', 1),
                    _buildButton('2', 1),
                    _buildButton('3', 1),
                    _buildButton('+', 1),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('0', 2),
                    _buildButton('.', 1),
                    _buildButton('=', 1),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}