import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var marker = <Marker>[];
    var marker1 = <Marker>[];

    final points = <LatLng>[
      LatLng(46.829853, -71.254028),
      LatLng(-17.221666, -46.875000),
      LatLng(33.547886, 69.229088),
      LatLng(35.011665, 135.768326),
    ];

    marker = [];

    marker1 = [
      Marker(
        point: LatLng(46.829853, -71.254028),
        builder: (ctx) => Icon(
          Icons.pin_drop,
          color: Colors.blue,
        ),
      ),
      Marker(
        point: LatLng(-17.221666, -46.875000),
        builder: (ctx) => Icon(
          Icons.pin_drop,
          color: Colors.green,
        ),
      ),
      Marker(
        point: LatLng(33.547886, 69.229088),
        builder: (ctx) => Icon(
          Icons.pin_drop,
          color: Colors.red,
        ),
      ),
      Marker(
        point: LatLng(35.011665, 135.768326),
        builder: (ctx) => Icon(
          Icons.pin_drop,
          color: Colors.yellow,
        ),
      ),
    ];

    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              Flexible(
                child: FlutterMap(
                  options: MapOptions(
                    zoom: 1,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayerOptions(
                      markers: marker1,
                    ),
                    PolylineLayerOptions(
                      polylines: [
                        Polyline(
                          points: points,
                          strokeWidth: 2,
                          color: Colors.amber,
                        )
                      ],
                    ),
                    PopupMarkerLayerOptions(),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black,
                  backgroundColor: Colors.amber,
                ),
                child: Text("Where's CS?"),
                onPressed: () {
                  setState(() {
                    marker = marker1;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
