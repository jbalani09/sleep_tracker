

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:nb_utils/nb_utils.dart';

import '../screen/home/controller/home_controller.dart';
import 'colors.dart';

class TimePickerRow extends StatelessWidget {
  const TimePickerRow({
    Key? key,
    required HomeController con,
  }) : _con = con, super(key: key);

  final HomeController _con;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () async {
            _con.selectedTime.value = await showTimePicker(
              context: context,
              builder: (context, child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    backgroundColor: secondaryColor,
                    colorScheme: const ColorScheme.light(
                      // change the border color
                      primary: primaryColor,
                      // change the text color
                      onSurface: secondaryColor,
                    ),
                    // button colors
                    buttonTheme: const ButtonThemeData(
                      colorScheme: ColorScheme.light(
                        primary: secondaryColor,
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
              initialTime: _con.selectedTime.value,
              initialEntryMode: TimePickerEntryMode.dial,
              confirmText: "CONFIRM",
              cancelText: "Cancel",
              helpText: "Sleep Start Time",
            )??const TimeOfDay(hour: 21, minute: 30);
            _con.barPointerValue.value = _con.calculateTime();
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.width * 0.38,
            decoration: const BoxDecoration(
                color: boxColor,
                borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomRight: Radius.circular(50))
            ),
            child: Column(
              children: [
                Expanded(child: Container()),
                const Text("Sleep Start",style: TextStyle(color: Colors.white,fontSize: 18),),
                6.height,
                Obx(
                        () {
                      return Text(_con.selectedTime.value.format(context),style: const TextStyle(color: Colors.white,fontSize: 22),);
                    }
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
        Column(
          children: [
            Obx(
                    () {
                  return Text(_con.barPointerValue.value.toStringAsFixed(1),style: const TextStyle(fontSize: 35,color: Colors.white),);
                }
            ),
            const Text("Hours",style: TextStyle(fontSize: 20,color: Colors.white),)
          ],
        ),
        InkWell(
          onTap: () async {
            _con.selectedEndTime.value = await showTimePicker(
              context: context,
              builder: (context, child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    backgroundColor: secondaryColor,
                    colorScheme: const ColorScheme.light(
                      // change the border color
                      primary: primaryColor,
                      // change the text color
                      onSurface: secondaryColor,
                    ),
                    // button colors
                    buttonTheme: const ButtonThemeData(
                      colorScheme: ColorScheme.light(
                        primary: secondaryColor,
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
              initialTime: _con.selectedEndTime.value,
              initialEntryMode: TimePickerEntryMode.dial,
              confirmText: "CONFIRM",
              cancelText: "Cancel",
              helpText: "Sleep End Time",
            )??const TimeOfDay(hour: 06, minute: 30);
            _con.barPointerValue.value = _con.calculateTime();
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.width * 0.38,
            decoration: const BoxDecoration(
                color: boxColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50),bottomLeft: Radius.circular(50))
            ),
            child: Column(children: [
              Expanded(child: Container()),
              const Text("Sleep End",style: TextStyle(color: Colors.white,fontSize: 18),),
              6.height,
              Obx(() {
                return Text(
                  _con.selectedEndTime.value.format(context),
                  style: const TextStyle(color: Colors.white, fontSize: 22),
                );
              }),
              Expanded(child: Container()),
            ],),
          ),
        )
      ],
    );
  }
}