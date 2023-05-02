import 'package:software_todo_app_v2/models/label_model.dart';

class LabelsState {
  List<Label>? labels;
  Map<int, String>? labelsToModify =
      {}; // key: id etiqueta, value: valor nuevo de la etiqueta // etiquetas a modificar en la pantalla de gestión de etiquetas
  String? selectedLabel; // valor seleccionado en el dropdown button

  LabelsState({
    this.labels = const [],
    this.labelsToModify = const {},
    this.selectedLabel = '',
  });
}
