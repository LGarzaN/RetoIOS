from flask import Flask, jsonify, request
import mysql.connector
from dotenv import load_dotenv
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity
from hashlib import sha256
import os

load_dotenv()

app = Flask(__name__)

def sqlSafe(string):
    string2 = string.replace(";", "")
    string2 = string2.replace("--", "")
    string2 = string2.replace("'", "")
    string2 = string2.replace("(", "")
    string2 = string2.replace(")", "")
    string2 = string2.replace("=", "")
    return string2

db_config = {
    'host': os.getenv('MYSQL_HOST'),
    'user': os.getenv('MYSQL_USER'),
    'password': os.getenv('MYSQL_PASSWORD'),
    'database': os.getenv('MYSQL_DATABASE'),
    'port': os.getenv('MYSQL_PORT'),
}

app.config['JWT_SECRET_KEY'] = os.getenv('JWT_SECRET_KEY')
jwt = JWTManager(app)

app.config['JWT_ACCESS_TOKEN_EXPIRES'] = False

# @app.before_request
# def verify_api_key():
#     api_key = request.headers.get('X-API-Key')

#     print("Received API Key:", api_key)

#     if api_key is None or api_key != os.getenv('API_KEY'):
#         response = {'status': 'error', 'message': 'Invalid API key'}
#         return jsonify(response), 401  

@app.route('/datoshp/<int:id>', methods=['GET'])
@jwt_required()
def get_data(id):
    try:
        '''
                if get_jwt_identity() != id:
            response = {'status': 'error', 'message': 'Invalid user ID'}
            print(response)
            return jsonify(response), 401
        '''

        connection = mysql.connector.connect(**db_config)

        cursor = connection.cursor()

        query = "SELECT * FROM sintomasseguir WHERE Usuario_idUsuario = %s and SeguirFechaInicial = SeguirFechaFinal;"
        cursor.execute(query, (id,))

        columns = [column[0] for column in cursor.description]
        results = [dict(zip(columns, row)) for row in cursor.fetchall()]

        cursor.close()
        connection.close()

        return jsonify(results)

    except Exception as e:
        print(e)
        return jsonify({'error': str(e)})
    
@app.route('/finSintoma/<int:id>', methods=['PUT'])
@jwt_required()
def update_sintoma(id):
    try:
        connection = mysql.connector.connect(**db_config)

        cursor = connection.cursor()

        query = "UPDATE sintomasseguir SET SeguirFechaFinal = NOW() where idSintomasSeguir = %s;"
        cursor.execute(query, (id,))
        connection.commit()

        response = {'status': 'success', 'message': 'Data updated successfully'}
        cursor.close()
        connection.close()

        return jsonify(response)

    except Exception as e:
        return jsonify({'error': str(e)})
    
@app.route('/login/', methods=['POST'])
def get_data_by_id():
    try:
        data = request.get_json()

        correo = data.get('correo')
        contrasena = data.get('contrasena')

        correo = sqlSafe(correo) 
        contrasena = sqlSafe(contrasena)

        connection = mysql.connector.connect(**db_config)

        cursor = connection.cursor()

        query = "SELECT contrasena,idUsuario FROM usuario WHERE CorreoUsuario = %s and contrasena = %s;"
        cursor.execute(query, (correo, contrasena))

        user = cursor.fetchone()

        cursor.close()
        connection.close()

        if user:
            access_token = create_access_token(identity=user[1])
            response = {'JW_token': access_token, 'idUsuario': user[1]}
            return jsonify(response), 200
        else:
            response = {'message': 'Invalid username or password'}
            return jsonify(response), 401

    except Exception as e:
        return jsonify({'error': str(e)})
    
    
@app.route('/usuarios', methods=['GET'])
def get_usuarios():
    try:
        print()

        connection = mysql.connector.connect(**db_config)

        cursor = connection.cursor()

        query = "SELECT idUsuario, NombreUsuario, ApellidoUsuario, Fecha_Nacimiento, CorreoUsuario, TelefonoUsuario FROM usuario;"
        cursor.execute(query)

        columns = [column[0] for column in cursor.description]
        results = [dict(zip(columns, row)) for row in cursor.fetchall()]

        cursor.close()
        connection.close()

        return jsonify(results)

    except Exception as e:
        return jsonify({'error': str(e)})
    
@app.route('/registros/<int:id>/<int:idSintoma>', methods=['GET'])
@jwt_required()
def get_registros(id, idSintoma):
    try:  
        connection = mysql.connector.connect(**db_config)

        cursor = connection.cursor()

        query = "SELECT * FROM registrosintomas WHERE Usuario_idUsuario = %s and SintomasSeguir_idSintomasSeguir = %s;"
        cursor.execute(query, (id, idSintoma))

        columns = [column[0] for column in cursor.description]
        results = [dict(zip(columns, row)) for row in cursor.fetchall()]

        cursor.close()
        connection.close()

        return jsonify(results)

    except Exception as e:
        return jsonify({'error': str(e)})

@app.route('/registrosDia/<int:idUsuario>/<string:fecha>', methods=['GET'])
@jwt_required()
def get_registrosDia(idUsuario, fecha):
    try:  
        connection = mysql.connector.connect(**db_config)

        cursor = connection.cursor()

        query = "SELECT * FROM registrosintomas where Date(RegistroFecha) = %s and Usuario_idUsuario = %s;"
        cursor.execute(query, (fecha, idUsuario))

        columns = [column[0] for column in cursor.description]
        results = [dict(zip(columns, row)) for row in cursor.fetchall()]

        cursor.close()
        connection.close()

        return jsonify(results)

    except Exception as e:
        return jsonify({'error': str(e)})
    
    
@app.route('/registrosTodos/<int:id>/', methods=['GET'])
def get_registrosTodos(id):
    try:
        connection = mysql.connector.connect(**db_config)

        cursor = connection.cursor()

        query = "SELECT * FROM registrosintomas WHERE Usuario_idUsuario = %s;"
        cursor.execute(query, (id,))

        columns = [column[0] for column in cursor.description]
        results = [dict(zip(columns, row)) for row in cursor.fetchall()]

        cursor.close()
        connection.close()

        return jsonify(results)

    except Exception as e:
        return jsonify({'error': str(e)})
    
# @app.route('/agregausuario/', methods=['POST'])
# def crearCuenta():
#     try:
#         data = request.get_json()

#         nombre = data['nombre']
#         apellido = data['apellido']
#         fechanac = data['fechanac']
#         correo = data['correo']
#         telefono = data['telefono']
#         contrasena = data['contrasena']

#         connection = mysql.connector.connect(**db_config)
#         cursor = connection.cursor()

#         email_query = "SELECT * FROM usuario WHERE CorreoUsuario = %s"
#         cursor.execute(email_query, (correo,))
#         existing_user = cursor.fetchone()

#         id = existing_user['idUsuario']

#         if existing_user:
#             response = {'status': 'error', 'message': 'Email already exists'}
#         else:
#             # Insert the new user if the email doesn't exist
#             insert_query = "INSERT INTO usuario (NombreUsuario, ApellidoUsuario, Fecha_Nacimiento, CorreoUsuario, Contrasena, TelefonoUsuario) VALUES (%s, %s, %s, %s, %s, %s)"
#             cursor.execute(insert_query, (nombre, apellido, fechanac, correo, contrasena, telefono))
#             connection.commit()
#             response = {'status': 'success', 'message': 'Data added successfully'}

#         cursor.close()
#         connection.close()

#         return jsonify(response)

#     except Exception as e:
#         response = {'status': 'error', 'message': str(e)}
#         return jsonify(response)
    

@app.route('/agregausuario/', methods=['POST'])
def crearCuenta():
    try:
        data = request.get_json()

        nombre = sqlSafe(data['nombre'])
        apellido = sqlSafe(data['apellido'])
        fechanac = data['fechanac']
        correo = sqlSafe(data['correo'])
        telefono = data['telefono']
        contrasena = data['contrasena']
        estatura = data['estatura']
        genero = data['genero']


        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor()

        email_query = "SELECT * FROM usuario WHERE CorreoUsuario = %s"
        cursor.execute(email_query, (correo,))
        existing_user = cursor.fetchone()

        if existing_user:
            response = {'status': 'error', 'message': 'Email already exists'}
        else:
            insert_query = "INSERT INTO usuario (NombreUsuario, ApellidoUsuario, Fecha_Nacimiento, CorreoUsuario, Contrasena, TelefonoUsuario) VALUES (%s,%s,%s,%s,%s,%s);"
            cursor.execute(insert_query, (nombre, apellido, fechanac, correo, contrasena, telefono))
            connection.commit()

            query3 = "select idUsuario from usuario where CorreoUsuario = %s;"
            cursor.execute(query3, (correo,))
            id = cursor.fetchone()
            id = id[0]

            query2 = "INSERT INTO paciente (Genero, Estatura, MatriculaDoc, Usuario_idUsuario) VALUES (%s, %s, 29384792, %s);"
            cursor.execute(query2, (genero, estatura, id))
            connection.commit()

            response = {'status': 'success', 'message': 'Data added successfully'}

        cursor.close()
        connection.close()

        return jsonify(response)

    except Exception as e:
        response = {'status': 'error', 'message': str(e)}
        return jsonify(response)
    
@app.route('/agregadatoseguir/', methods=['POST'])
@jwt_required()
def crearDatoSeguir():
    try:
        data = request.get_json()

        nombre = sqlSafe(data['SeguirNombre'])
        tipo = data['SeguirTipo']
        ultimoreg = data['UltimoRegistro']
        fechain = data['SeguirFechaInicial']
        fechafin = data['SeguirFechaFinal']
        idPaciente = data['Usuario_idUsuario']

        print(nombre, tipo, ultimoreg, fechain, fechafin, idPaciente)

        connection = mysql.connector.connect(**db_config)

        cursor = connection.cursor()

        query = "INSERT INTO sintomasseguir (SeguirNombre, SeguirTipo, UltimoRegistro, SeguirFechaInicial, SeguirFechaFinal, Usuario_idUsuario) values (%s, %s, %s, %s, %s, %s)"
        cursor.execute(query, (nombre, tipo, ultimoreg, fechain, fechafin, idPaciente))
        connection.commit()

        response = {'status': 'success', 'message': 'Data added successfully'}
        
        cursor.close()
        connection.close()

        print(response)

        return jsonify(response)
    
    except Exception as e:
        response = {'status': 'error', 'message': str(e)}
        print(response)
        return jsonify(response)
    
@app.route('/agregarAntecedentes/', methods=['POST'])
def crearAntecedente():
    try:
        data = request.get_json()

        for dato in data:
            nombre = sqlSafe(dato['Titulo'])
            cont = sqlSafe(dato['Contenido'])
            idPaciente = dato['Usuario_idUsuario']

            print(nombre, cont, idPaciente)

            connection = mysql.connector.connect(**db_config)

            cursor = connection.cursor()

            query = "INSERT INTO antecedentes (Titulo, Contenido, Usuario_idUsuario) values (%s, %s, %s)"
            cursor.execute(query, (nombre, cont, idPaciente))
            connection.commit()

            response = {'status': 'success', 'message': 'Data added successfully'}
        
            cursor.close()
            connection.close()

            print(response)
        
        return jsonify(response)
    
    except Exception as e:
        response = {'status': 'error', 'message': str(e)}
        print(response)
        return jsonify(response)

@app.route('/agregaregistro/', methods=['POST'])
@jwt_required()
def crearRegistro():
    try:
        data = request.get_json()

        nombre = data['RegistroSintoma']
        intensidad = data['RegistroIntensidad']
        fecha = data['RegistroFecha']
        nota = sqlSafe(data['RegistroNota'])
        idPaciente = data['Usuario_idUsuario']
        idSintoma = data['SintomasSeguir_idSintomasSeguir']

        connection = mysql.connector.connect(**db_config)

        cursor = connection.cursor()

        query = "INSERT INTO registrosintomas (RegistroSintoma, RegistroIntensidad, RegistroFecha, RegistroNota, Usuario_idUsuario, SintomasSeguir_idSintomasSeguir) values (%s, %s, %s, %s, %s, %s)"
        cursor.execute(query, (nombre, intensidad, fecha, nota, idPaciente, idSintoma))
        connection.commit()

        response = {'status': 'success', 'message': 'Data added successfully'}
        
        cursor.close()
        connection.close()

        return jsonify(response)
    
    except Exception as e:
        response = {'status': 'error', 'message': str(e)}
        print(response)
        return jsonify(response)
    
@app.route('/getcharts/<int:id>', methods=['GET'])
@jwt_required()
def get_charts(id):
    try:  
        connection = mysql.connector.connect(**db_config)

        cursor = connection.cursor()

        query = "SELECT RegistroIntensidad, SintomasSeguir_idSintomasSeguir, RegistroFecha FROM (SELECT RegistroIntensidad, SintomasSeguir_idSintomasSeguir, RegistroFecha, ROW_NUMBER() OVER (PARTITION BY SintomasSeguir_idSintomasSeguir ORDER BY RegistroFecha) AS rn FROM registrosintomas WHERE Usuario_idUsuario = %s) AS subquery WHERE rn <= 5;"
        cursor.execute(query, (id,))

        columns = [column[0] for column in cursor.description]
        results = [dict(zip(columns, row)) for row in cursor.fetchall()]

        cursor.close()
        connection.close()

        return jsonify(results)

    except Exception as e:
        return jsonify({'error': str(e)})
    
@app.route('/getdoc', methods=['GET'])
@jwt_required()
def get_doc():
    try:  
        connection = mysql.connector.connect(**db_config)

        cursor = connection.cursor()

        query = "Select usuario.TelefonoUsuario, usuario.NombreUsuario from usuario, doctor where doctor.Usuario_idUsuario = usuario.idusuario and doctor.Matricula = 9876;"
        cursor.execute(query)

        columns = [column[0] for column in cursor.description]
        results = [dict(zip(columns, row)) for row in cursor.fetchall()]

        cursor.close()
        connection.close()

        return jsonify(results)

    except Exception as e:
        return jsonify({'error': str(e)})

@app.route('/updateEstatura/<int:id>/<float:valor>', methods=['GET'])
@jwt_required()
def get_doc2(id, valor):
    try:  
        connection = mysql.connector.connect(**db_config)

        cursor = connection.cursor()

        query = "UPDATE paciente SET Estatura = %s WHERE Usuario_idUsuario = %s;"
        cursor.execute(query, (valor, id))

        columns = [column[0] for column in cursor.description]
        results = [dict(zip(columns, row)) for row in cursor.fetchall()]

        cursor.close()
        connection.close()

        return jsonify(results)

    except Exception as e:
        return jsonify({'error': str(e)})
    
@app.route('/getAlgo/<int:id>/', methods=['GET'])
#@jwt_required()
def get_Algo(id):
    try:  
        connection = mysql.connector.connect(**db_config)

        cursor = connection.cursor()

        query = "SELECT u.nombreusuario, u.apellidousuario, u.correousuario, u.telefonousuario, p.estatura FROM usuario u INNER JOIN paciente p ON u.idUsuario = p.usuario_idUsuario WHERE u.idUsuario = %s AND p.Usuario_idUsuario = %s;"
        cursor.execute(query, (id, id))

        columns = [column[0] for column in cursor.description]
        results = [dict(zip(columns, row)) for row in cursor.fetchall()]

        cursor.close()
        connection.close()

        return jsonify(results)

    except Exception as e:
        return jsonify({'error': str(e)})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)
