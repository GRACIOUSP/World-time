import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    print(data);

    //set background
    String bgImage = data['isDaytime'] ? 'day3.png' : 'night2.png';
    Color bgColor = data['isDaytime'] ? Colors.blue[800] : Colors.blueGrey[900];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/$bgImage'), fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: [
                FlatButton.icon(
      
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDaytime': result['isDaytime'],
                        'flag': result['flag'],
                        'ip': result['ip'],
                      };
                    });
                  },
                  
                  color: Colors.grey[800],

                  icon: Icon(
                    Icons.edit_location, 
                    color: Colors.grey[300]
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/${data['flag']}'),
                      radius: 16.0,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      data['location'],
                      style: TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                          color: Colors.white),
                    ),
                  ],
                ),
                
                SizedBox(height: 20.0),
                Text(
                  data['time'],
                  style: TextStyle(fontSize: 66.0, color: Colors.white),
                ),

                SizedBox(height: 20.0),
                  
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'My IP:',
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 1.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      data['ip'],
                      style: TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 1.0,
                          color: Colors.white),
                    ),
                  ],
                ),
                  
              ],
            ),
          ),
        ),
      ),
    );
  }
}
