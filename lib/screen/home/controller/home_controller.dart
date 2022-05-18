import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{


  RxDouble barPointerValue = 8.0.obs;

  Rx<TimeOfDay> selectedTime = const TimeOfDay(hour: 21, minute: 30).obs;

  Rx<TimeOfDay> selectedEndTime = const TimeOfDay(hour: 06, minute: 30).obs;


  calculateTime() {
    return (24.0 - selectedTime.value.hour + selectedTime.value.minute / 60) + (selectedEndTime.value.hour + selectedEndTime.value.minute / 60);
}


 ///barPointerValue.value = convertTime(selectedTime.value).difference(convertTime(selectedTime.value)).inHours.toDouble();

}