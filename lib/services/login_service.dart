import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:software_todo_app_v2/dto/login_response_dto.dart';
import 'package:software_todo_app_v2/dto/response_dto.dart';
import 'package:software_todo_app_v2/services/ip/ip.dart' as ip;
import 'package:http/http.dart' as http;

class LoginService {
  static String backendUrlBase = ip.urlBack; // url del backend
  static Future<LoginResponseDto> login(
      String username, String password) async {
    LoginResponseDto result;
    var uri = Uri.parse("$backendUrlBase/api/v1/auth/login");
    var body = jsonEncode({
      'username': username,
      'password': password,
    });
    Map<String, String> headers = {
      // esto es necesario para java
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await http.post(uri,
        headers: headers, body: body); // invocación al backend
    debugPrint('Respuesta del backend: ${response.body}');
    if (response.statusCode == 200) {
      debugPrint(
          'Respuesta 200 del backend (exitoso).'); // 200 significa que el backend procesó la solicitud correctamente
      var responseDto = ResponseDto.fromJson(jsonDecode(response
          .body)); // aquí ya no existe statusCode, dado que ya se decodificó
      if (responseDto.code.toString() == '0000') {
        // si el backend autenticó al usuario
        result = LoginResponseDto.fromJson(
            responseDto.response); // ESTO es lo que se retorna al cubit
        debugPrint('resultado: ${result.toJson()}');
      } else {
        throw Exception(responseDto.errorMessage);
      }
    } else {
      debugPrint('Error de estado del backend: ${response.statusCode}');
      throw Exception('Error en el proceso de login.');
    }
    return result;
  }
}
