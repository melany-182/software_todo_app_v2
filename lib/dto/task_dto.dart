import 'package:software_todo_app_v2/dto/label_dto.dart';

class TaskDto {
  int taskId;
  String description;
  String deadline;
  LabelDto label;
  String state;

  TaskDto({
    required this.taskId,
    required this.description,
    required this.deadline,
    required this.label,
    required this.state,
  });

  factory TaskDto.fromJson(Map<String, dynamic> json) {
    return TaskDto(
      taskId: json['taskId'],
      description: json['description'],
      deadline: json['deadline'],
      label: json['label'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['taskId'] = taskId;
    data['description'] = description;
    data['deadline'] = deadline;
    data['label'] = label;
    data['state'] = state;
    return data;
  }
}
