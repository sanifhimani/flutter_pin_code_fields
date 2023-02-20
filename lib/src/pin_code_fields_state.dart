part of flutter_pin_code_fields;

/// Pin code fields state
class PinCodeFieldsState extends State<PinCodeFields> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;

  /// Input is stored in this list
  late List<String> _inputList;

  /// Index to keep a track of the selected field
  int _selectedIndex = 0;

  @override
  void initState() {
    _initializeFields();

    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: AbsorbPointer(
              absorbing: true,
              child: TextField(
                controller: _textEditingController,
                focusNode: _focusNode,
                enabled: widget.enabled,
                autofocus: widget.autofocus,
                autocorrect: false,
                keyboardType: widget.keyboardType,
                enableInteractiveSelection: false,
                showCursor: false,
                cursorColor: Colors.blue,
                cursorWidth: 0.01,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  color: Colors.red,
                  height: 0.01,
                  fontSize: 0.01,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: _onFocus,
            child: Container(
              constraints: const BoxConstraints(minHeight: 30),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: _generateFields(),
            ),
          ),
        ],
      ),
    );
  }

  void _initializeFields() {
    _initializeTextEditingController();
    _initializeFocusNode();
    _inputList = List<String>.filled(widget.length, "", growable: false);
    _initializeList();
  }

  void _initializeTextEditingController() {
    _textEditingController = widget.controller ?? TextEditingController();

    _textEditingController.addListener(() => _textEditingControllerListener());
  }

  void _textEditingControllerListener() {
    var currentText = _textEditingController.text;

    if (!widget.enabled || _inputList.join("") == currentText) return;

    if (currentText.length == widget.length) widget.onComplete(currentText);

    if (widget.autoHideKeyboard &&
        (currentText.isEmpty || currentText.length == widget.length)) {
      _focusNode.unfocus();
    }

    widget.onChange?.call(currentText);
    _updateTextField(currentText);
  }

  void _updateTextField(String text) async {
    var updatedList = List<String>.filled(widget.length, "");

    for (int i = 0; i < widget.length; i++) {
      updatedList[i] = text.length > i ? text[i] : "";
    }

    setState(() {
      _selectedIndex = text.length;
      _inputList = updatedList;
    });
  }

  void _initializeFocusNode() {
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  void _initializeList() {
    for (int i = 0; i < _inputList.length; i++) {
      _inputList[i] = "";
    }
  }

  void _onFocus() {
    if (_focusNode.hasFocus) _focusNode.unfocus();

    FocusScope.of(context).requestFocus(_focusNode);
    if (!kIsWeb) SystemChannels.textInput.invokeMethod('TextInput.show');
  }

  Widget _generateFields() {
    var textFieldWidgets = <Widget>[];

    for (int i = 0; i < widget.length; i++) {
      Widget field = widget.responsive
          ? Flexible(
              child: _generateTextField(i),
            )
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
              child: _generateTextField(i),
            );
      textFieldWidgets.add(field);
    }

    return widget.responsive
        ? Row(children: textFieldWidgets)
        : Wrap(children: textFieldWidgets);
  }

  Widget _generateTextField(int index) {
    return AnimatedContainer(
      duration: widget.animationDuration,
      margin: widget.margin,
      padding: widget.padding,
      curve: widget.animationCurve,
      width: widget.responsive ? null : widget.fieldWidth,
      height: widget.fieldHeight,
      decoration: BoxDecoration(
        color: _getColor(index, "background"),
        borderRadius: widget.borderRadius,
        border: _generateBorder(index),
      ),
      child: Center(
        child: AnimatedSwitcher(
          switchInCurve: widget.switchInAnimationCurve,
          switchOutCurve: widget.switchOutAnimationCurve,
          duration: widget.animationDuration,
          transitionBuilder: (child, animation) {
            return _generateTransitionWidget(child, animation);
          },
          child: Text(
            _getText(index),
            key: ValueKey(_inputList[index]),
            style: widget.textStyle,
          ),
        ),
      ),
    );
  }

  Widget _generateTransitionWidget(Widget child, Animation<double> animation) {
    Widget transitionWidget = FadeTransition(
      opacity: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(animation),
      child: child,
    );

    switch (widget.animation) {
      case Animations.fade:
        break;
      case Animations.grow:
        {
          transitionWidget = ScaleTransition(
            scale: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animation),
            child: child,
          );
        }
        break;
      case Animations.shrink:
        {
          transitionWidget = ScaleTransition(
            scale: Tween<double>(
              begin: 1.5,
              end: 1,
            ).animate(animation),
            child: child,
          );
        }
        break;
      case Animations.slideInUp:
        {
          transitionWidget = SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.5),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }
        break;
      case Animations.slideInDown:
        {
          transitionWidget = SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -0.5),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }
        break;
      case Animations.slideInLeft:
        {
          transitionWidget = SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }
        break;
      case Animations.slideInRight:
        {
          transitionWidget = SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }
        break;
      case Animations.rotateLeft:
        {
          transitionWidget = RotationTransition(
            turns: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(animation),
            child: child,
          );
        }
        break;
      case Animations.rotateRight:
        {
          transitionWidget = RotationTransition(
            turns: Tween<double>(
              begin: 1.0,
              end: 0.0,
            ).animate(animation),
            child: child,
          );
        }
        break;
    }

    return transitionWidget;
  }

  Border _generateBorder(int index) {
    Border border = Border.all(
      width: 0,
      color: Colors.transparent,
    );

    switch (widget.fieldBorderStyle) {
      case FieldBorderStyle.top:
        {
          border = Border(
            top: _generateBorderSide(index),
          );
        }
        break;
      case FieldBorderStyle.bottom:
        {
          border = Border(
            bottom: _generateBorderSide(index),
          );
        }
        break;
      case FieldBorderStyle.left:
        {
          border = Border(
            left: _generateBorderSide(index),
          );
        }
        break;
      case FieldBorderStyle.right:
        {
          border = Border(
            right: _generateBorderSide(index),
          );
        }
        break;
      case FieldBorderStyle.leftRight:
        {
          border = Border.symmetric(
            horizontal: _generateBorderSide(index),
          );
        }
        break;
      case FieldBorderStyle.topBottom:
        {
          border = Border.symmetric(
            vertical: _generateBorderSide(index),
          );
        }
        break;
      case FieldBorderStyle.square:
        {
          border = Border.symmetric(
            vertical: _generateBorderSide(index),
            horizontal: _generateBorderSide(index),
          );
        }
        break;
    }

    return border;
  }

  BorderSide _generateBorderSide(int index) {
    return BorderSide(
      width: widget.borderWidth,
      color: _getColor(index, "border"),
    );
  }

  Color _getColor(int index, String type) {
    Color color = Colors.transparent;

    switch (type) {
      case "background":
        {
          if (isIndexSelected(index)) {
            return color = widget.activeBackgroundColor;
          }

          color = widget.fieldBackgroundColor;
        }
        break;
      case "border":
        {
          if (isIndexSelected(index)) {
            return color = widget.activeBorderColor;
          }

          color = widget.borderColor;
        }
        break;
    }

    return color;
  }

  bool isIndexSelected(int index) {
    if (!_focusNode.hasFocus || !widget.enabled) return false;

    return _selectedIndex == index ||
        (_selectedIndex == index + 1 && index + 1 == widget.length);
  }

  String _getText(int index) {
    if (widget.obscureText) {
      return _inputList[index]
          .replaceAll(RegExp(r'.'), widget.obscureCharacter);
    }

    return _inputList[index];
  }
}
