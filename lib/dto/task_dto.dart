class TaskDto {
  int taskId;
  String description;
  String deadline;
  int labelId;
  String state;

  TaskDto({
    required this.taskId,
    required this.description,
    required this.deadline,
    required this.labelId,
    required this.state,
  });

  factory TaskDto.fromJson(Map<String, dynamic> json) {
    return TaskDto(
      taskId: json['taskId'],
      description: json['description'],
      deadline: json['deadline'],
      labelId: json['labelId'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['taskId'] = taskId;
    data['description'] = description;
    data['deadline'] = deadline;
    data['labelId'] = labelId;
    data['state'] = state;
    return data;
  }
}
