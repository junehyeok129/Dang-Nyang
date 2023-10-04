import pymysql
from flask import Flask, request, jsonify, render_template, Response
from flask_cors import CORS
import plotly.express as px
import plotly.offline as pyo
import pandas as pd
import random
import json
import re
from datetime import datetime


app = Flask(__name__)
CORS(app)

@app.route('/login', methods=['POST'])
def login():
    data = request.json
    username = data.get('username')
    password = data.get('password')
    print(username,password)
    conn = pymysql.connect(host='34.64.117.42',user='root',password='1234',db='data')
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM User WHERE ID = %s;", (username,))
    result = cursor.fetchone()
    print(result)
    if result is None:
        conn.close()
        return jsonify({'success': False, 'message': '아이디가 없습니다.'}), 400

    saved_password = result[1]

    if password == saved_password:
        conn.close()
        return jsonify({'success': True, 'message': '로그인 성공'}), 200
    else:
        conn.close()
        return jsonify({'success': False, 'message': '비밀번호가 다릅니다.'}), 400

@app.route('/check_username', methods=['POST'])
def check_username():
    data = request.json
    username = data.get('username')

    conn = pymysql.connect(host='34.64.117.42',user='root',password='1234',db='data')
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM User WHERE ID = %s;", (username,))
    result = cursor.fetchone()

    if result is None:
        conn.close()
        return jsonify({'available': True}), 200
    else:
        conn.close()
        return jsonify({'available': False}), 200


@app.route('/register', methods=['POST'])
def register():
    data = request.json
    username = data.get('username')
    password = data.get('password')
    name = data.get('name')
    birthday = data.get('birthday')
    gender = data.get('gender')
    
    conn = pymysql.connect(host='34.64.117.42',user='root',password='1234',db='data')
    cursor = conn.cursor()

    cursor.execute("INSERT INTO User (ID, Password, Name, Birth, Gender) VALUES (%s, %s, %s, %s, %s);",(username, password, name, birthday, gender))
    conn.commit()
    conn.close()

    return jsonify({'success': True, 'message': '회원가입 성공'}), 200


@app.route('/Device_register', methods=['POST'])
def Device_register():
    '''
    Need Device ID, ID, Name, Gender, Birth, Sort
    '''
    device_data = request.json
    DeviceID = device_data.get('DeviceID')
    ID = device_data.get('ID')
    PetName = device_data.get('PetName')
    PetGender = device_data.get('PetGender')
    PetBirth = device_data.get('PetBirth')
    PetSort = device_data.get('PetSort')
    
    conn = pymysql.connect(host='34.64.117.42',user='root',password='1234',db='data')
    cursor = conn.cursor()
    # ID Info의 경우는 Page Log로 가져와야함
    # ID를 로그인하면 해당 정보를 로그로 남겨놓아야할 필요가 있다.
    cursor.execute("INSERT INTO DeviceInfo (DeviceID, ID, PetName, PetGender, PetBirth,PetSort) VALUES (%s, %s, %s, %s, %s);",(username, password, name, birthday, gender))
    conn.commit()
    conn.close()

    return jsonify({'success': True, 'message': '회원가입 성공'}), 200


@app.route('/get_petInfo', methods=['POST'])
def get_pet_info():
    data = request.json
    username = data.get('username')

    conn = pymysql.connect(host='34.64.117.42', user='root', password='1234', db='data')
    cursor = conn.cursor()

    cursor.execute("SELECT PetName, PetGender,DATE_FORMAT(PetBirth, '%%Y-%%m-%%d'), PetSort FROM DeviceInfo WHERE ID = %s;", (username,))
    result = cursor.fetchone()

    conn.close()

    if result is None:
        return jsonify({'error': 'Pet information not found'}), 404

    pet_info = {
        'PetName': result[0],
        'PetGender': result[1],
        'PetBirth': result[2],
        'PetSort': result[3]
    }

    return jsonify(pet_info), 200


@app.route('/get_petInfo_Home', methods=['POST'])
def get_pet_info_Home():
    data = request.json
    username = data.get('username')

    conn = pymysql.connect(host='34.64.117.42', user='root', password='1234', db='data')
    cursor = conn.cursor()

    cursor.execute("SELECT PetName, DATE_FORMAT(PetBirth, '%%Y-%%m-%%d') FROM DeviceInfo WHERE ID = %s;", (username,))
    result = cursor.fetchone()

    conn.close()

    if result is None:
        return jsonify({'error': 'Pet information not found'}), 404

    pet_info = {
        'PetName': result[0],
        'PetBirth': result[1]
    }

    return jsonify(pet_info), 200

@app.route('/get_heart_rate_data', methods=['POST'])
def get_heart_rate_data():
    # 가상의 심박수 데이터 생성 (여기서는 무작위 데이터 생성)
    df = pd.read_excel('./data.xlsx')
    df.set_index('Date', inplace=True)
    df_resampled = df.resample('1Min').mean()
    df_resampled = df_resampled.round(1)
    df_resampled = df_resampled.drop(['Unnamed: 0'],axis=1)
    heart = df_resampled.drop(['Temp','Walk'],axis = 1)
    heart = heart.reset_index()
    #data = heart.to_json(orient='records', date_format='iso')
    data = heart.to_dict(orient='records')
    pretty_data = json.dumps(data, indent=4, default=str)
    print(pretty_data)
    return Response(pretty_data)


@app.route('/get_live_bio', methods=['POST'])
def get_live_bio():
    input_file_path = './sensor_value.txt'  # 입력 파일 경로에 맞게 수정

    data_groups = []

    current_data_group = []


    with open(input_file_path, 'r') as input_file:
        current_datetime = None  # 현재 데이터 묶음의 시작 시간
        lines_count = 0
        for line in input_file:
            if len(line) == 1:
                lines_count = 0
            else:
                lines_count += 1
                if lines_count == 1:
                    date_string = line.strip()
                    date_format = "%Y-%m-%d %H:%M:%S"
                    datetime_object = datetime.strptime(date_string, date_format)
                    current_data_group.append(datetime_object)
                elif lines_count == 2:
                    temperature_match = line.replace("Temperature = ","")
                    current_data_group.append(float(temperature_match.rstrip()))
                elif lines_count == 3:
                    walk_match = line.replace("Walk = ","")
                    current_data_group.append(walk_match.rstrip())
                elif lines_count == 4:
                    if len(line) == 3:
                        pass
                    else:
                        heart_rate_match = line.replace("HeartRate =","")
                        current_data_group.append(int(heart_rate_match.rstrip()))
                        data_groups.append(current_data_group)
                        current_data_group = []
                elif lines_count == 5:
                    line = line.rstrip()
                    heart_rate_matc = line.split('=')[1]
                    current_data_group.append(int(heart_rate_match.rstrip()))
                    data_groups.append(current_data_group)
                    current_data_group = []

    return jsonify(data_groups[-1]), 200
    
if __name__ == '__main__':
    app.run(debug=True)
