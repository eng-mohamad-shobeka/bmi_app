import 'package:bmi_20/custom_widget/counter_widget.dart';
import 'package:bmi_20/custom_widget/number_picker_widget.dart';
import 'package:bmi_20/models/bmi_result.dart';
import 'package:bmi_20/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';

import '../enums/gender_enum.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Gender? selectedGender;
  int selectedHeight = 172;
  int selectedWeight = 75;
  int selectedAge = 30;

  int currentIndex = 0;
  PageController pageController = PageController();

  bool showResult = false;

  late BMIResult result;

  bool containerShown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (selectedGender == null) return;
            result = BMIResult(
                selectedHeight, selectedWeight, selectedAge, selectedGender!);
            result.calculateResult();
            setState(() {
              showResult = !showResult;
              containerShown = false;
            });
          },
          backgroundColor: Colors.black,
          child: !showResult
              ? Text(
                  "BMI",
                  style: TextStyle(color: Colors.white),
                )
              : Icon(
                  Icons.refresh,
                  color: Colors.white,
                )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: AnimatedContainer(
          onEnd: () {
            setState(() {
              containerShown = true;
            });
          },
          duration: Duration(milliseconds: 500),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          height: !showResult
              ? kToolbarHeight
              : MediaQuery.of(context).size.height * 0.5,
          child: !showResult
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    IconWithText(
                      icon: Icon(
                        Icons.insights,
                        color: Colors.white,
                      ),
                      text: "Activity",
                      textColor: Colors.white,
                      fontSize: 10,
                    ),
                    IconWithText(
                      icon: Icon(
                        Icons.person_outline,
                        color: Colors.white,
                      ),
                      text: "Activity",
                      textColor: Colors.white,
                      fontSize: 10,
                    )
                  ],
                )
              : AnimatedContainer(
                  duration: Duration(
                    milliseconds: 300,
                  ),
                  child: !containerShown
                      ? Container()
                      : Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Your bmi is ",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "${result.bmi.toStringAsFixed(1)} Kg/m2",
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              result.getStatus(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                ),
        ),
      )
      /* BottomNavigationBar(
        backgroundColor: Colors.blue,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            pageController.animateToPage(currentIndex,
                duration: Duration(milliseconds: 500), curve: Curves.linear);
          });
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(Icons.add),
              label: "First Page"),
          BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(Icons.add),
              label: "First Page"),
          BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(Icons.add),
              label: "First Page"),
          BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(Icons.add),
              label: "First Page"),
        ],
      ),*/
      ,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "BMI Calculator",
          style: TextStyle(
            color: kMainTextColor,
          ),
        ),
        /*bottom: TabBar(
          tabs: [

          ],
        ),*/
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: CustomContainer(
                      borderColor: selectedGender == Gender.male
                          ? kMainTextColor
                          : kMainBorderColor,
                      onTap: () {
                        setState(() {
                          selectedGender = Gender.male;
                        });
                      },
                      child: IconWithText(
                        icon: Icon(
                          Icons.male,
                          color: Colors.orange,
                          size: 90,
                        ),
                        text: "Male",
                        textColor: selectedGender == Gender.male
                            ? kMainGreyTextColor
                            : kMainTextColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomContainer(
                      borderColor: selectedGender == Gender.female
                          ? kMainTextColor
                          : kMainBorderColor,
                      onTap: () {
                        setState(() {
                          selectedGender = Gender.female;
                        });
                      },
                      child: IconWithText(
                        icon: Icon(
                          Icons.female,
                          color: Colors.pink,
                          size: 90,
                        ),
                        text: "Female",
                        textColor: selectedGender == Gender.female
                            ? kMainGreyTextColor
                            : kMainTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CustomContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Height (in cm)",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("$selectedHeight"),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: RulerPicker(
                        //controller: _rulerPickerController!,
                        beginValue: 150,
                        endValue: 250,
                        initValue: selectedHeight,
                        rulerScaleTextStyle: TextStyle(
                          color: kMainTextColor,
                          fontSize: 10,
                        ),
                        scaleLineStyleList: const [
                          ScaleLineStyle(
                            color: kMainTextColor,
                            width: 2,
                            height: 20,
                            scale: 0,
                          ),
                          ScaleLineStyle(
                            color: kMainTextColor,
                            width: 2,
                            height: 20,
                            scale: 5,
                          ),
                          /* ScaleLineStyle(
                                color: Colors.grey,
                                width: 1,
                                height: 15,
                                scale: -1,
                              )*/
                        ],
                        onValueChange: (int newVal) {
                          setState(() {
                            selectedHeight = newVal;
                          });
                          print(newVal);
                        },
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        rulerMarginTop: 4,
                        marker: Container(
                            width: 4,
                            height: 40,
                            decoration: BoxDecoration(
                                color: kMainTextColor,
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: CustomContainer(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text("Weight (in kg)"),
                        SizedBox(
                          height: 10,
                        ),
                        NumberPickerWidget(
                          minVal: 50,
                          maxVal: 100,
                          onValueChanged: (newVal) {
                            selectedWeight = newVal;
                          },
                        ),
                      ],
                    ),
                  )),
                  Expanded(
                    child: CustomContainer(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text("Age"),
                          SizedBox(
                            height: 40,
                          ),
                          CounterWidget(
                            maxVal: 60,
                            minVal: 10,
                            onValueChanged: (age) {
                              selectedAge = age;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20 + kToolbarHeight,
            ),
          ],
        ),
      ),

      /*PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: [

          Container(),
          Container(),
          Container(),
        ],
      ),*/
    );
  }
}

class IconWithText extends StatelessWidget {
  const IconWithText({
    required this.icon,
    required this.text,
    required this.textColor,
    this.fontSize = 18,
    Key? key,
  }) : super(key: key);

  final Icon icon;
  final String text;
  final Color textColor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        SizedBox(
          height: fontSize * 1.1,
        ),
        Text(
          text,
          style: kDefaultTextStyle.copyWith(
            color: textColor,
            fontSize: fontSize,
          ),
        )
      ],
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    this.borderColor = kMainBorderColor,
    this.child,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final Color borderColor;
  final Widget? child;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: borderColor,
            width: 3,
          ),
        ),
        child: child,
      ),
    );
  }
}
