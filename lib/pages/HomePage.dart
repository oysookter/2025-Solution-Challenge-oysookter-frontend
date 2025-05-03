// HomePage.dart
import 'package:flutter/material.dart';
import 'package:oysookter_frontend/pages/Maps.dart';
import 'package:oysookter_frontend/pages/DamageInfo.dart';
import 'package:oysookter_frontend/pages/PlantInfo.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCF5445),
        title: Text(
          '산불 후 회복 모니터링',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4, // 지도가 화면의 5/10 차지
            child: MapWidget(), // Maps.dart에서 만든 지도 위젯
          ),
          Expanded(
            flex: 2, // 피해 정도/예측 복구율 박스가 화면의 2/10 차지
            child: DamageInfo(), // DamageInfoBox.dart에서 만든 위젯
          ),
          Expanded(
            flex: 4, // 식물 정보 리스트가 화면의 3/10 차지
            child: PlantInfo(), // PlantInfoList.dart에서 만든 위젯
          ),
          // 하단 네비게이션 바 (이미지에 따라 추가)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFCF5445),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: '지도',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning),
            label: '경고',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
        ],
      ),
    );
  }
}
