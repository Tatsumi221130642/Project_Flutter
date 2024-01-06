import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pert6/api/fetch_weather.dart';
import 'package:pert6/model/weather_data.dart';

class GlobalControler extends GetxController {
  // Membuat various variabel
  final RxBool _isLoading = true.obs;
  final RxDouble _lattitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;

  RxBool checkLoading() => _isLoading;
  RxDouble getLattitude() => _lattitude;
  RxDouble getLongitude() => _longitude;

  final weatherData = WeatherData().obs;
  
  WeatherData getData(){
    return weatherData.value;
  }

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
    } else {
      getIndex();
    }
    super.onInit();
  }

  getLocation() async {
    bool isServiceEanabled;
    LocationPermission locationPermission;

    isServiceEanabled = await Geolocator.isLocationServiceEnabled();
    
    // return if service is not enable
    if (!isServiceEanabled) {
      return Future.error('Location not enabled');
    }

    // INI ADALAH STATUS PERIZINAN LOKASI
    // Menambahkan 
    //<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    //<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
    // Pada Android manifest untuk mendapatkan izin akses lokasi
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error('Location permission are denied forever');
    } else if (locationPermission == LocationPermission.denied) {
      // request permission
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error('Location permission is denied');
      }
    }

    // getting the currentposition

    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then(
      (value) {
        //update our lattitude and longitude
        _lattitude.value = value.latitude;
        _longitude.value = value.longitude;

        //calling our weather api
        return FetchWeatherAPI().processData(value.latitude, value.longitude)
        .then((value) {
          weatherData.value = value;
          _isLoading.value = false;
        });
       
      },
    );
  }

  //getIndex function
  RxInt getIndex(){
    return _currentIndex;
  }
}
