import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../helpers/colors.dart';

class HomeController extends GetxController{


  RxDouble barPointerValue = 8.0.obs;

  Rx<TimeOfDay> selectedTime = const TimeOfDay(hour: 21, minute: 30).obs;

  Rx<TimeOfDay> selectedEndTime = const TimeOfDay(hour: 06, minute: 30).obs;


  calculateTime() {
    return (selectedTime.value.hour > 12)?((24.0 - selectedTime.value.hour + selectedTime.value.minute / 60) + (selectedEndTime.value.hour + selectedEndTime.value.minute / 60)):((selectedEndTime.value.hour + selectedEndTime.value.minute / 60) - (selectedTime.value.hour + selectedTime.value.minute / 60));
}

 String sleepingHourTitle(){
    String value = "Sleeping Hours" ;
    if(barPointerValue.value.isNegative){
      value = "Please Select the Relevant Time :(";
    }
    if(barPointerValue.value >= 2 && barPointerValue.value <= 5){
      value = "Blow Average Sleeping Hour";
    }
    if(barPointerValue.value > 5 && barPointerValue.value <= 8){
      value = "Average Sleeping Hour";
    }
    if(barPointerValue.value > 8){
      value = "Above Average Sleeping Hour";
    }
    return value;
 }


///Round Icon Button
  roundIconButton(BuildContext context, IconData iconData) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor,width: 5)
        ),
        child: Icon(iconData,size: 40,color: Colors.white,),
      ),
    );
  }


 ///barPointerValue.value = convertTime(selectedTime.value).difference(convertTime(selectedTime.value)).inHours.toDouble();
}