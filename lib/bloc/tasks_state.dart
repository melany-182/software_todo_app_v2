import 'package:software_todo_app_v2/bloc/login_state.dart';
import 'package:software_todo_app_v2/dto/task_dto.dart';

class TasksState {
  final PageStatus status;
  final bool? addTaskSuccess;
  final List<TaskDto> data;
  final String? errorMessage;

  const TasksState({
    this.status = PageStatus.initial,
    this.addTaskSuccess = false,
    this.data = const [],
    this.errorMessage,
  });

  TasksState copyWith({
    PageStatus? status,
    bool? addTaskSuccess,
    List<TaskDto>? data,
    String? errorMessage,
  }) {
    return TasksState(
      status: status ?? this.status,
      addTaskSuccess: addTaskSuccess ?? this.addTaskSuccess,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  List<Object?> get props => [
        status,
        addTaskSuccess,
        data,
        errorMessage,
      ];

  /*
  final List<Task> tasks;

  TasksState({this.tasks = const []});
  */
}
