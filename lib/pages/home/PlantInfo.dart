import 'package:flutter/material.dart';

class PlantInfo extends StatelessWidget {
  // 임시 식물 데이터
  final List<Map<String, String>> plants = [
    {
      'name': '소나무',
      'image': 'assets/img/niceday.jpeg',
      'description': 'AI 설명 요약 ~~~~~~~~'
    }, // assets 폴더에 이미지 필요
    {
      'name': '느티나무',
      'image': 'assets/img/potato.jpeg',
      'description':
          'AI 설명 요약 ~~~~~~~~AI 설명 요약 ~~~~~~~~AI 설명 요약 ~~~~~~~~AI 설명 요약 ~~~~~~~~AI 설명 요약 ~~~~~~~~AI 설명 요약 ~~~~~~~~AI 설명 요약 ~~~~~~~~AI 설명 요약 ~~~~~~~~AI 설명 요약 ~~~~~~~~AI 설명 요약 ~~~~~~~~AI 설명 요약 ~~~~~~~~'
    },
    {
      'name': '소나무',
      'image': 'assets/img/niceday.jpeg',
      'description': 'AI 설명 요약 ~~~~~~~~'
    },
    {
      'name': '소나무',
      'image': 'assets/img/duck.jpeg',
      'description': 'AI 설명 요약 ~~~~~~~~'
    },
    {
      'name': '소나무',
      'image': 'assets/img/niceday.jpeg',
      'description': 'AI 설명 요약 ~~~~~~~~'
    },
    {
      'name': '소나무',
      'image': 'assets/img/potato.jpeg',
      'description': 'AI 설명 요약 ~~~~~~~~'
    },
    {
      'name': '소나무',
      'image': 'assets/img/niceday.jpeg',
      'description': 'AI 설명 요약 ~~~~~~~~'
    },
  ];

  @override
  Widget build(BuildContext context) {
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
                    child: Image.asset(
                      plants[index]['image'] ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            plants[index]['name'] ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            plants[index]['description'] ?? '',
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
}
