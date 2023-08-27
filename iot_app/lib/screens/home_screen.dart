import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:iot_app/widget/bottomBar.dart';
import 'package:flutter_blue/flutter_blue.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('댕냥워치'),
        ),
        body: TabBarView(
          children: [
            Container(
              child: Center(
                child: Text("home"),
              ),
            ),
            Container(
              child: Center(
                child: Text("건강"),
              ),
            ),
            Container(
              child: Center(
                child: Text("일정"),
              ),
            ),
            Container(
              child: Center(
                child: Text("마이"),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomBar(),
        floatingActionButton: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            SpeedDial(
              icon: Icons.add,
              activeIcon: Icons.close,
              children: [
                SpeedDialChild(
                  child: Icon(Icons.add),
                  label: '추가하기',
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
                SpeedDialChild(
                  child: Icon(Icons.edit),
                  label: '수정하기',
                  onTap: () {
                    // TODO: 수정 기능 수행
                  },
                ),
                SpeedDialChild(
                  child: Icon(Icons.delete),
                  label: '삭제하기',
                  onTap: () {
                    // TODO: 삭제 기능 수행
                  },
                ),
              ],
            ),
            Container(),
            Container(),
            Container(),
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
