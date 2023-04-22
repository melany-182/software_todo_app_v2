class Task {
  String id;
  String name;
  String deadline;
  String label; // *
  String state;

  Task({
    this.id = '',
    this.name = '',
    this.deadline = '',
    this.label = '',
    this.state = '',
  });

  getTaskId() {
    return id;
  }

  setTaskId(String id) {
    this.id = id;
  }

  getTaskName() {
    return name;
  }

  setTaskName(String name) {
    this.name = name;
  }

  getTaskDeadline() {
    return deadline;
  }

  setTaskDeadline(String deadline) {
    this.deadline = deadline;
  }

  getTaskLabel() {
    return label;
  }

  setTaskLabel(String label) {
    this.label = label;
  }

  getTaskState() {
    return state;
  }

  setTaskState(String state) {
    this.state = state;
  }
}
