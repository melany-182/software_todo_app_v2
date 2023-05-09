import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:software_todo_app_v2/bloc/login_state.dart';
import 'package:software_todo_app_v2/bloc/tasks_state.dart';
import 'package:software_todo_app_v2/dto/response_dto.dart';
import 'package:software_todo_app_v2/dto/task_dto.dart';
import 'package:software_todo_app_v2/services/todo_service.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(const TasksState());

  Future<void> getTasks() async {
    emit(state.copyWith(status: PageStatus.loading));
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: "Token");
    try {
      final result = await TodoService.getTasksList(token!);
      emit(state.copyWith(
        status: PageStatus.success,
        data: result,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: PageStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> addTask(TaskDto newTask) async {
    emit(state.copyWith(status: PageStatus.loading));
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: "Token");
    try {
      ResponseDto response = await TodoService.addTask(newTask, token!);
      debugPrint("response (aquí, add task cubit): ${response.toJson()}");
      emit(state.copyWith(
        status: PageStatus.success,
        data: await TodoService.getTasksList(
            token), // actualización de la lista de tareas // esto es importante
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
        status: PageStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> updateTaskById(int taskId, TaskDto newTask) async {
    emit(state.copyWith(status: PageStatus.loading));
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: "Token");
    try {
      ResponseDto response =
          await TodoService.updateTaskById(taskId, newTask, token!);
      debugPrint("response (aquí, update task cubit): ${response.toJson()}");
      emit(state.copyWith(
        status: PageStatus.success,
        data: await TodoService.getTasksList(
            token), // actualización de la lista de tareas // esto es importante
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
        status: PageStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  /* // métodos antes de la integración con el backend
  void addTask(Task newTask) {
    List<Task> tasks = state.tasks;
    tasks.add(newTask);
    emit(TasksState(tasks: tasks));
  }

  void changeTaskState(Task taskToChange) {
    List<Task> tasks = state.tasks;
    int index = tasks.indexOf(taskToChange);
    if (tasks[index].getState() == 'Pendiente') {
      tasks[index].setState('Completada');
    } else {
      tasks[index].setState('Pendiente');
    }
    emit(TasksState(tasks: tasks));
  }

  // esto no se usa
  void deleteTask(Task taskToDelete) {
    List<Task> tasks = state.tasks;
    tasks.remove(taskToDelete);
    emit(TasksState(tasks: tasks));
  }
  */
}
