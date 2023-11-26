import 'package:flutter/material.dart';

class CKeyboard extends StatefulWidget {
  late VoidCallback _onDone;
  late TextEditingController _controller;
  OverlayEntry? _overlayEntry;
  CKeyboard({
    super.key,
  });

  @override
  State<CKeyboard> createState() => _CKeyboardState();

  void show(
    BuildContext context, {
    required TextEditingController controller,
    required VoidCallback onDone,
  }) {
    _controller = controller;
    _onDone = onDone;
    _overlayEntry = OverlayEntry(builder: (ctx) {
      return Positioned(
        child: Material(
          child: this,
        ),
        bottom: 0,
        left: 0,
        right: 0,
      );
    });
    Overlay.of(context).insert(_overlayEntry!);
  }

  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _overlayEntry = null;
  }
}

class _CKeyboardState extends State<CKeyboard> {
  final List<String> _keyList = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "0",
    "q",
    "w",
    "e",
    "r",
    "t",
    "y",
    "u",
    "i",
    "o",
    "p",
    "a",
    "s",
    "d",
    "f",
    "g",
    "h",
    "j",
    "k",
    "l",
    "del",
    "cap",
    "z",
    "x",
    "c",
    "v",
    "b",
    "n",
    "m",
    ".",
    "ok",
  ];
  bool isCapsLock = false;
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Container(
      // constraints: BoxConstraints(maxHeight: 280),
      color: Colors.black38,
      child: Center(
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(
            bottom: media.viewPadding.bottom,
            top: 5,
            left: 5,
            right: 5,
          ),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 10,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            // mainAxisExtent: 20,
          ),
          itemCount: _keyList.length,
          itemBuilder: (context, index) {
            String key = _keyList[index];
            if (key != "ok" && key != "del") {
              if (isCapsLock) {
                key = key.toUpperCase();
              }
            }
            return GestureDetector(
              onTap: () {
                _onKeyTap(key);
              },
              child: Container(
                color: Colors.blue,
                alignment: Alignment.center,
                child: Text("$key"),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onKeyTap(String key) {
    if (key.toLowerCase() == "cap") {
      _handleCap();
    } else if (key == "ok") {
      widget._onDone();
    } else if (key == "del") {
      _handleDel();
    } else {
      _handleChar(key);
    }
  }

  // 功能按键处理
  void _handleCap() {
    setState(() {
      isCapsLock = !isCapsLock;
    });
  }

  void _handleOk() {
    // 必须在外部调用
  }

  void _handleDel() {
    final controller = widget._controller!;
    final text = controller.text;
    final textSelection = controller.selection;
    final selectionLength = textSelection.end - textSelection.start;
    // There is a selection.
    if (selectionLength > 0) {
      final newText = text.replaceRange(
        textSelection.start,
        textSelection.end,
        '',
      );
      controller.text = newText;
      controller.selection = textSelection.copyWith(
        baseOffset: textSelection.start,
        extentOffset: textSelection.start,
      );
      return;
    }
    // The cursor is at the beginning.
    if (textSelection.start == 0) {
      return;
    }
    // Delete the previous character
    const offset = 1;
    final newStart = textSelection.start - offset;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(
      newStart,
      newEnd,
      '',
    );
    controller.text = newText;
    controller.selection = textSelection.copyWith(
      baseOffset: newStart,
      extentOffset: newStart,
    );
  }

  // 普通字符处理
  void _handleChar(String key) {
    final controller = widget._controller!;
    final text = controller.text;
    final textSelection = controller.selection;
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      key,
    );
    final myTextLength = key.length;
    controller.text = newText;
    controller.selection = textSelection.copyWith(
      baseOffset: textSelection.start + myTextLength,
      extentOffset: textSelection.start + myTextLength,
    );
  }
}
