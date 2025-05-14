// HomePage.dart
import 'package:flutter/material.dart';
import 'Maps.dart';
import 'DamageInfo.dart';
import 'PlantInfo.dart';
import '../../services/api_service.dart';
import '../../models/summary_response.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();
  double _sheetSize = 0.5;
  final ApiService _apiService = ApiService();
  SummaryResponse? _summaryData;
  bool _isLoading = false;

  Future<void> _fetchSummaryData(double lat, double lon) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final summaryData = await _apiService.getSummary(lat, lon);
      setState(() {
        _summaryData = summaryData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('데이터를 불러오는데 실패했습니다: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _sheetController.addListener(() {
      setState(() {
        _sheetSize = _sheetController.size;
      });
    });
  }

  @override
  void dispose() {
    _sheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapWidget(onLocationSelected: _fetchSummaryData),
          DraggableScrollableSheet(
            controller: _sheetController,
            initialChildSize: 0.5,
            minChildSize: 0.1,
            maxChildSize: 0.95,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ListView(
                        controller: scrollController,
                        children: [
                          SizedBox(height: 12),
                          Center(
                            child: Container(
                              width: 40,
                              height: 6,
                              decoration: BoxDecoration(
                                color: Color(0xFFCF5445),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                          if (_summaryData == null)
                            Container(
                              height: 300,
                              child: Center(
                                child: Text(
                                  '확인하고 싶은 지도의 위치를 선택하세요.',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                          else ...[
                            DamageInfo(summaryData: _summaryData),
                            SizedBox(height: 10),
                            Container(
                              height: 450,
                              child: PlantInfo(summaryData: _summaryData),
                            ),
                          ],
                        ],
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
