import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:software_todo_app_v2/bloc/labels_state.dart';

// esta clase almacena el estado y declara los métodos que lo modifican
class LabelsCubit extends Cubit<LabelsState> {
  List<String>? copyOfLabels = [];

  LabelsCubit()
      : super(LabelsState(
          labels: ['Trabajo', 'Casa', 'Personal'],
          labelsToModify: {},
          selectedLabel: 'Trabajo',
        )); // valores iniciales

  // método para cambiar el valor seleccionado en el dropdown button
  void selectLabel(String? selectedLabel) {
    List<String>? labels = state.labels;
    emit(LabelsState(
      labels: labels,
      selectedLabel: selectedLabel,
    ));
  }

  void addLabel(String newLabel, String selectedLabel) {
    List<String>? labels = state.labels;
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
  void modifyLabel(String labelToEdit, String newLabel) {}

  // TODO: arreglar ***
  void deleteLabel(String labelToDelete, String selectedLabel) {
    List<String>? labels = state.labels;
    labels!.remove(labelToDelete);
    emit(LabelsState(
      labels: labels,
      selectedLabel: labels.isNotEmpty ? labels[0] : '',
    ));
  }
}
