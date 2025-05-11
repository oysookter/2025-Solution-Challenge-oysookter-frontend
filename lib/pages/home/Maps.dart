// Maps.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';

class MapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};
  final Set<Circle> _circles = {};
  final Set<GroundOverlay> _groundOverlays = {};

  double _currentZoom = 7.0; // 현재 줌 상태 저장

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
    // 초기 줌 값 저장
    mapController.getZoomLevel().then((zoom) {
      setState(() {
        _currentZoom = zoom;
      });
    });
  }

  void _handleTap(LatLng tappedPoint) async {
    final markerId = MarkerId(tappedPoint.toString());

    // 주소 정보 받아오기
    List<Placemark> placemarks = await placemarkFromCoordinates(
      tappedPoint.latitude,
      tappedPoint.longitude,
      localeIdentifier: 'ko_KR',
    );

    String? province;
    String? city;
    String? subLocality;
    String? thoroughfare;
    String? name;
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      province = place.administrativeArea; // ex) '경기도'
      city = place.locality; // ex) '수원시'
      subLocality = place.subLocality; // ex) '영통구'
      thoroughfare = place.thoroughfare; // ex) '영통로'
      name = place.name; // ex) '123번길'
    }

    setState(() {
      _markers.clear();
      _circles.clear();

      _markers.add(
        Marker(
          markerId: markerId,
          position: tappedPoint,
          infoWindow: InfoWindow(
            title: '선택한 위치',
            snippet: [province, city, subLocality, thoroughfare, name]
                .where((s) => s != null && s.isNotEmpty)
                .join(' '),
          ),
        ),
      );

      // 10km 반경의 원 추가
      _circles.add(
        Circle(
          circleId: CircleId('radius_circle'),
          center: tappedPoint,
          radius: 10000, // 10km in meters
          fillColor: Colors.transparent,
          strokeColor: Color(0xFFCF5445),
          strokeWidth: 3,
        ),
      );

      // 원 내부
      _circles.add(
        Circle(
          circleId: CircleId('outer_circle'),
          center: tappedPoint,
          radius: 25000, // 25km 반경과 동일하게 설정
          //fillColor: Colors.grey.withOpacity(0.7),
          strokeWidth: 0,
        ),
      );
    });

    // 마커 InfoWindow를 바로 띄우기
    await Future.delayed(Duration(milliseconds: 100));
    mapController.showMarkerInfoWindow(markerId);

    // 1. 카메라를 클릭한 위치로 이동 및 확대
    await mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: tappedPoint,
          zoom: _currentZoom, // 마지막 줌 상태 유지
        ),
      ),
    );

    // // 2. 마커가 지도 상단에 오도록 지도 스크롤
    // await mapController.moveCamera(
    //   CameraUpdate.scrollBy(0, 100), // -150~ -200 등으로 조정
    // );

    try {
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
      mapType: MapType.satellite,
      initialCameraPosition: CameraPosition(
        target: LatLng(35.907757, 127.766922),
        zoom: 7.0, // 초기 줌 레벨을 7.0으로 조정
      ),
      markers: _markers,
      circles: _circles,
      onTap: _handleTap,
      zoomControlsEnabled: true,
      zoomGesturesEnabled: true,
      minMaxZoomPreference: MinMaxZoomPreference(5.0, 18.0), // 줌 범위 조정
      cameraTargetBounds: CameraTargetBounds(southKoreaBounds),
      scrollGesturesEnabled: true,
      tiltGesturesEnabled: true,
      rotateGesturesEnabled: true,
      myLocationEnabled: true, // 현재 위치 표시 활성화
      myLocationButtonEnabled: true, // 현재 위치 버튼 활성화
      onCameraMove: (CameraPosition position) {
        _currentZoom = position.zoom;
      },
    );
  }
}
