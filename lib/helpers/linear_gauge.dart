

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:sleeptracker/screen/home/controller/home_controller.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'colors.dart';

Padding linearGauge(HomeController _con) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0,right: 15.0),
    child: Obx(
            () {
          return SfLinearGauge(
            showTicks: false,
            minimum: 2,
            maximum: 10,
            axisLabelStyle: const TextStyle(color: Colors.white),
            barPointers: [LinearBarPointer(value: _con.barPointerValue.value,color: borderColor,thickness: 10),],
            markerPointers: [
              LinearWidgetPointer(
                position: LinearElementPosition.outside,
                value: _con.barPointerValue.value,
                onChanged: (value) {
                  (_con.selectedTime.value.hour < 12)
                  ? _con.selectedEndTime.value = _con.selectedTime.value
                      .replacing(
                          hour: (_con.selectedTime.value.hour + value).toInt(),
                          minute: _con.selectedTime.value.minute)
                  : {
                      (value > _con.barPointerValue.value &&
                              _con.barPointerValue.value > 1)
                          ? {
                              _con.selectedEndTime.value =
                                  _con.selectedTime.value.replacing(
                                      hour: (_con.selectedTime.value.hour +
                                              value -
                                              12)
                                          .toInt(),
                                      minute: _con.selectedTime.value.minute)
                            }
                          : {
                              _con.selectedEndTime.value = _con
                                      .selectedEndTime.value =
                                  _con.selectedTime.value.replacing(
                                      hour: (_con.selectedTime.value.hour +
                                              value -
                                              12)
                                          .toInt(),
                                      minute: _con.selectedTime.value.minute)
                            }
                    };
              _con.barPointerValue.value = value;
            },
                child: Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(
                        color: boxColor, shape: BoxShape.circle)
                ),
              ),
            ],
          );
        }
    ),
  );
}