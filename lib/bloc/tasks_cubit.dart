import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:software_todo_app_v2/bloc/tasks_state.dart';
import 'package:software_todo_app_v2/models/task_model.dart';

// esta clase almacena el estado y declara los métodos que lo modifican
class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksState(tasks: []));

  void addTask(Task newTask) {
    final tasks = state.tasks;
    tasks.add(newTask);
    emit(TasksState(tasks: tasks));
  }
}
