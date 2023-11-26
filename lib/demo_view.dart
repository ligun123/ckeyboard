import 'package:ckeyboard/ckeyboard/ckeyboard.dart';
import 'package:flutter/material.dart';

class DemoView extends StatefulWidget {
  const DemoView({super.key});

  @override
  State<DemoView> createState() => _DemoViewState();
}

class _DemoViewState extends State<DemoView> {
  final _controller = TextEditingController();
  CKeyboard? _keyboard;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("自定义键盘"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _controller,
              showCursor: true,
              readOnly: true,
              onTap: () {
                if (_keyboard != null) {
                  return;
                }
                _keyboard = CKeyboard()
                  ..show(
                    context,
                    controller: _controller,
                    onDone: () {
                      _keyboard?.dispose();
                      _keyboard = null;
                    },
                  );
              },
            ),
          ),
        ],
      ),
    );
  }
}
