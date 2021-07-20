import 'dart:async';
import 'package:flutter/material.dart';

typedef OptionsBuilder<T extends Object> = Future<Iterable<T>> Function(
    String pattern);
typedef OptionsViewBuilder<T extends Object> = Widget Function<T>(
    BuildContext context, T itemData);
typedef OnSelected<T extends Object> = void Function<T>(T value);
typedef OptionToString<T extends Object> = String Function(T option);

class AutoCompleteTextField<T extends Object> extends StatefulWidget {
  final InputDecoration? decoration;

  final TextStyle? textStyle;
  final int debounceTime;
  final OptionsBuilder<T> optionsBuilder;
  final OptionsViewBuilder<T> optionsViewBuilder;
  final OptionToString<T> displayStringForOption;
  final OnSelected<T>? onSelected;

  final ValueChanged<String>? onChanged;

  final bool showWithEmpty;
  final bool? autofocus;

  final TextEditingController? controller;
  final T? value;

  final double leftOffset;
  final double rightOffset;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  AutoCompleteTextField({
    this.value,
    this.controller,
    this.debounceTime: 600,
    this.decoration: const InputDecoration(),
    this.onSelected,
    this.showWithEmpty: false,
    this.textStyle: const TextStyle(),
    required this.optionsBuilder,
    required this.optionsViewBuilder,
    this.onChanged,
    this.autofocus,
    this.leftOffset: 0,
    this.rightOffset: 0,
    this.displayStringForOption = defaultStringForOption,
    this.textInputAction,
    this.onSubmitted,
  });

  static String defaultStringForOption(dynamic option) {
    return option.toString();
  }

  @override
  _AutoCompleteTextFieldState<T> createState() =>
      _AutoCompleteTextFieldState<T>();
}

class _AutoCompleteTextFieldState<T> extends State<AutoCompleteTextField>
    with WidgetsBindingObserver {
  OverlayEntry? _overlayEntry;

  Timer? timer;

  List items = [];

  FocusNode _focusNode = FocusNode();

  TextEditingController? controller;
  final LayerLink _layerLink = LayerLink();

  bool _isLoading = false;
  String? _oldText = null;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    if (widget.value != null && widget.controller != null) {
      controller?.text = widget.displayStringForOption(widget.value!);
    }
    controller?.addListener(() {
      widget.onChanged?.call(controller?.text ?? "");
    });

    WidgetsBinding.instance?.addObserver(this);

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        itemCallback(controller?.text ?? "");
      } else {
        removeOverlay();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
          focusNode: _focusNode,
          onSubmitted: widget.onSubmitted,
          textInputAction: widget.textInputAction,
          decoration: widget.decoration?.copyWith(
            suffix: _isLoading
                ? Container(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : null,
          ),
          style: widget.textStyle,
          autofocus: widget.autofocus ?? false,
          controller: controller,
          onChanged: (string) {
            widget.onChanged?.call(string);
            timer?.cancel();
            timer = Timer(Duration(milliseconds: widget.debounceTime), () {
              textChanged(string);
            });
          }),
    );
  }

  itemCallback(String text) async {
    if (_oldText != text) {
      items.clear();
    }

    if ((widget.showWithEmpty || text.isNotEmpty) && _oldText != text) {
      try {
        setState(() {
          _isLoading = true;
        });
        var tmp = await widget.optionsBuilder(text);
        items.clear();
        items.addAll(tmp);
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        print(e.toString());
      }
    }
    _oldText = text;

    if (_overlayEntry != null) {
      _overlayEntry?.markNeedsBuild();
      _overlayEntry?.remove();
    }

    if (items.length > 0) {
      _overlayEntry = this._createOverlay();
    }

    if (_overlayEntry != null) {
      Overlay.of(context)?.insert(_overlayEntry!);
    }

    if (_overlayEntry != null && items.length == 0) {
      _overlayEntry?.markNeedsBuild();
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
    //   this._overlayEntry.markNeedsBuild();
  }

  textChanged(String text) async {
    itemCallback(text);
  }

  OverlayEntry? _createOverlay() {
    if (context.findRenderObject() != null) {
      return OverlayEntry(builder: (_) {
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        var size = renderBox.size;
        return Positioned(
          width: size.width + widget.rightOffset,
          child: CompositedTransformFollower(
            showWhenUnlinked: false,
            link: this._layerLink,
            offset: Offset(widget.leftOffset, size.height + 4),
            child: Material(
              borderRadius: BorderRadius.circular(5.0),
              elevation: 2,
              shadowColor: Colors.black45,
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0x22000000)),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        autofocus: index == 0,
                        onTap: () {
                          if (index < items.length) {
                            widget.onSelected?.call(items[index]);
                            controller?.text = widget.displayStringForOption
                                .call(items[index]);
                            removeOverlay();
                            _focusNode.unfocus();
                          }
                        },
                        child: widget.optionsViewBuilder(context, items[index]),
                      );
                    },
                  )),
            ),
          ),
        );
      });
    } else {
      return null;
    }
  }

  removeOverlay() {
    // items.clear();
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry?.markNeedsBuild();
      _overlayEntry = null;
    }
  }

  @override
  void didChangeMetrics() {
    if (_overlayEntry != null) {
      _overlayEntry?.markNeedsBuild();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    removeOverlay();
    controller?.dispose();
    super.dispose();
  }
}
