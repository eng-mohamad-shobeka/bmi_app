import 'dart:math';

import '../enums/gender_enum.dart';

class BMIResult {
  int height;
  int weight;
  int age;
  Gender gender;
  late double bmi;

  BMIResult(this.height, this.weight, this.age, this.gender);

  double calculateResult() {
    bmi = weight / (pow(height / 100, 2));
    if (gender == Gender.male) {
      bmi *= 1.1;
    }
    return bmi;
  }

  String getStatus() {
    if (bmi < 18.5) {
      return "Underweight";
    } else if (bmi < 25) {
      return "Normal";
    } else {
      return "Overweight";
    }
  }
}
