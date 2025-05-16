import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  'My profile',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFFF9EDED),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Color(0xFFB85C5C), width: 2),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/img/profile.jpg',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Ddaru',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                '(male)',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            '2015.06.06',
                            style:
                                TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                          Text(
                            'ddaru@gmail.com',
                            style:
                                TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFB85C5C), width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      _buildMenuItem('Logout'),
                      _buildDivider(),
                      _buildMenuItem('Edit Profile'),
                      _buildDivider(),
                      _buildMenuItem('View Favorite Posts'),
                      _buildDivider(),
                      _buildMenuItem('Notification Settings'),
                      _buildDivider(),
                      _buildMenuItem('Contact Us'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
      trailing: Icon(Icons.chevron_right, size: 24, color: Colors.black87),
      onTap: () {},
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      minLeadingWidth: 0,
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Divider(
        color: Color(0xFFB85C5C),
        thickness: 2,
        height: 0,
      ),
    );
  }
}
