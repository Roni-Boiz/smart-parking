import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_app/Models/parking_place_model.dart';
import 'package:mobile_app/configs/themes/app_icons.dart';
import 'package:mobile_app/services/location_service.dart';

const LatLng SOURCE_LOCATION = LatLng(6.894070, 79.902481);
const LatLng DEST_LOCATION = LatLng(6.927079, 79.861244);
const double CAMERA_ZOOM = 16;
const double CAMARA_TILT = 80;
const double CAMERA_BEARING = 30;

class GoogleMaps extends StatefulWidget {
  final List<ParkingPlaceModel> allPlaces;
  const GoogleMaps({Key? key, required this.allPlaces}) : super(key: key);

  @override
  State<GoogleMaps> createState() => MapState();
}

class MapState extends State<GoogleMaps> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  final TextEditingController _searchController = TextEditingController();

  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
  final Set<Marker> _markers = Set<Marker>();
  Set<Polyline> _polylines = Set<Polyline>();
  Set<Polygon> _polygons = Set<Polygon>();
  List<LatLng> polygonLatLngs = <LatLng>[];

  int _polygonIdCounter = 1;
  int _polylineIdCounter = 1;

  late LatLng currentLocation;
  late LatLng destinationLocation;
  late List<ParkingPlaceModel> allPlaces;

  @override
  void initState() {
    super.initState();
    allPlaces = widget.allPlaces;

    // setup initial locations
    setInitialLocation();

    // setup the marker icons
    setSourceAndDestinationMarkerIcons();
  }

  void setInitialLocation() {
    currentLocation = LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude);
    destinationLocation = LatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude);
  }

  void setSourceAndDestinationMarkerIcons() async{
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.0),
        'assets/images/source_pin.png'
    );

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.0),
        'assets/images/destination_pin.png'
    );
  }

  // created method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR"+error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  static const Marker _kGooglePlexMarker = Marker(
      markerId: MarkerId('_kGooglePlex'),
      infoWindow: InfoWindow(title: 'Google Plex'),
      icon: BitmapDescriptor.defaultMarker,
      position: SOURCE_LOCATION
  );

  static const Polyline _kPolyLine = Polyline(
    polylineId : PolylineId('_kPolyLine'),
    points: [SOURCE_LOCATION, DEST_LOCATION],
    width: 5,
  );

  static const Polygon _kPolygon = Polygon(
    polygonId : PolygonId('_kPolygon'),
    points: [SOURCE_LOCATION, DEST_LOCATION],
    strokeWidth: 5
  );

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('marker'),
          position: point,
        ),
      );
    });
  }

  void _setPolygon() {
    final String polygonIdVal = 'polygon_$_polygonIdCounter';
    _polygonIdCounter++;

    _polygons.add(
      Polygon(
        polygonId: PolygonId(polygonIdVal),
        points: polygonLatLngs,
        strokeWidth: 2,
        fillColor: Colors.transparent,
      ),
    );
  }

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 2,
        color: Colors.blue,
        points: points
            .map(
              (point) => LatLng(point.latitude, point.longitude),
        )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    CameraPosition initialCameraPosition = const CameraPosition(
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION,
        tilt: CAMARA_TILT,
        zoom: CAMERA_ZOOM
    );

    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _searchController,
                  textCapitalization: TextCapitalization.words,
                  cursorColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: AppIcons.fontFam,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Search a place',
                    border: InputBorder.none,
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                  onChanged: (value) {
                    print(value);
                  },
                ),
              ),
              IconButton(onPressed: () async {
                var place = await LocationService().getPlace(_searchController.text);
                _goToPlace(place);
                // var direction = await LocationService().getDirections(
                //   currentLocation, _searchController.text
                // );
                // _goToPlace(direction['start_location']['lat'], direction['end_location']['lng']);
              }, icon: const Icon(Icons.search))
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: GoogleMap(
                    mapType: MapType.normal,
                    // polylines: {_kPolyLine},
                    markers: _markers,
                    tiltGesturesEnabled: true,
                    compassEnabled: false,
                    myLocationEnabled: true,
                    initialCameraPosition: initialCameraPosition,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      showPinsOnMap();
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToPlace(
    Map<String, dynamic> place,
    // double lat,
    // double lng,
    // Map<String, dynamic> boundsNe,
    // Map<String, dynamic> boundsSw,
    ) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12),
      ),
    );

    // controller.animateCamera(
    //   CameraUpdate.newLatLngBounds(
    //     LatLngBounds(
          // southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
          // northeast: LatLng(boundsNe['lat'], boundsNe['lng']),
    //     ),
    //     25),
    // );
    _setMarker(LatLng(lat, lng));
  }

  void showPinsOnMap() {
    setState(() {
      for(var place in allPlaces) {
        _markers.add(Marker(
          markerId: MarkerId(place.id),
          infoWindow: InfoWindow(title: place.name),
          position: LatLng(place.location.latitude!, place.location.longitude!),
          icon: BitmapDescriptor.defaultMarker
        ));
      }
      _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        infoWindow: InfoWindow(title: 'Location 1'),
        position: currentLocation,
        icon: BitmapDescriptor.defaultMarker
      ));

      _markers.add(Marker(
          markerId: MarkerId('destinationPin'),
          infoWindow: InfoWindow(title: 'Location 2'),
          position: destinationLocation,
          icon: BitmapDescriptor.defaultMarker
      ));
    });
  }
}