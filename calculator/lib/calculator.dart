import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'colors.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double num1 = 0.0;
  double num2 = 0.0;

  var input = '';
  var output = '';
  var operation = '';

  var removeInput = false;
  var size = 50.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      removeInput ? '' : input,
                      style: const TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    output,
                    style: TextStyle(
                      fontSize: size,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              button(
                  text: "C",
                  buttonColor: opreatorColor,
                  textColor: orangeColor),
              button(text: "%", buttonColor: opreatorColor),
              button(
                  text: "⌦",
                  buttonColor: opreatorColor,
                  textColor: orangeColor),
              button(text: "/", buttonColor: opreatorColor)
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(text: "x", buttonColor: opreatorColor)
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(text: "-", buttonColor: opreatorColor)
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(text: "+", buttonColor: opreatorColor)
            ],
          ),
          Row(
            children: [
              button(text: "00"),
              button(text: "0"),
              button(text: "."),
              button(text: "=", buttonColor: orangeColor)
            ],
          ),
        ],
      ),
    );
  }

  Widget button({text, textColor = Colors.white, buttonColor = buttonColor}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(25),
              shape: const CircleBorder(),
              backgroundColor: buttonColor),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 25, color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  onButtonClick(val) {
    if (val == "C") {
      input = '';
      output = '';
    } else if (val == "⌦") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (val == "=") {
      if (input.isNotEmpty) {
        try {
          var userInput = input;
          userInput = input.replaceAll("x", "*");
          Parser p = Parser();
          Expression exp = p.parse(userInput);
          ContextModel cm = ContextModel();
          var result = exp.evaluate(EvaluationType.REAL, cm);
          output = result.toString();
          if (output.endsWith(".0")) {
            output = output.substring(0, output.length - 2);
          }
          input = output;
          removeInput = true;
          size = 40;
        } catch (err) {
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Wrong expression"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"))
                ],
              );
            },
          );
        }
      }
    } else {
      input = input + val;
      removeInput = false;
      size = 30;
    }
    setState(() {});
  }
}
