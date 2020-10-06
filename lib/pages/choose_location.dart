import 'package:flutter/material.dart';
import 'package:World_time/services/world_time.dart';
import 'package:load/load.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'chicago.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
    WorldTime(url: 'Africa/Lagos', location: 'Nigeria', flag: 'nigeria.png'),
    WorldTime(url: 'Asia/Dubai', location: 'Dubai', flag: 'dubai.png'),
    WorldTime(url: 'Africa/Tunis', location: 'Tunis', flag: 'tunis.png'),
    WorldTime(url: 'America/Argentina/San_Juan', location: 'Argentina San Juan', flag: 'argentina.png'),
    WorldTime(url: 'America/Mexico_City', location: 'Mexico', flag: 'mexico.png'),
    WorldTime(url: 'Europe/Dublin', location: 'Dublin', flag: 'dublin.png'),
    WorldTime(url: 'Indian/Mauritius', location: 'Mauritius', flag: 'mauritius.png'),
    WorldTime(url: 'Asia/Tokyo', location: 'Tokyo', flag: 'tokyo.png'),
  ];

  void updateTime(index) async {
    try{
      WorldTime instance = locations[index];
      await instance.getTime();

      hideLoadingDialog(); //close dialog

      //navigate to home screen
      Navigator.pop(context, {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'isDaytime': instance.isDaytime,
        'ip': instance.ip,
      });
    } catch (e){
      hideLoadingDialog();
      _onAlertButtonsPressed(context, AlertType.none, 'Network Error', 'OOP! unable to connect...');
    }
  }


_onAlertButtonsPressed(context, type, title, body) {
    Alert(
      context: context,
      type: type,
      title: title,
      desc: body,
      buttons: [
        DialogButton(
          child: Text(
            "Close",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
          gradient: LinearGradient(colors: [
            Color.fromRGBO(59, 0, 0, 1.0),
            Color.fromRGBO(159, 0, 0, 1.0)
          ]),
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () async {
                  await showLoadingDialog(); //load dialog
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage:
                      AssetImage('images/${locations[index].flag}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
