import 'package:flutter/material.dart';
import 'package:weather_app/data/network.dart';
import 'package:weather_app/data/my_location.dart';
import 'package:weather_app/screens/weather_screen.dart';
import 'weather_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apikey = '41b23f5a588faee37ff936bbfdc64ecc';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    var weatherData;
    var airPollution;
    double latitude3 = 0;
    double longitude3 = 0;

    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;

    Network network = Network(
        'https://api.openweathermap.org/data/2.5/weather?lat=${latitude3}&lon=${longitude3}&appid=$apikey&units=metric');
    weatherData = await network.getJsonData();

    Network airnet = Network(
        'http://api.openweathermap.org/data/2.5/air_pollution?lat=${latitude3}&lon=${longitude3}&appid=$apikey');
    airPollution = await airnet.getJsonData();

    Navigator.push(
        context, MaterialPageRoute(
        builder: (context) {
          return WeatherScreen(parseWeatherData: weatherData, parsePollutionData: airPollution,);
        }
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: SpinKitRing(
          color: Colors.white,
          size: 80,
        ),
      ),
    );
  }
}


