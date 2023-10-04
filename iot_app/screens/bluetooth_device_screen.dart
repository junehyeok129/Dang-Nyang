import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothDeviceScreen extends StatefulWidget {
  @override
  _BluetoothDeviceScreenState createState() => _BluetoothDeviceScreenState();
}

class _BluetoothDeviceScreenState extends State<BluetoothDeviceScreen> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<ScanResult> scanResults = [];

  @override
  void initState() {
    super.initState();
    _startScan();
  }

  void _startScan() {
    scanResults.clear();
    flutterBlue.startScan(timeout: Duration(seconds: 5));
    flutterBlue.scanResults.listen((results) {
      setState(() {
        scanResults = results;
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
