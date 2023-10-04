import 'package:flutter/material.dart';
import 'package:iot_app/widget/animal_profile.dart';
import 'package:iot_app/widget/custom_pie_chart.dart';
<<<<<<< HEAD
import 'package:iot_app/screens/tab/home_tab.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


class AnimalInformationScreen extends StatefulWidget {
  final String username; // 사용자 이름을 받는 변수 추가

  const AnimalInformationScreen({super.key, required this.username});
=======

class AnimalInformationScreen extends StatefulWidget {
  const AnimalInformationScreen({super.key});
>>>>>>> 2f22ee43d93b3984ce0057dc7bbfd5d6f9725e40

  @override
  State<AnimalInformationScreen> createState() =>
      _AnimalInformationScreenState();
}

class _AnimalInformationScreenState extends State<AnimalInformationScreen> {
<<<<<<< HEAD
  String petName = '';
  String petGender = '';
  String petBirth = '';
  String petSort = '';
  String temperature = '';
  String stepPercentage = '';
  String heartRate = '';

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchPetInfo();
    startDataRefreshTimer();
  }
  void startDataRefreshTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      fetchLiveBioData();
    });
  }

  Future<void> fetchLiveBioData() async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/get_live_bio'), // Flask 서버 URL로 수정
      );

      if (response.statusCode == 200) {
        final String dataString = response.body;
        final List<String> dataList = dataString.split(',');

        if (dataList.isNotEmpty && dataList.length >= 4) {
          setState(() {
            temperature = '${dataList[2]} C';
            final String rawHeartRateStr = dataList[3];
            final String heartRateStr = rawHeartRateStr.replaceAll(RegExp(r'[\n\]]'), '');
            stepPercentage = '${heartRateStr} 걸음';
            heartRate = '${dataList[4]} BPM';
          });
        } else {
          print('Invalid data format received');
        }
        print('Received live bio data: $dataList');
        print(dataList[1]);
        print(dataList[2]);
        print(dataList[3]);
        print(dataList[4]);
      } else {
        print('Failed to fetch live bio data');
      }
    } catch (e) {
      print('Error: $e');
    }
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
        });
      } else {
        // 오류 처리
        print('Failed to load pet info');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

=======
>>>>>>> 2f22ee43d93b3984ce0057dc7bbfd5d6f9725e40
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffff1cd),
      body: SafeArea(
        child: Column(
          children: [
            AnimalProfile(
<<<<<<< HEAD
              name: petName, // 서버에서 가져온 동물 정보 사용
              type: petSort, // 서버에서 가져온 동물 정보 사용
=======
              name: '삐삐',
              type: '말티푸/여아',
>>>>>>> 2f22ee43d93b3984ce0057dc7bbfd5d6f9725e40
            ),
            Expanded(
              child: Column(
                children: [
                  donutChartWidget(),
                  SizedBox(height: 30),
                  animalStatusWidget(),
                  SizedBox(height: 30),
                  Image.asset('assets/images/pets.png'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget donutChartWidget() {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPieChart(
          value: 40,
          height: 180,
          width: 180,
          lineWidth: 6,
          backColor: Color(0xffEFDAA3),
          valueColor: Colors.white,
        ),
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(150),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
<<<<<<< HEAD
                  stepPercentage,
=======
                  '0%',
>>>>>>> 2f22ee43d93b3984ce0057dc7bbfd5d6f9725e40
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/thermometer.png'),
                    SizedBox(width: 4),
                    Text(
<<<<<<< HEAD
                      temperature,
=======
                      '36.5 C',
>>>>>>> 2f22ee43d93b3984ce0057dc7bbfd5d6f9725e40
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/heart-attack.png'),
                    SizedBox(width: 4),
                    Text(
<<<<<<< HEAD
                      heartRate,
=======
                      '88BPM',
>>>>>>> 2f22ee43d93b3984ce0057dc7bbfd5d6f9725e40
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget animalStatusWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      margin: EdgeInsets.symmetric(horizontal: 42),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Text(
<<<<<<< HEAD
        '$petName는 휴식 중이에요', // 서버에서 가져온 동물 이름 사용
=======
        '삐삐는 휴식 중이에요',
>>>>>>> 2f22ee43d93b3984ce0057dc7bbfd5d6f9725e40
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xffffb800),
        ),
      ),
    );
  }
}
