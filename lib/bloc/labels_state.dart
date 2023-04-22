class LabelsState {
  final List<String>? labels;
  String? selectedLabel; // valor seleccionado en el dropdown button

  LabelsState({
    this.labels = const [],
    this.selectedLabel = '',
  });
}
