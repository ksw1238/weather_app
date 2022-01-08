import 'package:geolocator/geolocator.dart';

class MyLocation{
  double latitude2 = 0;
  double longitude2 = 0;

  Future<void> getMyCurrentLocation() async{
    try {
      LocationPermission permission;

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude2 = position.latitude;
      longitude2 = position.longitude;
    }
    catch(e){
      print('There is a problem');
    }
  }
}