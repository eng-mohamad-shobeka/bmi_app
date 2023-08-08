import 'dart:ffi';

import 'package:flutter/material.dart';

class NumberPickerWidget extends StatefulWidget {
  NumberPickerWidget({
    Key? key,
    this.minVal = 0,
    this.maxVal = 10,
    required this.onValueChanged,
  }) : super(key: key);

  final int minVal;
  final int maxVal;
  final void Function(int) onValueChanged;

  @override
  State<NumberPickerWidget> createState() => _NumberPickerWidgetState();
}

class _NumberPickerWidgetState extends State<NumberPickerWidget> {
  late PageController pageController;
  late int currentPage;

  @override
  void initState() {
    currentPage = (widget.maxVal - widget.minVal) ~/ 2;
    pageController = PageController(
      viewportFraction: 0.45,
      initialPage: currentPage,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 19),
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.grey.shade400),
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(35)),
          width: 140,
          height: 70,
          child: PageView.builder(
            controller: pageController,
            itemCount: widget.maxVal - widget.minVal,
            itemBuilder: (context, index) {
              return Center(
                child: Text(
                  "${index + widget.minVal}",
                  style: index == currentPage
                      ? TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
                      : TextStyle(fontSize: 18, color: Colors.grey),
                ),
              );
            },
            onPageChanged: (page) {
              setState(() {
                currentPage = page;
              });
              widget.onValueChanged(page + widget.minVal);
            },
          ),
        ),
        Icon(
          Icons.arrow_drop_down,
          size: 50,
        )
      ],
    );
  }
}

/*PageView.builder(
        controller: pageController,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: index == 0
                ? Colors.red
                : index == 1
                    ? Colors.green
                    : Colors.blue,
            child: UnconstrainedBox(
              child: MaterialButton(
                onPressed: () {
                  pageController.animateToPage(
                    1,
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.linear,
                  );
                },
                child: Text("Go to next page"),
                color: Colors.white,
                minWidth: 100,
                height: 50,
              ),
            ),
          );
        },
      ),*/

/*Center(
        child: Container(
          color: Colors.grey,
          alignment: Alignment.center,
          width: 200,
          height: 100,
          child: PageView.builder(
            controller: pageController,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Center(
                child: Text("$index",
                    style: index == pageController.page!.toInt()
                        ? TextStyle(fontSize: 30)
                        : TextStyle(fontSize: 20)),
              );
            },
            onPageChanged: (pageIndex) {
              setState(() {});
            },
          ),
        ),
      ),*/
