import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:sleeptracker/helpers/colors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../screen/home/controller/home_controller.dart';

class RadialGauge extends StatelessWidget {
  const RadialGauge({
    Key? key,
    required HomeController con,
  }) : _con = con, super(key: key);

  final HomeController _con;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}