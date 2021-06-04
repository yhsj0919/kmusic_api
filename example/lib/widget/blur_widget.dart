import 'dart:ui';

import 'package:flutter/material.dart';

class BlurWidget extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry margin;
  final double width;
  final double minWidth;
  final double height;
  final double minHeight;
  final double radius;
  final Color color;
  final double elevation;
  final Alignment alignment;
  final double blur;
  final Color shadowColor;
  final Color splashColor;
  final ShapeBorder shape;
  final GestureTapCallback onTap;
  final double borderWidth;
  final EdgeInsetsGeometry padding;

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
      this.splashColor: Colors.white,
      this.radius: 0,
      this.alignment,
      this.shape,
      this.borderWidth: 0,
      this.color: Colors.white70,
      this.border,
      this.onTap});

  final  BoxBorder border;

  @override
  _BlurWidgetState createState() => _BlurWidgetState();
}

class _BlurWidgetState extends State<BlurWidget> {
  var focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: widget.minWidth ?? 0,
        minHeight: widget.minHeight ?? 0,
      ),
      width: widget.width != null ? (widget.width ?? 0) - (widget?.margin?.horizontal ?? 0) : null,
      height: widget.height != null ? (widget.height ?? 0) - (widget?.margin?.vertical ?? 0) : null,
      decoration: BoxDecoration(
        borderRadius: widget.border == null ? BorderRadius.all(Radius.circular(widget.radius)) : null,
        border: widget.border ?? Border.all(color: widget.borderWidth == 0 ? Colors.transparent : Color(0xffcccccc), width: widget.borderWidth),
        boxShadow: [
          BoxShadow(
              color: widget.shadowColor ?? Colors.black12,
              offset: widget.elevation > 0 ? Offset(2, 4) : Offset.zero, //阴影xy轴偏移量
              blurRadius: widget.elevation * 2, //阴影模糊程度
              spreadRadius: widget.elevation //阴影扩散程度
              ),
        ],
      ),
      margin: widget.margin,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: widget.blur,
            sigmaY: widget.blur,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              focusNode: focusNode,
              splashColor: widget.shadowColor ?? widget.splashColor,
              focusColor: widget.shadowColor?.withAlpha(55),
              onHover: (hover) {
                setState(() {
                  hover ? focusNode.requestFocus() : focusNode.unfocus();
                });
              },
              onTap: widget.onTap,
              child: Container(
                alignment: widget.alignment,
                color: widget.color,
                padding: widget.padding,
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
