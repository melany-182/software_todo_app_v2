import 'package:software_todo_app_v2/bloc/login_state.dart';
import 'package:software_todo_app_v2/dto/label_dto.dart';

class LabelsState {
  final PageStatus status;
  final List<LabelDto> data;
  final String? errorMessage;
  String? selectedLabel; // valor seleccionado en el dropdown button
  int? selectedLabelId; // id de la etiqueta seleccionada en el dropdown button
  Set<LabelDto>? labelsToDelete;

  LabelsState({
    this.status = PageStatus.initial,
    this.data = const [],
    this.errorMessage,
    this.selectedLabel,
    this.selectedLabelId,
    this.labelsToDelete,
  });

  LabelsState copyWith({
    PageStatus? status,
    List<LabelDto>? data,
    String? errorMessage,
    String? selectedLabel,
    int? selectedLabelId,
    Set<LabelDto>? labelsToDelete,
  }) {
    return LabelsState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedLabel: selectedLabel ?? this.selectedLabel,
      selectedLabelId: selectedLabelId ?? this.selectedLabelId,
      labelsToDelete: labelsToDelete ?? this.labelsToDelete,
    );
  }

  List<Object?> get props => [
        status,
        data,
        errorMessage,
        selectedLabel,
        selectedLabelId,
        labelsToDelete,
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
