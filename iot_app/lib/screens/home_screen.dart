import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:iot_app/screens/tab/home_tab.dart';
import 'package:iot_app/screens/tab/calendar_tab.dart';
import 'package:iot_app/screens/tab/health_tab.dart';
import 'package:iot_app/screens/tab/my_tab.dart';
import 'package:iot_app/widget/bottomBar.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:shared_preferences/shared_preferences.dart'; // 추가

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var tabIndex = 0;
  String _username = ''; // 유저 아이디 추가

  @override
  void initState() {
    super.initState();
    _loadUsername(); // 유저 아이디 정보 불러오기
  }

  // 유저 아이디 정보 불러오기
  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username') ?? '';
    setState(() {
      _username = username;
    });
  }

<<<<<<< HEAD
=======
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var tabIndex = 0;

>>>>>>> 2f22ee43d93b3984ce0057dc7bbfd5d6f9725e40
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Color(0xfffff1cd),
        appBar: AppBar(
          backgroundColor: Color(0xfffff1cd),
          elevation: 0,
<<<<<<< HEAD
          title: Row(
            children: [
              Text(
                '댕냥워치',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
              Spacer(),
              Text(
                'id: $_username',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
=======
          title: Text(
            '댕냥워치',
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
            ),
>>>>>>> 2f22ee43d93b3984ce0057dc7bbfd5d6f9725e40
          ),
        ),
        body: TabBarView(
          children: [
<<<<<<< HEAD
            HomeTab(username: _username), // _username 변수를 전달
=======
            HomeTab(),
>>>>>>> 2f22ee43d93b3984ce0057dc7bbfd5d6f9725e40
            HealthTab(),
            CalendarTab(),
            MyTab(),
          ],
        ),
        bottomNavigationBar: BottomBar(
          onTap: (index) {
            setState(() {
              tabIndex = index;
            });
          },
        ),
        floatingActionButton: SpeedDial(
          visible: tabIndex == 0,
          icon: Icons.add,
          activeIcon: Icons.close,
          backgroundColor: Color(0xffEFDAA3),
          overlayColor: Colors.black.withOpacity(0.01),
          children: [
            SpeedDialChild(
              child: Image.asset('assets/images/delete.png'),
              label: '삭제하기',
              labelStyle: TextStyle(fontSize: 12, color: Colors.black),
              onTap: () {
                // TODO: 삭제 기능 수행
              },
            ),
            SpeedDialChild(
              child: Image.asset('assets/images/dog.png'),
              label: '수정하기',
              labelStyle: TextStyle(fontSize: 12, color: Colors.black),
              onTap: () {
                // TODO: 수정 기능 수행
              },
            ),
            SpeedDialChild(
              child: Image.asset('assets/images/pet-care.png'),
              label: '추가하기',
              labelStyle: TextStyle(fontSize: 12, color: Colors.black),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: BluetoothDeviceScreen(),
                    );
                  },
                );
              },
<<<<<<< HEAD
            ),
            // 개발자 모드
            SpeedDialChild(
              child: Image.asset('assets/images/pet-care.png'),
              label: '개발자',
              labelStyle: TextStyle(fontSize: 12, color: Colors.black),
              onTap: () {
                // TODO: 개발자 모드 기능 수행
              },
=======
>>>>>>> 2f22ee43d93b3984ce0057dc7bbfd5d6f9725e40
            ),
          ],
        ),
      ),
    );
  }
}

class BluetoothDeviceScreen extends StatefulWidget {
  @override
  _BluetoothDeviceScreenState createState() => _BluetoothDeviceScreenState();
}

class _BluetoothDeviceScreenState extends State<BluetoothDeviceScreen> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<ScanResult> scanResults = [];
  bool isScanning = false;

  @override
  void initState() {
    super.initState();
    _startScan();
  }

  void _startScan() {
    setState(() {
      isScanning = true;
      scanResults.clear();
    });

    flutterBlue.startScan(timeout: Duration(seconds: 5));
    flutterBlue.scanResults.listen((results) {
      setState(() {
        scanResults = results;
      });
    }).onDone(() {
      setState(() {
        isScanning = false;
      });
    });
  }

  void _connectToDevice(BluetoothDevice device) async {
    await device.connect();
    // TODO: 연결 성공 시 처리 로직 추가
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          title: Text('블루투스 기기 검색'),
          actions: [
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                flutterBlue.stopScan();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
<<<<<<< HEAD
        if (isScanning)
=======
        if (isScanning) // 로딩 중이면 로딩 인디케이터 표시
>>>>>>> 2f22ee43d93b3984ce0057dc7bbfd5d6f9725e40
          CircularProgressIndicator(),
        Expanded(
          child: ListView.builder(
            itemCount: scanResults.length,
            itemBuilder: (context, index) {
              BluetoothDevice device = scanResults[index].device;
              return ListTile(
                title: Text(device.name),
                subtitle: Text(device.id.toString()),
                onTap: () {
                  _connectToDevice(device);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(home: HomeScreen()));
}
