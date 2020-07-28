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
    // print(data);

    String bgImage = data['isDayTime'] ? 'mountains.jpg' : 'Night.jpg';
    Color bgColor = data['isDayTime'] ? Colors.deepPurple[50] : Colors.black;
    Color txtcolor = data['isDayTime'] ? Colors.black : Colors.indigo[50];
    Color loccolor =
        data['isDayTime'] ? Colors.orange[50] : Colors.deepPurple[50];
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/$bgImage'),
          fit: BoxFit.cover,
        )),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
          child: Column(
            children: <Widget>[
              //   FlatButton.icon(

              //   ),
              //   SizedBox(
              //     height: 0.0,
              //   ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data['location'].toString().toUpperCase(),
                    style: TextStyle(
                      fontSize: 30.0,
                      color: txtcolor,
                      // fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                data['time'],
                style: TextStyle(
                  color: txtcolor,
                  fontSize: 60,
                ),
              )
            ],
          ),
        ),
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          dynamic result = await Navigator.pushNamed(context, '/location');
          setState(() {
            data = {
              'time': result['time'],
              'location': result['location'],
              'isDayTime': result['isDayTime'],
              'flag': result['flag'],
            };
          });
        },
        backgroundColor: loccolor,
        icon: Icon(
          Icons.edit_location,
          color: Colors.black,
        ),
        label: Text(
          'Change Location',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
