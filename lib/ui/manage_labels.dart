import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:software_todo_app_v2/bloc/labels_cubit.dart';
import 'package:software_todo_app_v2/bloc/labels_state.dart';

class ManageLabels extends StatelessWidget {
  ManageLabels({Key? key}) : super(key: key);

  Map<String, String> labelsToModify =
      {}; // key: etiqueta antigua, value: etiqueta modificada
  List<String> labelsToDelete = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestionar Etiquetas'),
      ),
      body: BlocBuilder<LabelsCubit, LabelsState>(
        builder: (context, state) {
          if (BlocProvider.of<LabelsCubit>(context).state.labels!.isNotEmpty) {
            return Container(
              padding: const EdgeInsets.all(25),
              child: ListView.builder(
                itemCount:
                    BlocProvider.of<LabelsCubit>(context).state.labels!.length,
                itemBuilder: (context, index) {
                  String actualLabel = state.labels![index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: actualLabel,
                            decoration: const InputDecoration(
                              labelText: 'Etiqueta',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (newLabel) {
                              labelsToModify[actualLabel] = newLabel;
                              debugPrint(
                                  "Etiquetas a modificar: $labelsToModify"
                                      .toString());
                            },
                          ),
                        ),
                        const SizedBox(width: 15),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          iconSize: 30,
                          padding: const EdgeInsets.only(left: 7.5),
                          onPressed: () {
                            labelsToDelete.add(actualLabel);
                            debugPrint("Etiquetas a eliminar: $labelsToDelete"
                                .toString());
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
                // TODO: implementar la función de guardar cambios
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
            const SizedBox(width: 50),
            ElevatedButton(
              // función que se ejecutará al apretar el botón Nuevo, creará un nuevo campo de texto para añadir una nueva etiqueta
              onPressed: () {
                // TODO: implementar la función de añadir nuevo campo de texto para nueva etiqueta
              },
              child: const Text('Nuevo'),
            ),
          ],
        ),
      ),
    );
  }
}
