import 'package:maps_launcher/maps_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

void main() {
  runApp(ScheduleApp());
}

class ScheduleApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: ScheduleWidget(title: 'Flutter Demo Home Page'),
    );
  }
}

class ScheduleWidget extends StatefulWidget {
  ScheduleWidget({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _ScheduleWidgetState createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  int _currentIndex = 0;
  double lat = 43.0;
  double lon = 29.0;

  Widget getTab(index) {
    switch (index) {
      case 0:
        {
          return getInfo();
        }
      case 1:
        {
          return getSchedule();
        }
      case 2:
        {
          return getContacts();
        }
    }
    return Center(child: Text("Неизвестна страница.")); // Default page
  }

  Widget getInfo() {
    return Center(
      child: new Container(
        child: Text("Във клуба"),
      ),
    );
  }

  Widget getSchedule() {
    return Center(
      child: new Container(
        child: Text("График"),
      ),
    );
  }

  GlobalKey<OSMFlutterState> osmKey = GlobalKey<OSMFlutterState>();

  Widget getContacts() {
    var col = new Column(
      children: <Widget>[
        Expanded(
            child: OSMFlutter(
          key: osmKey,
          currentLocation: false,
          road: Road(
            startIcon: MarkerIcon(
              icon: Icon(
                Icons.person,
                size: 64,
                color: Colors.brown,
              ),
            ),
            roadColor: Colors.red,
          ),
          markerIcon: MarkerIcon(
            icon: Icon(
              Icons.assistant_photo,
              color: Colors.blue,
              size: 80,
            ),
          ),
          initPosition: GeoPoint(latitude: 42.151753, longitude: 24.769730),
          showZoomController: true,
          trackMyPosition: false,
        )),
        IconButton(
          icon: Icon(Icons.ac_unit),
          onPressed: () {
//            goToLocation();
            MapsLauncher.launchCoordinates(42.151753, 24.769730);
          },
        )
      ],
    );

//    osmKey.currentState.changeLocation(
//        GeoPoint(latitude: 42.151753, longitude: 24.769730));

    return col;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: getTab(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        selectedFontSize: 16,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            title: Text('За клуба'),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            title: Text('График'),
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_location),
            title: Text('Контакти'),
            backgroundColor: Colors.purple,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
