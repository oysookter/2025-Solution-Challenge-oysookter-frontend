import 'package:flutter/material.dart';
import '../../models/summary_response.dart';
import 'dart:convert';

class PlantInfo extends StatelessWidget {
  final SummaryResponse? summaryData;

  const PlantInfo({Key? key, this.summaryData}) : super(key: key);

  String _decodeImageUrl(String url) {
    try {
      // URL 디코딩 시도
      return Uri.decodeFull(url);
    } catch (e) {
      return url;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (summaryData == null) {
      return Container(
        height: 450,
        child: Center(
          child: Text(
            '식물 정보를 불러오는 중입니다...',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
        ),
      );
    }

    final plants = [
      summaryData!.vegetationInfo.vegetation.veg1,
      summaryData!.vegetationInfo.vegetation.veg2,
      summaryData!.vegetationInfo.vegetation.veg3,
    ];

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      children: [
        Container(
          margin: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Plants suitable 🌱\nfor growing in this region',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    height: 1.0,
                  ),
                  maxLines: 2,
                  softWrap: true,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
        SizedBox(height: 2.0),
        ...List.generate(plants.length, (index) {
          final plant = plants[index];
          final decodedImageUrl =
              plant.image != null ? _decodeImageUrl(plant.image!) : null;

          return Container(
            margin: EdgeInsets.only(
              top: index == 0 ? 16.0 : 8.0,
              bottom: index == plants.length - 1 ? 16.0 : 8.0,
              left: 8.0,
              right: 8.0,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF0F0),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: Color(0xFFCF5445),
                width: 2.0,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 150.0,
                    height: 130.0,
                    child: plant.image != null
                        ? Image.network(
                            decodedImageUrl!,
                            fit: BoxFit.cover,
                            headers: {
                              'Accept': 'image/*',
                              'User-Agent': 'Mozilla/5.0',
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                color: Colors.grey[200],
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xFFCF5445),
                                    ),
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return _buildDefaultImage();
                            },
                          )
                        : _buildDefaultImage(),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            plant.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            plant.text,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildDefaultImage() {
    return Container(
      color: Colors.grey[200],
      child: Image.asset(
        'assets/img/tree.jpg',
        fit: BoxFit.fill,
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.eco,
                  size: 40,
                  color: Color(0xFFCF5445),
                ),
                SizedBox(height: 8),
                Text(
                  '식물 이미지',
                  style: TextStyle(
                    color: Color(0xFFCF5445),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
