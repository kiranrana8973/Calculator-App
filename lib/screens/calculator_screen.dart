import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _controller = TextEditingController();
  double first = 0;
  double second = 0;
  String operator = "";

  final List<String> characters = [
    "C",
    "*",
    "/",
    "<-",
    "1",
    "2",
    "3",
    "+",
    "4",
    "5",
    "6",
    "-",
    "7",
    "8",
    "9",
    "*",
    "%",
    "0",
    ".",
    "=",
  ];

  final _globalKey = GlobalKey<FormState>();

  Color _getButtonColor(String char) {
    if (char == "C") return Colors.redAccent;
    if (char == "=") return Colors.green;
    if (char == "<-") return Colors.orange;
    if (["+", "-", "*", "/", "%"].contains(char)) return Colors.blueAccent;
    return const Color(0xFF2D2D2D);
  }

  Color _getTextColor(String char) {
    if (["C", "=", "<-"].contains(char) ||
        ["+", "-", "*", "/", "%"].contains(char)) {
      return Colors.white;
    }
    return Colors.white;
  }

  void _onButtonPressed(String char) {
    setState(() {
      if (char == "C") {
        _controller.clear();
      } else if (char == "<-") {
        if (_controller.text.isNotEmpty) {
          _controller.text = _controller.text.substring(
            0,
            _controller.text.length - 1,
          );
        }
      } else if (char == "+" ||
          char == "-" ||
          char == "*" ||
          char == "/" ||
          char == "%") {
        first = double.parse(_controller.text);
        operator = char;
        _controller.text = "";
      } else if (char == "=") {
        second = double.parse(_controller.text);
        double result = 0;
        switch (operator) {
          case "+":
            result = first + second;
            break;
        }
        _controller.text = result.toString();
        // Evaluation haru ya gara i.e + , - , *, / k ma press garecha
      } else {
        _controller.text += char;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        title: const Text(
          'Calculator App',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            letterSpacing: 2,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _globalKey,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D2D2D),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.bottomRight,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        _controller.text.isEmpty ? '0' : _controller.text,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 56,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  flex: 5,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final spacing = 12.0;
                      final columns = 4;
                      final rows = (characters.length / columns).ceil();
                      final buttonWidth =
                          (constraints.maxWidth - (columns - 1) * spacing) /
                          columns;
                      final buttonHeight =
                          (constraints.maxHeight - (rows - 1) * spacing) / rows;

                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          childAspectRatio: buttonWidth / buttonHeight,
                          crossAxisSpacing: spacing,
                          mainAxisSpacing: spacing,
                        ),
                        itemCount: characters.length,
                        itemBuilder: (context, index) {
                          final char = characters[index];
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _getButtonColor(char),
                              foregroundColor: _getTextColor(char),
                              elevation: 4,
                              shadowColor: Colors.black.withValues(alpha: 0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: () {
                              // Button press handling
                              _onButtonPressed(char);
                            },
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                char,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
