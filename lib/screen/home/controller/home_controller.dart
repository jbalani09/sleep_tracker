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
    return ((24.0 - selectedTime.value.hour + selectedTime.value.minute / 60) + (selectedEndTime.value.hour + selectedEndTime.value.minute / 60));
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