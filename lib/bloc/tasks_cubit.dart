import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:software_todo_app_v2/bloc/tasks_state.dart';
import 'package:software_todo_app_v2/models/task_model.dart';

// esta clase almacena el estado y declara los métodos que lo modifican
class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksState(tasks: []));

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

  void deleteTask(Task taskToDelete) {
    List<Task> tasks = state.tasks;
    tasks.remove(taskToDelete);
    emit(TasksState(tasks: tasks));
  }
}
