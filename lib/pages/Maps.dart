// Maps.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};

  // 남한의 위도/경도 경계
  static final LatLngBounds southKoreaBounds = LatLngBounds(
    southwest: LatLng(33.0, 125.0), // 남한의 남서쪽 끝점
    northeast: LatLng(38.0, 129.5), // 남한의 북동쪽 끝점 (38도선 이남)
  );

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    // 지도가 생성되면 남한 영역으로 카메라 이동
    controller
        .animateCamera(CameraUpdate.newLatLngBounds(southKoreaBounds, 50.0));
  }

  void _handleTap(LatLng tappedPoint) async {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          infoWindow: InfoWindow(
            title: '선택한 위치',
            snippet:
                '위도: ${tappedPoint.latitude}, 경도: ${tappedPoint.longitude}',
          ),
        ),
      );
    });

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        tappedPoint.latitude,
        tappedPoint.longitude,
        localeIdentifier: 'ko_KR',
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String address =
            '${place.country ?? ''} ${place.administrativeArea ?? ''} ${place.locality ?? ''} ${place.subLocality ?? ''} ${place.thoroughfare ?? ''} ${place.name ?? ''}';
        print('변환된 주소: $address');
        _sendLocationDataToBackend(
            tappedPoint.latitude, tappedPoint.longitude, address);
      } else {
        print('주소를 찾을 수 없습니다.');
        _sendLocationDataToBackend(
            tappedPoint.latitude, tappedPoint.longitude, '');
      }
    } catch (e) {
      print('Geocoding 에러: $e');
      _sendLocationDataToBackend(
          tappedPoint.latitude, tappedPoint.longitude, '');
    }
  }

  Future<void> _sendLocationDataToBackend(
      double latitude, double longitude, String address) async {
    final url = Uri.parse('백엔드 API 엔드포인트'); // 실제 백엔드 API 엔드포인트로 변경
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
      }),
    );

    if (response.statusCode == 200) {
      print('위치 정보 (좌표 및 주소)가 백엔드에 성공적으로 전송되었습니다.');
    } else {
      print('위치 정보 전송 실패: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      mapType: MapType.satellite, // 위성 사진 모드로 설정
      initialCameraPosition: CameraPosition(
        target: LatLng(35.907757, 127.766922), // 남한의 중심점
        zoom: 20, // 줌 레벨을 15.0에서 7.5로 수정
      ),
      markers: _markers,
      onTap: _handleTap,
      zoomControlsEnabled: true,
      minMaxZoomPreference: MinMaxZoomPreference(6.0, 18.0),
      cameraTargetBounds:
          CameraTargetBounds(southKoreaBounds), // 카메라 이동 범위를 남한으로 제한
    );
  }
}
