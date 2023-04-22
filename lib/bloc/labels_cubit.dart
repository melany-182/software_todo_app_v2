import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:software_todo_app_v2/bloc/labels_state.dart';

// esta clase almacena el estado y declara los métodos que lo modifican
class LabelsCubit extends Cubit<LabelsState> {
  LabelsCubit()
      : super(LabelsState(
          labels: ['Trabajo', 'Casa', 'Personal'],
          selectedLabel: 'Trabajo',
        )); // valores iniciales

  void addLabel(String newLabel, String selectedLabel) {
    final labels = state.labels;
    labels!.add(newLabel);
    emit(LabelsState(
      labels: labels,
      selectedLabel: selectedLabel,
    ));
  }
}
