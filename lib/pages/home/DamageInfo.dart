import 'package:flutter/material.dart';

class DamageInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildInfoBox('Extent of damage', '35%'),
          _buildInfoBox('Estimated recovery rate', '20%'),
        ],
      ),
    );
  }

  Widget _buildInfoBox(String title, String value) {
    return Container(
      width: 160,
      height: 120,
      decoration: BoxDecoration(
        color: Color(0xFFFFF3F3), // 연한 분홍 배경
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(
          color: Color(0xFFB85C4C), // 진한 분홍 테두리
          width: 3.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(top: 14.0, left: 8, right: 8, bottom: 2),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
                fontFamily: 'Pretendard',
                letterSpacing: 0,
                height: 1.2,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            height: 2,
            color: Color(0xFFB85C4C), // 구분선
          ),
          Expanded(
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
