import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:software_todo_app_v2/bloc/labels_cubit.dart';
import 'package:software_todo_app_v2/bloc/labels_state.dart';
import 'package:software_todo_app_v2/bloc/login_state.dart';
import 'package:software_todo_app_v2/bloc/tasks_cubit.dart';
import 'package:software_todo_app_v2/bloc/tasks_state.dart';
import 'package:software_todo_app_v2/dto/label_dto.dart';
import 'package:software_todo_app_v2/dto/task_dto.dart';
import 'package:software_todo_app_v2/ui/manage_labels_page.dart';
import 'package:software_todo_app_v2/ui/menu_page.dart';

class AddTaskPage extends StatelessWidget {
  AddTaskPage({Key? key}) : super(key: key);

  final labelsCubit = LabelsCubit();
  final taskNameInput = TextEditingController();
  final deadlineInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    labelsCubit.labels(); // obtención de las etiquetas mediante el cubit
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Nueva Tarea'),
      ),
      body: BlocConsumer<TasksCubit, TasksState>(
        listener: (context, state) {
          if (state.status == PageStatus.success &&
              state.addTaskSuccess == true) {
            // si el cubit verifica que la tarea se guardó correctamente, se vuelve a la página anterior
            // Navigator.pop(context); // FIXME: al hacer pop, se vuelve a la página anterior, pero no se actualiza la lista de tareas
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MenuPage()),
                (route) => route.isFirst);
          } else if (state.status == PageStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text('Error al guardar la tarea: ${state.errorMessage}'),
              ),
            );
          }
        },
        builder: (context, state) {
          return Container(
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
                              value:
                                  state.data.isNotEmpty ? selectedLabel : null,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ManageLabelsPage()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          return BottomAppBar(
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
                state.status == PageStatus.loading
                    ? const CircularProgressIndicator()
                    : BlocListener<LabelsCubit, LabelsState>(
                        listener: (context, state) {},
                        child: ElevatedButton(
                          // función que se ejecutará al apretar el botón Guardar, agregará la tarea
                          onPressed: state.status == PageStatus.loading
                              ? null
                              : () {
                                  if (taskNameInput.text != "" &&
                                      deadlineInput.text != "" &&
                                      BlocProvider.of<LabelsCubit>(context)
                                              .state
                                              .selectedLabel !=
                                          null) {
                                    // si el nombre de la tarea, la fecha de cumplimiento y la etiqueta no están vacíos
                                    TaskDto newTask = TaskDto(
                                      taskId: 0,
                                      description: taskNameInput.text,
                                      deadline: deadlineInput.text,
                                      labelId:
                                          BlocProvider.of<LabelsCubit>(context)
                                              .state
                                              .selectedLabelId!,
                                      state: "",
                                    );
                                    debugPrint(
                                        "newTask: ${newTask.toJson().toString()}");
                                    // se llama al cubit para que ejecute la función de agregar la tarea
                                    BlocProvider.of<TasksCubit>(context)
                                        .addTask(newTask);
                                    // se actualiza la lista de tareas
                                    BlocProvider.of<TasksCubit>(context).tasks;
                                    debugPrint(
                                        "TAREA GUARDADA! Lista de tareas actualizada: ${BlocProvider.of<TasksCubit>(context).state.data.toString()}");
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
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
