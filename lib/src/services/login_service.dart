import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/utils/globals.dart';

import 'package:graphql/client.dart';

import '../utils/globals.dart';

class LoginService with ChangeNotifier {
  LoginService() {
    _readUserDataSecure();
  }

  //Inicializamos variable de respuesta login.

  LoginResult _loginResult = LoginResult();
  LoginResult get loginResult => _loginResult;
  set loginResult(LoginResult lr) {
    _loginResult = lr;
    notifyListeners();
  }


  //Inicializar el almacenamiento seguro
  final _storage = FlutterSecureStorage();

  //datos para login de usuario
  String _email = '';
  String get email => _email;
  set email(String newMail) {
    _email = newMail;
    notifyListeners();
  }

  String _password = '';
  set password(String passwordnw) {
    _password = passwordnw;
    notifyListeners();
  }

  ///para manejar el login del user
  ///
  bool _isloading = false;
  bool get isloading => _isloading;

  /// Para actualizar el checkbox de remeber username

  bool _value = false;
  bool get rememberUser => _value;
  set rememberUser(bool nv) {
    _value = nv;
    notifyListeners();
  }

  ///Funcion para login de usuario.
  loginUser() async {
    _isloading = true;
    notifyListeners();
    if (_value == true) {
      _saveUserData();
    }
    var res = await http.post('$api_url/login/',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': _email,
          'password': _password,
          'device': device
        }));
    if (res.statusCode == 404) {
      _isloading = false;
      //manejo de errores de backend
      print(res.body);
    } else {
      _loginResult = loginResultFromJson(res.body);
      _isloading = false;
      
    }
    notifyListeners();
  }

  /// Helper para guardar el login del usuario
  void _saveUserData() async {
    await _storage.write(key: 'email', value: _email);
    await _storage.write(key: 'password', value: _password);
  }

  //helper para ver si ya habia iniciado sesion;
  void _readUserDataSecure() async {
    final all = await _storage.readAll();
    all.forEach((key, value) {
      if (key == 'email') {
        _email = value;
      }
      if (key == 'password') {
        _password = value;
      }
    });
    //si habian registros guardados, intentamos hacer login
    if (_email != '' && _password != '') {
      loginUser();
    } else {
      //si no hay registro, seteamos el token en ''
      _loginResult.token = '';
      notifyListeners();
    }
  }

   //helper para borrar todos los datos del almacen seguro
  void deleteAllUserData() async {
    //se borra completamente el almacen seguro
    await _storage.deleteAll();
  }
}
