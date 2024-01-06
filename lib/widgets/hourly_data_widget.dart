// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pert6/controlers/global_controler.dart';
import 'package:pert6/model/weather_data_hourly.dart';
import 'package:pert6/utils/costum_colors.dart';

class HourlyDataWidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;
  HourlyDataWidget({Key? key, required this.weatherDataHourly})
      : super(key: key);

  // card index

  final RxInt cardIndex = GlobalControler().getIndex();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: const Text(
            "Today",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        ),
        hourlyList(),
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 160,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,

        //jika datanya lebih besar 12, maka ambil 20 data
        // ini adalah tampilan yang ditengah
        itemCount: weatherDataHourly.hourly.length > 12
            ? 20
            : weatherDataHourly.hourly.length,
        itemBuilder: (context, index) {
          return Obx(
            (() => GestureDetector(
                  onTap: () {
                    cardIndex.value = index;
                  },
                  child: Container(
                    width: 90,
                    margin: const EdgeInsets.only(left: 20, right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.5, 0),
                          blurRadius: 30,
                          spreadRadius: 1,
                          color: CostumeColors.dividerLine.withAlpha(150),
                        ),
                      ],
                      gradient: cardIndex.value == index
                          ? const LinearGradient(
                              colors: [
                                CostumeColors.firstGradientColor,
                                CostumeColors.secondGradientColor,
                              ],
                            )
                          : null,
                    ),
                    child: HourlyDetails(
                        index: index,
                        cardIndex: cardIndex.toInt(),
                        temp: weatherDataHourly.hourly[index].temp!,
                        timeStamp: weatherDataHourly.hourly[index].dt!,
                        weatherIcon:
                            weatherDataHourly.hourly[index].weather![0].icon!),
                  ),
                )),
          );
        },
      ),
    );
  }
}

//hourly detail class

class HourlyDetails extends StatelessWidget {
  final int temp;
  final int index;
  final int cardIndex;
  final int timeStamp;
  final String weatherIcon;

  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat('jm').format(time);
    return x;
  }

  const HourlyDetails(
      {Key? key,
      required this.cardIndex,
      required this.index,
      required this.temp,
      required this.timeStamp,
      required this.weatherIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            getTime(timeStamp),
            style: TextStyle(
              color: cardIndex == index
                  ? Colors.white
                  : CostumeColors.textColorBlack,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Image.asset(
            "assets/weather/$weatherIcon.png",
            height: 40,
            width: 40,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(
            "$temp",
            style: TextStyle(
              color: cardIndex == index
                  ? Colors.white
                  : CostumeColors.textColorBlack,
            ),
          ),
        )
      ],
    );
  }
}
