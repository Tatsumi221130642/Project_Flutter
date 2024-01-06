import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pert6/controlers/global_controler.dart';
import 'package:pert6/pages/home_page.dart';
import 'package:pert6/widgets/current_weather_widget.dart';
import 'package:pert6/widgets/daily_data_forecats.dart';
import 'package:pert6/widgets/header_widget.dart';
import 'package:pert6/widgets/hourly_data_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // call controler
  final GlobalControler globalControler =
      Get.put(GlobalControler(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
        Obx(
          () => globalControler.checkLoading().isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const HeaderWidget(),
                      // for our current temp ('curent')
                      CurrentWeatherWidget(
                        weatherDataCurrent:
                            globalControler.getData().getCurrentWeather(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      HourlyDataWidget(
                          weatherDataHourly:
                              globalControler.getData().getHourlyWeather()),
                      DailyDataForecast(
                        weatherDataDaily:
                            globalControler.getData().getDailyWeather(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          },
                          child: const Text('Kembali'),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
