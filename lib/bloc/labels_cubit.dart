import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:software_todo_app_v2/bloc/labels_state.dart';

// esta clase almacena el estado y declara los métodos que lo modifican
class LabelsCubit extends Cubit<LabelsState> {
  LabelsCubit()
      : super(LabelsState(
          labels: ['Trabajo', 'Casa', 'Personal'],
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
    labels!.add(newLabel);
    emit(LabelsState(
      labels: labels,
      selectedLabel: selectedLabel,
    ));
  }

  // TODO: implementar este método
  void editLabel(String labelToEdit, String newLabel) {}

  void deleteLabel(String labelToDelete, String selectedLabel) {
    List<String>? labels = state.labels;
    labels!.remove(labelToDelete);
    emit(LabelsState(
      labels: labels,
      selectedLabel: labels.isNotEmpty ? labels[0] : '',
    ));
  }
}
