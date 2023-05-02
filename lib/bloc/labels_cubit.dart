import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:software_todo_app_v2/bloc/labels_state.dart';
import 'package:software_todo_app_v2/models/label_model.dart';

// esta clase almacena el estado y declara los métodos que lo modifican
class LabelsCubit extends Cubit<LabelsState> {
  List<Label>? copyOfLabels = [];

  LabelsCubit()
      : super(LabelsState(
          labels: [
            Label(labelId: 1, name: 'Trabajo'),
            Label(labelId: 2, name: 'Casa'),
            Label(labelId: 3, name: 'Personal'),
          ],
          labelsToModify: {},
          selectedLabel: 'Trabajo',
        )); // valores iniciales

  // método para cambiar el valor seleccionado en el dropdown button
  void selectLabel(String? selectedLabel) {
    List<Label>? labels = state.labels;
    emit(LabelsState(
      labels: labels,
      selectedLabel: selectedLabel,
    ));
  }

  // para el dropdown button
  Label findLabelByName(String labelName) {
    List<Label>? labels = state.labels;
    Label label =
        labels!.firstWhere((element) => element.getName() == labelName);
    return label;
  }

  void addLabel(Label newLabel, String? selectedLabel) {
    List<Label>? labels = state.labels;
    copyOfLabels = labels;
    debugPrint("Lista original de etiquetas: ${copyOfLabels.toString()}");
    labels!.add(newLabel);
    debugPrint("Lista extendida de etiquetas: ${labels.toString()}");
    emit(LabelsState(
      labels: labels,
      selectedLabel: selectedLabel,
    ));
  }

  // TODO: implementar este método
  void modifyLabel(Label labelToEdit, String newLabel) {}

  // TODO: arreglar ***
  void deleteLabel(Label labelToDelete, String? selectedLabel) {
    List<Label>? labels = state.labels;
    labels!.remove(labelToDelete);
    emit(LabelsState(
      labels: labels,
      selectedLabel: labels.isNotEmpty ? labels[0].getName() : '',
    ));
  }
}
