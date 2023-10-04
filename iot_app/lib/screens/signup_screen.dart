import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String? _selectedGender = '남성';
  DateTime? _selectedDate = DateTime.now();
  bool _isUsernameAvailable = true;
  bool _isFormValid = false; 

  Future<void> _checkUsernameAvailability(String username) async {
    if (username.isEmpty) {
      setState(() {
        _isUsernameAvailable = false;
        _isFormValid = false;
      });
      return;
    }

    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/check_username'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
      }),
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      setState(() {
        _isUsernameAvailable = responseData['available'];
        _isFormValid = _isUsernameAvailable;
      });
    }
  }

  Future<void> _register(BuildContext context) async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    String name = _nameController.text;
    String gender = _selectedGender!;
    String birthday =
        '${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}';

    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'name': name,
        'birthday': birthday,
        'gender': gender,
      }),
    );

    if (response.statusCode == 200) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('회원가입 완료'),
            content: Text('회원가입이 성공적으로 완료되었습니다.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context); // 회원가입 화면을 닫고 로그인 화면으로 이동
                },
                child: Text('확인'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffff1cd),
      appBar: AppBar(
        title: Text(
          '회원가입',
          style: TextStyle(color: Colors.black)),
        backgroundColor: Color(0xfffff1cd),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildUsernameTextField(),
            SizedBox(height: 8),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              // Fix ing.......
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  ),
                    ),
                  style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: '이름'),
            ),
            SizedBox(height: 16),
            _buildGenderRadioButtons(),
            SizedBox(height: 8),
            _buildBirthdayPicker(),
            ElevatedButton(
              onPressed: _isFormValid
                  ? () => _register(context)
                  : null,
              child: Text('회원가입'),
            ),
            SizedBox(height: 8),
            Text(
              _isUsernameAvailable
                  ? '사용 가능한 ID입니다.'
                  : '이미 사용 중인 아이디입니다.',
              style: TextStyle(
                color: _isUsernameAvailable ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('뒤로가기'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderRadioButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '성별',
          style: TextStyle(fontSize: 16),
        ),
        Row(
          children: <Widget>[
            Radio(
              value: '남성',
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            Text('남성'),
            Radio(
              value: '여성',
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            Text('여성'),
          ],
        ),
      ],
    );
  }

  Widget _buildBirthdayPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '생일',
          style: TextStyle(fontSize: 16),
        ),
        InkWell(
          onTap: () {
            _selectDate(context);
          },
          child: Container(
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              '${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}',
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate!,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Widget _buildUsernameTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _usernameController,
          decoration: InputDecoration(
            labelText: 'ID',
            errorText: _isUsernameAvailable
                ? null
                : '이미 사용 중인 아이디입니다.',
          ),
          onChanged: (username) {
            setState(() {
              _isUsernameAvailable = true;
              _isFormValid = false;
            });
          },
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () =>
              _checkUsernameAvailability(_usernameController.text),
          child: Text('중복 체크'),
        ),
      ],
    );
  }
}
