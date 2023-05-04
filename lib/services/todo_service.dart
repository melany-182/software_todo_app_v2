import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:software_todo_app_v2/dto/response_dto.dart';
import 'package:software_todo_app_v2/dto/task_dto.dart';
import 'package:software_todo_app_v2/services/ip/ip.dart' as ip;
import 'package:http/http.dart' as http;

class TodoService {
  static String backendUrlBase = ip.urlBack;

  Future<List<TaskDto>> getTasksList(String token) async {
    List<TaskDto> result;
    var uri = Uri.parse("$backendUrlBase/api/v1/task");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var responseDto = ResponseDto.fromJson(jsonDecode(response.body));
      debugPrint("backend response (TASKS): ${responseDto.toJson()}");
      if (responseDto.code.toString() == '0000') {
        // && responseDto.response != null)
        result = (responseDto.response as List)
            .map((e) => TaskDto.fromJson(e))
            .toList();
        // debugPrint("result: $result");
      } else {
        debugPrint('vino por aquí');
        throw Exception(responseDto.errorMessage);
      }
    } else {
      throw Exception(
          "Error desconocido al intentar obtener los datos de las tareas.");
    }
    return result;
  }

  Future<ResponseDto> addTask(TaskDto newTask, String token) async {
    ResponseDto result;
    var uri = Uri.parse("$backendUrlBase/api/v1/task");
    var body = json.encode(newTask.toJson());
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.post(uri, headers: headers, body: body);
    if (response.statusCode == 200) {
      var responseDto = ResponseDto.fromJson(jsonDecode(response.body));
      debugPrint("backend response (ADD TASK): ${responseDto.toJson()}");
      if (responseDto.code.toString() == '0000') {
        // si la tarea se guardó correctamente
        result = responseDto;
      } else {
        throw Exception(responseDto.errorMessage);
      }
    } else {
      throw Exception('Error desconocido al intentar guardar la tarea.');
    }
    return result;
  }

  Future<ResponseDto> updateTaskById(
      int taskId, TaskDto newTask, String token) async {
    ResponseDto result;
    var uri = Uri.parse("$backendUrlBase/api/v1/task/${taskId.toString()}");
    var body = json.encode(newTask.toJson());
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.put(uri, headers: headers, body: body);
    if (response.statusCode == 200) {
      var responseDto = ResponseDto.fromJson(jsonDecode(response.body));
      debugPrint("backend response (UPDATE TASK): ${responseDto.toJson()}");
      if (responseDto.code.toString() == '0000') {
        // si la tarea se actualizó correctamente
        result = responseDto;
      } else {
        throw Exception(responseDto.errorMessage);
      }
    } else {
      throw Exception('Error desconocido al intentar actualizar la tarea.');
    }
    return result;
  }
}
