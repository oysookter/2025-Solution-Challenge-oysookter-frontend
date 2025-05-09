import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pedometer Title
              const SizedBox(height: 16),
              const Text(
                'Pedometer',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Pedometer Card
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3F1),
                  border: Border.all(color: Color(0xFFCF5445), width: 3),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Every step you take\nhelps save the forest',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFCF5445),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/img/footprint.png',
                          width: 80,
                          height: 80,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'step count',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    '1000',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'calories burned\nthrough steps',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    '30kcal',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Donation Title
              const Text(
                'Donation',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Donation Card 1
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFCF5445), width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'Your support can help heal our forests.\nPlease consider donating for wildfire recovery.',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              // Donation Card 2
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFCF5445), width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'Help restore our forests.\nDonate now to support wildfire recovery.',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              // Donation Card 3
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFCF5445), width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'Your contribution makes a difference.\nSupport forest restoration today.',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(height: 32),
              // Join us Title
              const Text(
                'Join us',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // 카드 리스트
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  final titles = [
                    'Rebuild forests, together',
                    'Become a Forest Guardian',
                    'Let\'s grow hope again'
                  ];
                  final descriptions = [
                    'Join hands with fellow volunteers to restore areas affected by wildfires.',
                    'Take a step forward and protect our planet by joining local reforestation efforts.',
                    'Volunteer to plant native trees and help revive biodiversity in damaged regions.'
                  ];
                  return JoinCard(
                    title: titles[index],
                    description: descriptions[index],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Color(0xFFCF5445), width: 2),
            color: Colors.white,
          ),
          child: Center(
            child: Icon(
              Icons.edit,
              color: Color(0xFFCF5445),
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}

class JoinCard extends StatelessWidget {
  final String title;
  final String description;

  const JoinCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3F1),
        border: Border.all(color: Color(0xFFCF5445), width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFCF5445),
                shape: const StadiumBorder(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                elevation: 0,
              ),
              onPressed: () {},
              child: const Text(
                'Join',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
