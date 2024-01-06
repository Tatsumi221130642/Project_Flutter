import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pert6/controlers/global_controler.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  //membuat variabel city untuk menampung nama lokasi
  String city = "";

  //Date
  String date = DateFormat("yMMMMd").format(DateTime.now());

  //memanggil controler untuk dipakai buat longitude dan lattitude
  final GlobalControler globalControler =
      Get.put(GlobalControler(), permanent: true);

  @override
  void initState() {
    getAddress(globalControler.getLattitude().value,
        globalControler.getLongitude().value);
    // TODO: implement initState
    super.initState();
  }

  // Untuk mendapat lokasi jika menekan izin
  getAddress(lat, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemark[0]; //magic number
    setState(() {
      city = place.locality!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //Mengatur tata letak nama lokasi dilayar
          margin: const EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: Text(
            city,
            style: const TextStyle(
              fontSize: 28,
              height: 2,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          //Mengatur tata letak nama lokasi dilayar
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          alignment: Alignment.topLeft,
          child: Text(
            date,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
