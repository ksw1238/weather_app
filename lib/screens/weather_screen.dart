import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/model.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({this.parseWeatherData, this.parsePollutionData});
  final parseWeatherData;
  final parsePollutionData;

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Model model = Model();
  String cityName ='';
  var icon;
  var aqi_icon;
  double pm10 = 0.0;
  double pm2_5 = 0.0;
  String desc = '';
  int temp = 0;
  var date = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateData(widget.parseWeatherData, widget.parsePollutionData);
  }

  void updateData(dynamic weatherData, dynamic pollutionData) {
    // Weather Data
    double temp2 = 0.0;
    cityName = weatherData['name'];
    temp2 = weatherData['main']['temp'];
    int condition = weatherData['weather'][0]['id'];
    temp = temp2.round();
    icon = model.getWeatherIcon(condition);
    desc = weatherData['weather'][0]['description'];

    // AirPollution
    pm10 = pollutionData['list'][0]['components']['pm10'];
    pm2_5 = pollutionData['list'][0]['components']['pm2_5'];
    int aqi = pollutionData['list'][0]['main']['aqi'];
    aqi_icon = model.getPollutionIcon(aqi);

    print(pm10);
    print(pm2_5);
  }

  String getSystemTime(){
    var now = DateTime.now();
    return DateFormat("h:mm a").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(''),
        leading: IconButton(
          icon: Icon(Icons.near_me),
          onPressed: (){},
          iconSize: 30,
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.location_searching),
            iconSize: 30,)
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset('image/background.jpg', fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,),
            Container(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  Text('$cityName', style: GoogleFonts.lato(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      TimerBuilder.periodic(
                        Duration(minutes: 1),
                        builder: (context){
                          return Text(
                            getSystemTime(),
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              color: Colors.white
                            ),
                          );
                      },
                      ),
                      Text(
                        DateFormat(' - EEEE, ').format(date),
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          color: Colors.white
                        ),
                      ),
                      Text(
                        DateFormat('d MMM, yyy').format(date),
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 70,),
                  Text('$temp\u2103', style: GoogleFonts.lato(
                    fontSize: 85,
                    color: Colors.white
                  ),
                  ),
                  SizedBox(height: 0,),
                  Row(
                    children: [
                      icon,
                      SizedBox(width: 10,),
                      Text('$desc',
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            color: Colors.white
                          ),)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,50,0,40),
                    child: Divider(
                      height: 15,
                      thickness: 3,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('AQI(대기질 지수)', style: GoogleFonts.lato(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      )
                      ),
                      Text('미세먼지', style: GoogleFonts.lato(
                        color: Colors.white,
                          fontWeight: FontWeight.bold
                      )),
                      Text('초미세먼지', style: GoogleFonts.lato(
                        color: Colors.white,
                          fontWeight: FontWeight.bold
                      ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        aqi_icon,
                        Text('$pm10', style: GoogleFonts.lato(
                          fontSize: 25,
                          color: Colors.white,
                            fontWeight: FontWeight.bold
                        )),
                        Text('$pm2_5', style: GoogleFonts.lato(
                          fontSize: 25,
                          color: Colors.white,
                            fontWeight: FontWeight.bold
                        )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('"매우나쁨"', style: GoogleFonts.lato(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        )
                        ),
                        Text('μg/m3', style: GoogleFonts.lato(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        )),
                        Text('μg/m3', style: GoogleFonts.lato(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ))
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
