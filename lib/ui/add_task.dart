import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:software_todo_app_v2/bloc/labels_cubit.dart';
import 'package:software_todo_app_v2/bloc/labels_state.dart';
import 'package:software_todo_app_v2/bloc/tasks_cubit.dart';
import 'package:software_todo_app_v2/models/task_model.dart';

class AddTask extends StatelessWidget {
  AddTask({Key? key}) : super(key: key);

  final taskNameInput = TextEditingController();
  final deadlineInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Nueva Tarea'),
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: taskNameInput,
              decoration: const InputDecoration(
                icon: Icon(Icons.assignment),
                labelText: 'Nombre de la tarea',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: deadlineInput,
              decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today),
                labelText: 'Fecha de cumplimiento',
              ),
              readOnly: true,
              showCursor: false,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101));
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('dd-MM-yyyy').format(pickedDate);
                  deadlineInput.text = formattedDate;
                } else {
                  debugPrint("No se seleccionó ninguna fecha");
                }
              },
            ),
            const SizedBox(height: 40),
            const Text(
              'Etiqueta:',
              style: TextStyle(fontSize: 15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<LabelsCubit, LabelsState>(
                  builder: (context, state) {
                    String? selectedLabel = state.selectedLabel;
                    return DropdownButton<String>(
                      hint: const Text('Seleccionar etiqueta'),
                      value: state.labels!.isNotEmpty ? selectedLabel : null,
                      onChanged: (newValue) {
                        BlocProvider.of<LabelsCubit>(context)
                            .selectLabel(newValue);
                      },
                      focusColor: const Color.fromARGB(255, 250, 250, 250),
                      items: state.labels!.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                    );
                  },
                ),
                const SizedBox(width: 15),
                IconButton(
                  // función que se ejecutará al apretar el botón Editar, invocará a la gestión de etiquetas
                  icon: const Icon(Icons.edit),
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.pushNamed(
                        context, '/manage_labels'); // *** TODO: arreglar
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              // función que se ejecutará al apretar el botón Cancelar, invocará al menú principal sin guardar la tarea
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            const SizedBox(width: 50),
            ElevatedButton(
              // función que se ejecutará al apretar el botón Guardar, invocará al menú principal + guardará la tarea
              onPressed: () {
                if (taskNameInput.text != "" && deadlineInput.text != "") {
                  // si el nombre de la tarea y la fecha de cumplimiento no están vacíos // TODO: considerar que el dropdown no tenga un valor seleccionado
                  Random random = Random();
                  int id = random.nextInt(
                      1000000); // genera un número aleatorio entre 0 y 999999 (para el id)
                  Task newtask = Task(
                    id: id.toString(),
                    name: taskNameInput.text,
                    deadline: deadlineInput.text,
                    label: BlocProvider.of<LabelsCubit>(context)
                        .state
                        .selectedLabel
                        .toString(),
                    state:
                        "Pendiente", // por defecto, la tarea se crea con estado "Pendiente"
                  );
                  BlocProvider.of<TasksCubit>(context).addTask(newtask);
                  debugPrint(
                      "Tarea guardada! Lista de tareas actualizada: ${BlocProvider.of<TasksCubit>(context).state.tasks.toString()}");
                  Navigator.pop(context);
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Error."),
                        content: const Text(
                            "No se puede guardar la tarea porque no se ha especificado la descripción o la fecha de cumplimiento de la misma.",
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.justify),
                        actions: [
                          TextButton(
                            child: const Text("OK"),
                            onPressed: () {
                              Navigator.pop(
                                  context); // cierra el diálogo emergente
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
