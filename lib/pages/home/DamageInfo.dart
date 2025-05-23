import 'package:flutter/material.dart';
import '../../models/summary_response.dart';

class DamageInfo extends StatelessWidget {
  final SummaryResponse? summaryData;

  const DamageInfo({Key? key, this.summaryData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (summaryData == null) {
      return Container(
        height: 120,
        child: Center(
          child: Text(
            '피해 정보를 불러오는 중입니다...',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildInfoBox(
            'Extent of damage',
            '${summaryData!.damage.toStringAsFixed(1)}%',
          ),
          _buildInfoBox(
            'Estimated recovery rate',
            '${summaryData!.recoveryInfo.recovery.recoveryRate.toStringAsFixed(1)}%',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(String title, String value) {
    return Container(
      width: 160,
      height: 120,
      decoration: BoxDecoration(
        color: Color(0xFFFFF3F3),
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(
          color: Color(0xFFB85C4C),
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
            color: Color(0xFFB85C4C),
          ),
          Expanded(
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 26.0,
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
