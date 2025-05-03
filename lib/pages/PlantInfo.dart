import 'package:flutter/material.dart';

class PlantInfo extends StatelessWidget {
  // 임시 식물 데이터
  final List<Map<String, String>> plants = [
    {
      'name': '소나무',
      'image': 'assets/niceday.jpeg',
      'description': 'AI 설명 요약 ~~~~~~~~'
    }, // assets 폴더에 이미지 필요
    {
      'name': '느티나무',
      'image': 'assets/potato.jpeg',
      'description': 'AI 설명 요약 ~~~~~~~~'
    },
    {
      'name': '은행나무',
      'image': 'assets/duck.jpeg',
      'description': 'AI 설명 요약 ~~~~~~~~'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '이 지역에 심을 수 있는 식물',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              height: 1.0,
            ),
          ),
          SizedBox(height: 1.0),
          Expanded(
            child: ListView.builder(
              itemCount: plants.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.red.shade400,
                      width: 2.0,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 120.0,
                          height: 90.0,
                          child: Image.asset(
                            plants[index]['image']!,
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
                                  plants[index]['name']!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  plants[index]['description']!,
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
