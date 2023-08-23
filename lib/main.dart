import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalculatorApplication(),
    );
  }
}

class CalculatorApplication extends StatefulWidget {
  @override
  _CalculatorApplicationState createState() => _CalculatorApplicationState();
}

class _CalculatorApplicationState extends State<CalculatorApplication> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else if (buttonText == "%") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        double decimalValue = double.tryParse(equation) ?? 0.0;
        result = (decimalValue / 100).toString();
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
        onPressed: () => buttonPressed(buttonText),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          padding: EdgeInsets.all(16.0),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0E2433),
      appBar: AppBar(
        title: Text(
          'Calculator',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF0E2433),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize, color: Colors.white),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize, color: Colors.white),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("C", 1, Color(0xFF0B344F)),
                      buildButton("⌫", 1, Color(0xFF0B344F)),
                      buildButton("÷", 1, Color(0xFF0B344F)),
                    ]),
                    TableRow(children: [
                      buildButton("(", 1, Color(0xFF0B344F)),
                      buildButton(")", 1, Color(0xFF0B344F)),
                      buildButton("%", 1, Color(0xFF0B344F)),
                    ]),
                    TableRow(children: [
                      buildButton("7", 1, Color(0xFF0B344F)),
                      buildButton("8", 1, Color(0xFF0B344F)),
                      buildButton("9", 1, Color(0xFF0B344F)),
                    ]),
                    TableRow(children: [
                      buildButton("4", 1, Color(0xFF0B344F)),
                      buildButton("5", 1, Color(0xFF0B344F)),
                      buildButton("6", 1, Color(0xFF0B344F)),
                    ]),
                    TableRow(children: [
                      buildButton("1", 1, Color(0xFF0B344F)),
                      buildButton("2", 1, Color(0xFF0B344F)),
                      buildButton("3", 1, Color(0xFF0B344F)),
                    ]),
                    TableRow(children: [
                      buildButton("0", 1, Color(0xFF0B344F)),
                      buildButton("00", 1, Color(0xFF0B344F)),
                      buildButton(".", 1, Color(0xFF0B344F)),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("×", 1, Color(0xFF0B344F)),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, Color(0xFF0B344F)),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Color(0xFF0B344F)),
                    ]),
                    TableRow(children: [
                      buildButton("=", 3, Color(0xFF0296d98)),
                    ]),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
