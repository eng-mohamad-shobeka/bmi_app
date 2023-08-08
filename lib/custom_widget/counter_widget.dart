import 'dart:async';

import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({
    Key? key,
    this.minVal = 0,
    this.maxVal = 10,
    required this.onValueChanged,
  }) : super(key: key);

  final int minVal;
  final int maxVal;
  final void Function(int) onValueChanged;

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  late int selectedValue;

  late Timer timer;

  @override
  void initState() {
    selectedValue = (widget.maxVal - widget.minVal) ~/ 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTapDown: (details) {
            timer = Timer.periodic(Duration(milliseconds: 300), (timer) {
              if (selectedValue > widget.minVal) {
                setState(() {
                  selectedValue--;
                  widget.onValueChanged(selectedValue);
                });
              }
            });
          },
          onTapUp: (details) {
            timer.cancel();
          },
          onTapCancel: () {
            timer.cancel();
          },
          onTap: () {
            if (selectedValue > widget.minVal) {
              setState(() {
                selectedValue--;
                widget.onValueChanged(selectedValue);
              });
            }
          },
          child: Icon(
            Icons.remove_circle_outline,
            size: 30,
          ),
        ),
        Text(
          "$selectedValue",
          style: TextStyle(fontSize: 25),
        ),
        GestureDetector(
          onTapDown: (details) {
            timer = Timer.periodic(Duration(milliseconds: 300), (timer) {
              if (selectedValue < widget.maxVal) {
                setState(() {
                  selectedValue++;
                  widget.onValueChanged(selectedValue);
                });
              }
            });
          },
          onTapUp: (details) {
            timer.cancel();
          },
          onTapCancel: () {
            timer.cancel();
          },
          onTap: () {
            if (selectedValue < widget.maxVal) {
              setState(() {
                selectedValue++;
                widget.onValueChanged(selectedValue);
              });
            }
          },
          child: Icon(
            Icons.add_circle_outline,
            size: 30,
          ),
        ),
      ],
    );
  }
}
