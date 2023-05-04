import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:software_todo_app_v2/dto/label_dto.dart';
import 'package:software_todo_app_v2/dto/response_dto.dart';
import 'package:software_todo_app_v2/services/ip/ip.dart' as ip;
import 'package:http/http.dart' as http;

class LabelsService {
  static String backendUrlBase = ip.urlBack;

  static Future<List<LabelDto>> getLabelsList(String token) async {
    List<LabelDto> result;
    var uri = Uri.parse("$backendUrlBase/api/v1/label");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var response =
        await http.get(uri, headers: headers); // invocación al backend
    if (response.statusCode == 200) {
      var responseDto = ResponseDto.fromJson(jsonDecode(response.body));
      debugPrint("backend response (LABELS): ${responseDto.toJson()}");
      if (responseDto.code.toString() == '0000') {
        // && responseDto.response != null)
        result = (responseDto.response as List)
            .map((e) => LabelDto.fromJson(e))
            .toList();
        // debugPrint("result: $result");
      } else {
        debugPrint('vino por aquí');
        throw Exception(responseDto.errorMessage);
      }
    } else {
      throw Exception(
          "Error desconocido al intentar obtener los datos de las etiquetas.");
    }
    return result;
  }

  static Future<ResponseDto> addLabel(LabelDto newLabel, String token) async {
    ResponseDto result;
    var uri = Uri.parse("$backendUrlBase/api/v1/label");
    var body = json.encode(newLabel.toJson());
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.post(uri, headers: headers, body: body);
    if (response.statusCode == 200) {
      var responseDto = ResponseDto.fromJson(jsonDecode(response.body));
      debugPrint("backend response (ADD LABEL): ${responseDto.toJson()}");
      if (responseDto.code.toString() == '0000') {
        // si la etiqueta se guardó correctamente
        result = responseDto;
      } else {
        throw Exception(responseDto.errorMessage);
      }
    } else {
      throw Exception('Error desconocido al intentar guardar la etiqueta.');
    }
    return result;
  }

  static Future<ResponseDto> updateLabelById(
      int labelId, LabelDto newLabel, String token) async {
    ResponseDto result;
    var uri = Uri.parse("$backendUrlBase/api/v1/label/${labelId.toString()}");
    var body = json.encode(newLabel.toJson());
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.put(uri, headers: headers, body: body);
    if (response.statusCode == 200) {
      var responseDto = ResponseDto.fromJson(jsonDecode(response.body));
      debugPrint("backend response (UPDATE LABEL): ${responseDto.toJson()}");
      if (responseDto.code.toString() == '0000') {
        // si la etiqueta se actualizó correctamente
        result = responseDto;
      } else {
        throw Exception(responseDto.errorMessage);
      }
    } else {
      throw Exception('Error desconocido al intentar actualizar la etiqueta.');
    }
    return result;
  }

  static Future<ResponseDto> deleteLabelById(int labelId, String token) async {
    ResponseDto result;
    var uri = Uri.parse("$backendUrlBase/api/v1/label/${labelId.toString()}");
    var body = json.encode(labelId);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.delete(uri, headers: headers, body: body);
    if (response.statusCode == 200) {
      var responseDto = ResponseDto.fromJson(jsonDecode(response.body));
      debugPrint("backend response (DELETE LABEL): ${responseDto.toJson()}");
      if (responseDto.code.toString() == '0000') {
        // si la etiqueta se eliminó correctamente
        result = responseDto;
      } else {
        throw Exception(responseDto.errorMessage);
      }
    } else {
      throw Exception('Error desconocido al intentar eliminar la etiqueta.');
    }
    return result;
  }
}
