import 'package:http/http.dart' as http;
import 'dart:convert';

class Network{
  final String url;
  Network(this.url);

  Future<dynamic> getJsonData() async {
    var myjson;

    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      myjson = jsonDecode(jsonData);
      return myjson;
    }
  }
}