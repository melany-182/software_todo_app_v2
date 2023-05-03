import 'package:software_todo_app_v2/bloc/login_state.dart';
import 'package:software_todo_app_v2/dto/label_dto.dart';

class LabelsState {
  final PageStatus status;
  final List<LabelDto> data;
  final String? errorMessage;
  final String? selectedLabel; // valor seleccionado en el dropdown button

  const LabelsState({
    this.status = PageStatus.initial,
    this.data = const [],
    this.errorMessage,
    this.selectedLabel,
  });

  LabelsState copyWith({
    PageStatus? status,
    List<LabelDto>? data,
    String? errorMessage,
    String? selectedLabel,
  }) {
    return LabelsState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedLabel: selectedLabel ?? this.selectedLabel,
    );
  }

  List<Object?> get props => [
        status,
        data,
        errorMessage,
        selectedLabel,
      ];

  /*
  List<Label>? labels;
  Map<int, String>? labelsToModify =
      {}; // key: id etiqueta, value: valor nuevo de la etiqueta // etiquetas a modificar en la pantalla de gestión de etiquetas
  String? selectedLabel; // valor seleccionado en el dropdown button

  LabelsState({
    this.labels = const [],
    this.labelsToModify = const {},
    this.selectedLabel = '',
  });
  */
}
