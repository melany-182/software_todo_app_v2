import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:software_todo_app_v2/bloc/labels_state.dart';
import 'package:software_todo_app_v2/bloc/login_state.dart';
import 'package:software_todo_app_v2/dto/label_dto.dart';
import 'package:software_todo_app_v2/services/labels_service.dart';

class LabelsCubit extends Cubit<LabelsState> {
  LabelsCubit() : super(const LabelsState());

  Future<void> labels() async {
    emit(state.copyWith(status: PageStatus.loading));
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: "Token");
    try {
      final result = await LabelsService().getLabelsList(token!);
      emit(state.copyWith(
        status: PageStatus.success,
        data: result,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: PageStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  // método para settear el valor seleccionado en el dropdown button
  void selectLabel(String selectedLabel) {
    emit(state.copyWith(
      selectedLabel: selectedLabel,
    ));
  }

  // para el dropdown button
  LabelDto findLabelByName(String? labelName) {
    List<LabelDto>? labels = state.data;
    for (LabelDto label in labels) {
      if (label.name == labelName) {
        return label;
      }
    }
    return LabelDto(labelId: 0, name: '');
  }

  /* // métodos antes de la integración con el backend
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

  // FIXME: arreglar
  void deleteLabel(Label labelToDelete, String? selectedLabel) {
    List<Label>? labels = state.labels;
    labels!.remove(labelToDelete);
    emit(LabelsState(
      labels: labels,
      selectedLabel: labels.isNotEmpty ? labels[0].getName() : '',
    ));
  }
  */
}
