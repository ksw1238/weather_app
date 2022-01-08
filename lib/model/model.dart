import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Model{
  Widget getWeatherIcon(int condition){
    if (condition < 300){
      return SvgPicture.asset('svg/climacon-cloud_lightning.svg', color: Colors.black,);
    } else if (condition < 600) {
      return SvgPicture.asset('svg/climacon-cloud_rain.svg', color: Colors.black);
    } else if (condition == 800) {
      return SvgPicture.asset('svg/climacon-sun.svg', color: Colors.black);
    } else if (condition <= 804) {
      return SvgPicture.asset('svg/climacon-cloud_sun.svg', color: Colors.black);
    } else {
      return SvgPicture.asset('svg/climacon-cloud_snow.svg', color: Colors.black);
    }
  }

  Widget getPollutionIcon(int aqi) {
    switch(aqi) {
      case 1 : { return Image.asset('image/good.png', height: 50, width: 90,); }
        break;
      case 2 : { return Image.asset('image/fair.png', height: 50, width: 90,); }
        break;
      case 3 : { return Image.asset('image/moderate.png', height: 50, width: 90,); }
        break;
      case 4 : { return Image.asset('image/poor.png', height: 50, width: 90,); }
        break;
      case 5 : { return Image.asset('image/bad.png', height: 50, width: 90,); }
        break;
      default: { return Image.asset('image/bad.png', height: 50, width: 90,); }
    }
  }
}