import 'package:flutter/material.dart';

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
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3F1),
                  border: Border.all(color: Color(0xFFD97D54), width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Every step you take\nhelps save the forest',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFD97D54),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 발자국 아이콘 (대체: 기본 아이콘 사용)
                        Icon(Icons.directions_walk,
                            size: 56, color: Colors.black87),
                        const SizedBox(width: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'step count',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              '1000',
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(width: 32),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'calories burned\nthrough steps',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              '30kcal',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w500),
                            ),
                          ],
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
                  border: Border.all(color: Color(0xFFD97D54), width: 2),
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
                  border: Border.all(color: Color(0xFFD97D54), width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'Help restore our forests.\nDonate now to support wildfire recovery.',
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
                itemBuilder: (context, index) => const JoinCard(),
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
  const JoinCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3F1),
        border: Border.all(color: Color(0xFFD97D54), width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Looking for volunteers to help plant trees',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "We're planting 3 pine trees — looking for 3 helpers!",
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFCF5445),
                shape: StadiumBorder(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              ),
              onPressed: () {},
              child: const Text(
                'Join',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
