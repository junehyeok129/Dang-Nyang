import 'package:flutter/material.dart';
import 'package:iot_app/screens/information/animal_information_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';


class HomeTab extends StatefulWidget {
  final String username; // 사용자 이름을 받을 변수 추가

  const HomeTab({required this.username, Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String petName = '';
  String petGender = '';
  String petBirth = '';
  String petSort = '';

  String formattedBirth = '';

  @override
  void initState() {
    super.initState();
    // AnimalInformationScreen에서 petName과 petBirth 정보를 가져와서 상태 변수에 저장
    fetchPetInfo();
  }

  Future<void> fetchPetInfo() async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/get_petInfo'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': widget.username}), // 사용자 이름을 보냄
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
            setState(() {
          petName = data['PetName'];
          petGender = data['PetGender'];
          petBirth = data['PetBirth'];
          petSort = data['PetSort'];

          final dateFormat = DateFormat('yyyy-MM-dd'); // 또는 DateFormat('yy.MM.dd')
          formattedBirth = dateFormat.format(DateTime.parse(petBirth));
        });
      } else {
        // 오류 처리
        print('Failed to load pet info');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

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
              name: petName, // petName 사용
              birthday: formattedBirth, // petBirth 사용
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
              // AnimalInformationScreen를 생성할 때 사용자 이름을 전달
              return AnimalInformationScreen(username: widget.username);
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(55),
            child: Image.asset(
              'assets/images/pets.png', // 이미지 파일 경로
              fit: BoxFit.cover, // 이미지가 위젯에 맞게 조정되도록 설정
            ),
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
