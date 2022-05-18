import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sleeptracker/helpers/colors.dart';
import 'package:sleeptracker/helpers/linear_gauge.dart';
import 'package:sleeptracker/helpers/radial_gauge.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../helpers/timer_row.dart';
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
                _con.roundIconButton(context,Icons.alarm),
                Expanded(child: Container()),
                _con.roundIconButton(context,Icons.stacked_bar_chart)
              ],
            ),
            RadialGauge(con: _con),
            TimePickerRow(con: _con),
            40.height,
            Obx(
                () {
                return Text(_con.sleepingHourTitle(),style: const TextStyle(color: Colors.white,fontSize: 15),);
              }
            ),
            10.height,
            linearGauge(_con),
          ],
        ),
      ),
    );
  }

}
