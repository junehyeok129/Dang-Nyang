import 'package:flutter/material.dart';
import 'package:iot_app/screens/information/animal_information_screen.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _animalInformation(
              battery: 20,
              name: '삐삐',
              birthday: '20.01.01',
            ),
            _animalInformation(
              battery: 0,
              name: '냥냥',
              birthday: '20.01.01',
            ),
          ],
        )
      ],
    );
  }

  Widget _animalInformation({
    required int battery,
    required String name,
    required String birthday,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return AnimalInformationScreen();
            },
          ),
        );
      },
      child: Column(
        children: [
          Text(
            '$battery%',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: Colors.grey[350],
              borderRadius: BorderRadius.circular(55),
            ),
          ),
          SizedBox(height: 20),
          Text(
            name,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4),
          Text(
            birthday,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
