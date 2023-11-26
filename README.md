# ckeyboard

自定义键盘 demo

## Getting Started

自定义键盘并不允许用户使用系统键盘

用户仅能使用这款自定义键盘输入数字和英文

通过插入OverlayEntry的方式使键盘悬浮与视图之上

PS: 需要自己处理键盘弹起遮挡UI问题

```
TextField(
    controller: _controller,
    // 显示游标
    showCursor: true,
    // 禁用系统键盘
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
```

![screen](https://github.com/ligun123/ckeyboard/assets/1152664/77d896dc-dc0d-4324-a0ed-cfac402c8c63)
