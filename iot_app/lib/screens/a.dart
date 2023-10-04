import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:iot_app/screens/tab/home_tab.dart';
import 'package:iot_app/screens/tab/calendar_tab.dart';
import 'package:iot_app/screens/tab/health_tab.dart';
import 'package:iot_app/screens/tab/my_tab.dart';
import 'package:iot_app/widget/bottomBar.dart';
import 'package:flutter_blue/flutter_blue.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Color(0xfffff1cd),
        appBar: AppBar(
          backgroundColor: Color(0xfffff1cd),
          elevation: 0,
          title: Text(
            '댕냥워치',
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            HomeTab(),
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
            ),
            // 개발자 모드
            SpeedDialChild(
              child: Image.asset('assets/images/pet-care.png'),
              label: '개발자',
              labelStyle: TextStyle(fontSize: 12, color: Colors.black),
              onTap: () {
                // TODO: 삭제 기능 수행
              },
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
      isScanning = true; // 스캔 시작시 로딩 상태 변경
      scanResults.clear();
    });

    flutterBlue.startScan(timeout: Duration(seconds: 5));
    flutterBlue.scanResults.listen((results) {
      setState(() {
        scanResults = results;
      });
    }).onDone(() {
      setState(() {
        isScanning = false; // 스캔 종료시 로딩 상태 변경
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
        if (isScanning) // 로딩 중이면 로딩 인디케이터 표시
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
