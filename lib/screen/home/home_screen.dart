import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sleeptracker/helpers/colors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'controller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final _con = Get.put(HomeController());
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text("Sleep Tracker"),
        centerTitle: true,
        backgroundColor: secondaryColor,
        elevation: 0.0,
        toolbarHeight: 60,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              end: Alignment(0.0, -1),
              begin: Alignment(0.0, 0.8),
            colors: [
              primaryDarkColor,
              primaryColor
            ]
          )
        ),
        child: Column(
          children: [
            40.height,
            Row(
              children: [
                roundIconButton(context,Icons.alarm),
                Expanded(child: Container()),
                roundIconButton(context,Icons.stacked_bar_chart)
              ],
            ),
            Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height *0.35,
                child: Obx(() {
                    return SfRadialGauge(
                        enableLoadingAnimation: true, animationDuration: 4500,
                        axes: <RadialAxis>[
                          RadialAxis(minimum: 2,maximum: 10,
                              showLabels: false,
                              showTicks: false,
                              ranges: <GaugeRange>[
                                GaugeRange(startValue: 2,endValue: _con.barPointerValue.value,color: borderColor,startWidth: 10,endWidth: 10,),
                                GaugeRange(startValue: _con.barPointerValue.value,endValue: 10,color: unBorderColor,startWidth: 10,endWidth: 10),],
                              // pointers: const <GaugePointer>[NeedlePointer(value:8, )],
                              pointers: const <GaugePointer>[MarkerPointer(value: 8,
                                  markerType: MarkerType.text, text: 'Average',
                                  textStyle: GaugeTextStyle(fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic)
                              )],
                              annotations: const <GaugeAnnotation>[
                                GaugeAnnotation(widget: Text('Total Time Sleep',style: TextStyle(fontSize: 15,fontWeight:FontWeight.w700,color: Colors.white)),
                                    angle: 90,positionFactor: 0.9)]
                          )]
                    );
                  }
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.04,
                left: MediaQuery.of(context).size.width * 0.25,
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.28,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/images/moon2.gif'),fit: BoxFit.cover)
                    ),
                  ),
                ),
              )
            ],
          ),
            Row(
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
                    Obx(
                        () {
                        return Text(_con.selectedEndTime.value.format(context),style: const TextStyle(color: Colors.white,fontSize: 22),);
                      }
                    ),
                    Expanded(child: Container()),
                  ],),
                ),
              )
            ],
          ),
            40.height,
            const Text("Average Sleeping Hours",style: TextStyle(color: Colors.white,fontSize: 15),),
            10.height,
            Padding(
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
                          setState(() {
                            _con.barPointerValue.value = value;
                          });
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
            ),
          ],
        ),
      ),
    );
  }

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
}
