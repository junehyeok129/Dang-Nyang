import pymysql
from flask import Flask, request, jsonify
from flask_cors import CORS

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


if __name__ == '__main__':
    app.run(debug=True)
