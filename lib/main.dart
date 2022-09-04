import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:wheres_cs/pop_up.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late List<Marker> markers;
  late List<LatLng> points;
  List<Color> colors = [Colors.red, Colors.green, Colors.amber, Colors.black];
  final PopupController popupLayerController = PopupController();

  @override
  void initState() {
    super.initState();
    points = <LatLng>[];
    markers = <Marker>[];
  }

  void loadMap() {
    setState(
      () {
        points.add(LatLng(46.829853, -71.254028));
        points.add(LatLng(-17.221666, -46.875000));
        points.add(LatLng(33.547886, 69.229088));
        points.add(LatLng(35.011665, 135.768326));

        for (int index = 0; index < points.length; index++) {
          markers.add(
            Marker(
              point: points.elementAt(index),
              builder: (context) => Icon(
                Icons.pin_drop,
                color: colors[index],
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              Flexible(
                child: FlutterMap(
                  options: MapOptions(
                    zoom: 1,
                    onTap: ((_, __) => popupLayerController.hideAllPopups()),
                  ),
                  children: [
                    TileLayerWidget(
                      options: TileLayerOptions(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c'],
                      ),
                    ),
                    PolylineLayerWidget(
                      options: PolylineLayerOptions(
                        polylineCulling: false,
                        polylines: [
                          Polyline(
                            points: points,
                            strokeWidth: 2,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                    PopupMarkerLayerWidget(
                      options: PopupMarkerLayerOptions(
                        popupController: popupLayerController,
                        markers: markers,
                        markerRotateAlignment:
                            PopupMarkerLayerOptions.rotationAlignmentFor(
                                AnchorAlign.top),
                        popupBuilder: (BuildContext context, Marker marker) =>
                            ExamplePopup(marker),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  loadMap();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                  minimumSize: const Size.fromHeight(30),
                ),
                child: const Text(
                  "Where's CS?",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
