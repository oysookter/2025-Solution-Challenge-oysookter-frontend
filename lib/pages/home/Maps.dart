import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapWidget extends StatefulWidget {
  final Function(double, double) onLocationSelected;

  const MapWidget({Key? key, required this.onLocationSelected})
      : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};
  final Set<Circle> _circles = {};
  final Set<GroundOverlay> _groundOverlays = {};

  double _currentZoom = 7.0;

  static final LatLngBounds southKoreaBounds = LatLngBounds(
    southwest: LatLng(33.0, 125.0),
    northeast: LatLng(38.0, 129.5),
  );

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    controller
        .animateCamera(CameraUpdate.newLatLngBounds(southKoreaBounds, 50.0));
    mapController.getZoomLevel().then((zoom) {
      setState(() {
        _currentZoom = zoom;
      });
    });
  }

  Future<String> _getEnglishAddress(double lat, double lng) async {
    final apiKey = 'AIzaSyC8FQqrlc8qU6FH4_dc5Vk9sQxM-RV3Gis';
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&language=en&key=$apiKey');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null && data['results'].isNotEmpty) {
          return data['results'][0]['formatted_address'];
        }
      }
      return 'Address not found';
    } catch (e) {
      return 'Error getting address';
    }
  }

  void _handleTap(LatLng tappedPoint) async {
    final markerId = MarkerId(tappedPoint.toString());

    final englishAddress = await _getEnglishAddress(
      tappedPoint.latitude,
      tappedPoint.longitude,
    );

    setState(() {
      _markers.clear();
      _circles.clear();

      _markers.add(
        Marker(
          markerId: markerId,
          position: tappedPoint,
          infoWindow: InfoWindow(
            title: 'Selected Location',
            snippet: englishAddress,
          ),
        ),
      );

      _circles.add(
        Circle(
          circleId: CircleId('radius_circle'),
          center: tappedPoint,
          radius: 10000,
          fillColor: Colors.transparent,
          strokeColor: Color(0xFFCF5445),
          strokeWidth: 3,
        ),
      );

      _circles.add(
        Circle(
          circleId: CircleId('outer_circle'),
          center: tappedPoint,
          radius: 25000,
          strokeWidth: 0,
        ),
      );
    });

    await Future.delayed(Duration(milliseconds: 100));
    mapController.showMarkerInfoWindow(markerId);

    await mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: tappedPoint,
          zoom: _currentZoom,
        ),
      ),
    );

    widget.onLocationSelected(
      tappedPoint.latitude.truncateToDouble(),
      tappedPoint.longitude.truncateToDouble(),
    );
  }

  Future<void> _sendLocationDataToBackend(
      double latitude, double longitude, String address) async {
    final url = Uri.parse('백엔드 API 엔드포인트');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      mapType: MapType.satellite,
      initialCameraPosition: CameraPosition(
        target: LatLng(35.907757, 127.766922),
        zoom: 7.0,
      ),
      markers: _markers,
      circles: _circles,
      onTap: _handleTap,
      zoomControlsEnabled: true,
      zoomGesturesEnabled: true,
      minMaxZoomPreference: MinMaxZoomPreference(5.0, 18.0),
      cameraTargetBounds: CameraTargetBounds(southKoreaBounds),
      scrollGesturesEnabled: true,
      tiltGesturesEnabled: true,
      rotateGesturesEnabled: true,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      onCameraMove: (CameraPosition position) {
        _currentZoom = position.zoom;
      },
    );
  }
}
