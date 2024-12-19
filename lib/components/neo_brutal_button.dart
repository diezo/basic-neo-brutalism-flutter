import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NeoBrutalButton extends StatefulWidget {
  final String text;
  final Color backgroundColor;
  final Color splashColor;
  final Color strokeColor;
  final Color textColor;
  final EdgeInsets? margin;
  final GestureTapCallback? onPressed;

  const NeoBrutalButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.splashColor,
    required this.strokeColor,
    required this.textColor,
    this.onPressed,
    this.margin,
  });

  @override
  State<StatefulWidget> createState() => _NeoBrutalButtonState();
}

class _NeoBrutalButtonState extends State<NeoBrutalButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: Duration(milliseconds: 40),
      scale: pressed ? 0.9 : 1,
      child: Container(
        margin: widget.margin,
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.strokeColor,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: pressed ? Color(0x00ffffff) : widget.strokeColor,
              blurRadius: 0,
              spreadRadius: -2,
              offset: Offset(5, 6),
            )
          ],
          color: pressed ? widget.splashColor : widget.backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: GestureDetector(
          onTapDown: (_) => setState(() => pressed = true),
          onTapUp: (_) => setState(() => pressed = false),
          onTap: widget.onPressed,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              widget.text,
              style: TextStyle(
                fontFamily: "LexendMega",
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: widget.textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
