import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name for ui
  String time; //location time
  String flag; //url to an asset flag icon
  String url; //location url for api endpoints
  bool isDayTime;

  WorldTime({this.flag, this.location, this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data

      String datetime = data['datetime'];
      String offset = data['utc_offset'];

      // print('$datetime\n$offset');

      //create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(
          hours: int.parse(offset.substring(0, 3)),
          minutes: int.parse(offset.substring(4))));
      print(now);
      isDayTime = (now.hour < 20 && now.hour > 8) ? true : false;
      print(isDayTime);
      time = DateFormat.jm().format(now);
      print(time);
    } catch (e) {
      print('Caught error : $e');
      time = 'Could not get time / data :/';
    }
  }
}
