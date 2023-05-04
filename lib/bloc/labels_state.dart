import 'package:software_todo_app_v2/bloc/login_state.dart';
import 'package:software_todo_app_v2/dto/label_dto.dart';

class LabelsState {
  final PageStatus status;
  final List<LabelDto> data;
  final String? errorMessage;
  final bool? addLabelSuccess;
  final bool? updateLabelSuccess;
  final bool? deleteLabelSuccess;
  final String? selectedLabel; // valor seleccionado en el dropdown button
  final int?
      selectedLabelId; // id de la etiqueta seleccionada en el dropdown button

  const LabelsState({
    this.status = PageStatus.initial,
    this.data = const [],
    this.errorMessage,
    this.addLabelSuccess = false,
    this.updateLabelSuccess = false,
    this.deleteLabelSuccess = false,
    this.selectedLabel,
    this.selectedLabelId,
  });

  LabelsState copyWith({
    PageStatus? status,
    List<LabelDto>? data,
    String? errorMessage,
    bool? addLabelSuccess,
    bool? updateLabelSuccess,
    bool? deleteLabelSuccess,
    String? selectedLabel,
    int? selectedLabelId,
  }) {
    return LabelsState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
      addLabelSuccess: addLabelSuccess ?? this.addLabelSuccess,
      updateLabelSuccess: updateLabelSuccess ?? this.updateLabelSuccess,
      deleteLabelSuccess: deleteLabelSuccess ?? this.deleteLabelSuccess,
      selectedLabel: selectedLabel ?? this.selectedLabel,
      selectedLabelId: selectedLabelId ?? this.selectedLabelId,
    );
  }

  List<Object?> get props => [
        status,
        data,
        addLabelSuccess,
        updateLabelSuccess,
        deleteLabelSuccess,
        errorMessage,
        selectedLabel,
        selectedLabelId,
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
