class LabelsState {
  List<String>? labels;
  Map<String, String>? labelsToModify =
      {}; // key: etiqueta antigua, value: etiqueta modificada // etiquetas a modificar en la pantalla de gestión de etiquetas
  String? selectedLabel; // valor seleccionado en el dropdown button

  LabelsState({
    this.labels = const [],
    this.labelsToModify = const {},
    this.selectedLabel = '',
  });
}
