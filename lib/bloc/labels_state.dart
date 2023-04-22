class LabelsState {
  final List<String>? labels;
  String? selectedLabel; // para el dropdown button

  LabelsState({
    this.labels = const [],
    this.selectedLabel = '',
  });
}
