// HomePage.dart
import 'package:flutter/material.dart';
import 'Maps.dart';
import 'DamageInfo.dart';
import 'PlantInfo.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();
  double _sheetSize = 0.5;

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
          MapWidget(),
          DraggableScrollableSheet(
            controller: _sheetController,
            initialChildSize: 0.5,
            minChildSize: 0.2,
            maxChildSize: 0.95,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: ListView(
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
                    DamageInfo(),
                    SizedBox(height: 10),
                    Container(
                      height: 450,
                      child: PlantInfo(),
                    ),
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
