import 'dart:ui';

import 'package:flutter/material.dart';

class BlurWidget extends StatefulWidget {
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? minWidth;
  final double? height;
  final double? minHeight;
  final double radius;
  final Color color;
  final double elevation;
  final Alignment? alignment;
  final double blur;
  final Color? shadowColor;

  // final Color splashColor;
  // final ShapeBorder? shape;
  final double? borderWidth;
  final EdgeInsetsGeometry? padding;

  BlurWidget(
      {this.child,
      this.width,
      this.minWidth,
      this.minHeight,
      this.blur: 10,
      this.height,
      this.margin,
      this.padding,
      this.elevation: 4,
      this.shadowColor,
      this.radius: 0,
      this.alignment,
      this.borderWidth: 0,
      this.color: Colors.white70,
      this.border});

  final BoxBorder? border;

  @override
  _BlurWidgetState createState() => _BlurWidgetState();
}

class _BlurWidgetState extends State<BlurWidget> {
  var focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width != null ? (widget.width ?? 0) - (widget.margin?.horizontal ?? 0) : null,
      height: widget.height != null ? (widget.height ?? 0) - (widget.margin?.vertical ?? 0) : null,
      margin: widget.margin,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: widget.blur,
            sigmaY: widget.blur,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
