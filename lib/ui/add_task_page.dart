import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:software_todo_app_v2/bloc/labels_cubit.dart';
import 'package:software_todo_app_v2/bloc/labels_state.dart';
import 'package:software_todo_app_v2/bloc/login_state.dart';
import 'package:software_todo_app_v2/bloc/tasks_cubit.dart';
import 'package:software_todo_app_v2/dto/label_dto.dart';
import 'package:software_todo_app_v2/dto/task_dto.dart';
import 'package:software_todo_app_v2/ui/manage_labels_page.dart';

class AddTaskPage extends StatelessWidget {
  AddTaskPage({Key? key}) : super(key: key);

  final labelsCubit = LabelsCubit();
  final taskNameInput = TextEditingController();
  final deadlineInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    labelsCubit.labels(); // obtención de las etiquetas mediante el cubit
    return BlocProvider(
      create: (context) => TasksCubit(),
      child: Scaffold(
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
                  border: OutlineInputBorder(),
                  labelText: 'Nombre de la tarea',
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: deadlineInput,
                decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
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
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'Etiqueta:',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocConsumer<LabelsCubit, LabelsState>(
                    bloc: labelsCubit,
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
                      } else {
                        String? selectedLabel = state.selectedLabel;
                        return Expanded(
                          child: DropdownButtonFormField<String>(
                            hint: const Text('Seleccionar etiqueta'),
                            dropdownColor:
                                const Color.fromARGB(255, 250, 250, 250),
                            focusColor:
                                const Color.fromARGB(255, 250, 250, 250),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            value: state.data.isNotEmpty ? selectedLabel : null,
                            onChanged: (newValue) {
                              BlocProvider.of<LabelsCubit>(context)
                                  .selectLabel(newValue!);
                              // debugPrint("Se seleccionó la etiqueta $newValue");
                            },
                            items: state.data.map<DropdownMenuItem<String>>(
                              (LabelDto value) {
                                return DropdownMenuItem<String>(
                                  value: value.name,
                                  child: Text(value.name),
                                );
                              },
                            ).toList(),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(width: 15),
                  IconButton(
                    // función que se ejecutará al apretar el botón Editar, invocará a la gestión de etiquetas
                    icon: const Icon(Icons.edit),
                    iconSize: 30,
                    padding: const EdgeInsets.only(left: 7.5),
                    onPressed: () {
                      /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ManageLabelsPage(),
                        ),
                      );
                      */
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
                  if (taskNameInput.text != "" &&
                      deadlineInput.text != "" &&
                      BlocProvider.of<LabelsCubit>(context)
                              .state
                              .selectedLabel !=
                          null) {
                    // si el nombre de la tarea, la fecha de cumplimiento y la etiqueta no están vacíos
                    LabelDto labelForNewTask = LabelDto(
                      labelId: BlocProvider.of<LabelsCubit>(context)
                          .findLabelByName(BlocProvider.of<LabelsCubit>(context)
                              .state
                              .selectedLabel!)
                          .labelId,
                      name: BlocProvider.of<LabelsCubit>(context)
                          .state
                          .selectedLabel!,
                    );
                    TaskDto newTask = TaskDto(
                      taskId: 0,
                      description: taskNameInput.text,
                      deadline: deadlineInput.text,
                      label: labelForNewTask,
                      state: "",
                    );
                    // se llama al cubit para que ejecute la función de agregar la tarea
                    context.read<TasksCubit>().addTask(newTask);
                    debugPrint(
                        "TAREA GUARDADA! Lista de tareas actualizada: ${BlocProvider.of<TasksCubit>(context).state.data.toString()}");
                    Navigator.pop(context);
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Error."),
                          content: const Text(
                              'No se puede guardar la tarea porque no se especificó la descripción, la fecha de cumplimiento o la etiqueta de la misma.',
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
      ),
    );
  }
}
