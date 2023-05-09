import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:software_todo_app_v2/bloc/labels_cubit.dart';
import 'package:software_todo_app_v2/bloc/labels_state.dart';
import 'package:software_todo_app_v2/bloc/login_state.dart';
import 'package:software_todo_app_v2/dto/label_dto.dart';

class ManageLabelsPage extends StatelessWidget {
  ManageLabelsPage({Key? key}) : super(key: key);

  final List<LabelDto> labelsToModify = [];

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LabelsCubit>(context)
        .getLabels(); // obtención de las etiquetas mediante el cubit
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestionar Etiquetas'),
      ),
      body: BlocConsumer<LabelsCubit, LabelsState>(
        listener: (context, state) {
          if (state.status == PageStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'Error al obtener la data de las etiquetas: ${state.errorMessage}'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == PageStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.data.isNotEmpty) {
            return Container(
              padding: const EdgeInsets.all(25),
              child: ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  LabelDto actualLabel = state.data[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: actualLabel.name,
                            decoration: const InputDecoration(
                              labelText: 'Etiqueta',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (modifiedValue) {
                              LabelDto newLabel = LabelDto(
                                labelId: actualLabel.labelId,
                                name: modifiedValue,
                              );
                              var found = false;
                              for (int i = 0; i < labelsToModify.length; i++) {
                                // se busca si la etiqueta ya está en la lista de etiquetas a modificar
                                if (labelsToModify[i].labelId ==
                                    actualLabel.labelId) {
                                  labelsToModify[i] = newLabel;
                                  found = true;
                                  break;
                                }
                              }
                              if (!found) {
                                // si no se encontró, se añade a la lista de etiquetas a modificar
                                labelsToModify.add(newLabel);
                              }
                              debugPrint(
                                  "labelsToModify: ${labelsToModify.toString()}");
                            },
                          ),
                        ),
                        const SizedBox(width: 15),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          iconSize: 30,
                          padding: const EdgeInsets.only(left: 7.5),
                          onPressed: state.status == PageStatus.loading
                              ? null
                              : () {
                                  if (context
                                          .read<LabelsCubit>()
                                          .state
                                          .selectedLabelId ==
                                      actualLabel.labelId) {
                                    // para que el dropdown no tire error
                                    context
                                        .read<LabelsCubit>()
                                        .state
                                        .selectedLabel = null;
                                  }
                                  // FIXME: se llama al cubit para que ejecute la función de eliminar etiqueta // esto no debería realizarse aquí
                                  context
                                      .read<LabelsCubit>()
                                      .deleteLabelById(actualLabel.labelId);
                                },
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: Text(
                'No existen etiquetas.',
                style: TextStyle(fontSize: 15),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              // función que se ejecutará al apretar el botón Cerrar, invocará a la página de añadir tarea sin guardar ningún cambio
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cerrar'),
            ),
            const SizedBox(width: 50),
            ElevatedButton(
              // función que se ejecutará al apretar el botón Guardar, invocará a la página de añadir tarea + guardará todos los cambios
              onPressed: () {
                // TODO: implementar función de guardar cambios para delete label

                // se llama al cubit para que ejecute la función de modificar etiqueta, para todas las etiquetas a modificar
                for (int i = 0; i < labelsToModify.length; i++) {
                  context.read<LabelsCubit>().updateLabelById(
                      labelsToModify[i].labelId, labelsToModify[i]);
                  if (context.read<LabelsCubit>().state.selectedLabelId ==
                      labelsToModify[i].labelId) {
                    // para que no se pierda la etiqueta seleccionada y el dropdown no tire error
                    context
                        .read<LabelsCubit>()
                        .selectLabel(labelsToModify[i].name);
                    break;
                  }
                }

                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
            const SizedBox(width: 50),
            ElevatedButton(
              // función que se ejecutará al apretar el botón Nuevo, creará un nuevo campo de texto para añadir una nueva etiqueta
              onPressed: () {
                LabelDto newLabel =
                    LabelDto(labelId: 0, name: 'Nueva etiqueta');
                // se llama al cubit para que ejecute la función de añadir etiqueta
                context.read<LabelsCubit>().addLabel(newLabel);
              },
              child: const Text('Nuevo'),
            ),
          ],
        ),
      ),
    );
  }
}
