

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
                  (value > _con.barPointerValue.value)?{
                    _con.selectedEndTime.value = _con.selectedEndTime.value.replacing(hour: _con.selectedEndTime.value.hour  + (value - _con.selectedEndTime.value.hour).toInt(),minute: _con.selectedEndTime.value.minute)
                  }:{
                    _con.selectedEndTime.value = _con.selectedEndTime.value.replacing(hour: _con.selectedEndTime.value.hour  - ( _con.selectedEndTime.value.hour - value ).toInt(),minute: _con.selectedEndTime.value.minute)
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