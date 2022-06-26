import 'dart:convert';

import 'package:chat_app/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/global/environment.dart';

class AuthService with ChangeNotifier {

  late Usuario usuario;
  bool _autenticando = false;
  final _storage = const FlutterSecureStorage();


  bool get autenticando => _autenticando;
  set autenticando( bool value ) {
    _autenticando = value;
    notifyListeners();
  }

  //Getters del token de forma estatica
  static Future getToken() async {
    final _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future deleteToken() async {
    final _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login( String email, String password ) async {

    autenticando = true;


    final data = {
      'email': email,
      'password': password
    };

    final res = await http.post(Uri.parse('${ Environment.apiUrl }/login',),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );
    autenticando = false;
    
    if (res.statusCode == 200 ){

      final loginResponse = loginResponseFromJson(res.body );
      usuario = loginResponse.usuario;

      await _guardarToken(loginResponse.token);

      return true;

    }else{

      return false;

    }
  }

   Future register(String nombre,  String email, String password ) async {
    autenticando = true;

    final data = {
      'nombre': nombre,
      'email': email,
      'password': password,
      
    };
    final res = await http.post(Uri.parse('${ Environment.apiUrl }/login/new',),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    autenticando = false;

    if (res.statusCode == 200 ){

      final loginResponse = loginResponseFromJson(res.body );
      usuario = loginResponse.usuario;

      await _guardarToken(loginResponse.token);

      return true;

    }else{
      final respBody = jsonDecode(res.body);

      return respBody['msg'];

    }


   }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');

    final res = await http.get(Uri.parse('${ Environment.apiUrl }/login/new',),
      headers: {
        'Content-Type': 'application/json',
        'x-token': token as String,
      }
    );

    if (res.statusCode == 200 ){

      final loginResponse = loginResponseFromJson(res.body );
      usuario = loginResponse.usuario;
      await _guardarToken(loginResponse.token);

      return true;

    }else{
      await logout();
      return false;

    }
  }

  Future _guardarToken( String token) async {
    return await _storage.write(key: "token", value: token);
  }

  Future logout() async {
    await _storage.delete(key: "tw,token");
  }
}