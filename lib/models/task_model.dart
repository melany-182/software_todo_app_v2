class Task {
  String id;
  String name;
  String deadline;
  String label;
  String state;

  Task({
    this.id = '',
    this.name = '',
    this.deadline = '',
    this.label = '',
    this.state = '',
  });

  getId() {
    return id;
  }

  setId(String id) {
    this.id = id;
  }

  getName() {
    return name;
  }

  setName(String name) {
    this.name = name;
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

  setLabel(String label) {
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
    return 'Task{id: $id, name: $name, deadline: $deadline, label: $label, state: $state}';
  }
}
