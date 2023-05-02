import 'package:software_todo_app_v2/models/label_model.dart';

class Task {
  int taskId;
  String description;
  String deadline;
  Label? label;
  String state;

  Task({
    this.taskId = 0,
    this.description = '',
    this.deadline = '',
    this.label,
    this.state = '',
  });

  getTaskId() {
    return taskId;
  }

  setTaskId(int taskId) {
    this.taskId = taskId;
  }

  getDescription() {
    return description;
  }

  setDescription(String description) {
    this.description = description;
  }

  getDeadline() {
    return deadline;
  }

  setDeadline(String deadline) {
    this.deadline = deadline;
  }

  getLabel() {
    return label;
  }

  setLabel(Label label) {
    this.label = label;
  }

  getState() {
    return state;
  }

  setState(String state) {
    this.state = state;
  }

  @override
  String toString() {
    return 'Task{id: $taskId, name: $description, deadline: $deadline, label: $label, state: $state}';
  }
}
