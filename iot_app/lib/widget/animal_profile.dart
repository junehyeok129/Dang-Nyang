import 'package:flutter/material.dart';

class AnimalProfile extends StatelessWidget {
  const AnimalProfile({
    required this.name,
    required this.type,
    super.key,
  });

  final String name;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Image.asset(
            'assets/images/pets.png', // 이미지 경로
            width: 50, // 이미지의 너비
            height: 50, // 이미지의 높이
            fit: BoxFit.cover,
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              Text(
                type,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
