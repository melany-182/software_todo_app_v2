import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:software_todo_app_v2/bloc/labels_cubit.dart';
import 'package:software_todo_app_v2/bloc/labels_state.dart';
import 'package:software_todo_app_v2/bloc/login_state.dart';
import 'package:software_todo_app_v2/bloc/tasks_cubit.dart';
import 'package:software_todo_app_v2/bloc/tasks_state.dart';
import 'package:software_todo_app_v2/dto/task_dto.dart';
import 'package:software_todo_app_v2/ui/add_task_page.dart';

class MenuPage extends StatelessWidget {
  MenuPage({Key? key}) : super(key: key);

  final tasksCubit = TasksCubit();
  final labelsCubit = LabelsCubit();

  @override
  Widget build(BuildContext context) {
    tasksCubit.tasks(); // obtención de las tareas a través del cubit
    labelsCubit.labels(); // obtención de las etiquetas a través del cubit
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: BlocConsumer<TasksCubit, TasksState>(
        bloc: tasksCubit,
        listener: (context, state) {
          if (tasksCubit.state.status == PageStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'Error al obtener la data de las tareas: ${state.errorMessage}'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (tasksCubit.state.status == PageStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (tasksCubit.state.data.isNotEmpty) {
            return Container(
              padding: const EdgeInsets.all(25),
              child: ListView.builder(
                itemCount: tasksCubit.state.data.length,
                itemBuilder: (context, index) {
                  String changeStateString = '';
                  if (tasksCubit.state.data[index].state == 'Pendiente') {
                    changeStateString = 'COMPLETAR';
                  } else {
                    changeStateString = 'MARCAR COMO PENDIENTE';
                  }
                  Color stateStringColor = Colors.red;
                  if (tasksCubit.state.data[index].state == 'Pendiente') {
                    stateStringColor = Colors.red;
                  } else {
                    stateStringColor = Colors.green;
                  }
                  return Card(
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 7.5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                tasksCubit.state.data[index].state,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: stateStringColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            tasksCubit.state.data[index].description,
                            style: const TextStyle(fontSize: 17.5),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tasksCubit.state.data[index].deadline,
                            style: const TextStyle(fontSize: 15),
                          ),
                          BlocBuilder<LabelsCubit, LabelsState>(
                            bloc: labelsCubit,
                            builder: (context, state) {
                              String taskLabel = '';
                              for (int i = 0;
                                  i < labelsCubit.state.data.length;
                                  i++) {
                                if (tasksCubit.state.data[index].labelId ==
                                    labelsCubit.state.data[i].labelId) {
                                  taskLabel = labelsCubit.state.data[i].name;
                                }
                              }
                              return Text(
                                taskLabel,
                                style: const TextStyle(fontSize: 15),
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  String newState = '';
                                  if (tasksCubit.state.data[index].state ==
                                      'Pendiente') {
                                    newState = 'Completada';
                                  } else {
                                    newState = 'Pendiente';
                                  }
                                  TaskDto newTask = TaskDto(
                                      taskId:
                                          tasksCubit.state.data[index].taskId,
                                      description: tasksCubit
                                          .state.data[index].description,
                                      deadline:
                                          tasksCubit.state.data[index].deadline,
                                      state: newState,
                                      labelId:
                                          tasksCubit.state.data[index].labelId);
                                  // se llama al cubit para que ejecute el cambio de estado de la tarea
                                  tasksCubit.updateTaskById(
                                      tasksCubit.state.data[index].taskId,
                                      newTask);
                                  // se llama al cubit para que actualice la lista de tareas
                                  tasksCubit.tasks();
                                },
                                child: Text(
                                  changeStateString,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                      /* // botón para eliminar tarea // antes de la integración con el backend
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              BlocProvider.of<TasksCubit>(context).deleteTask(
                                  BlocProvider.of<TasksCubit>(context)
                                      .state
                                      .tasks[index]);
                            },
                          ),
                          */
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: Text(
                'No existen tareas registradas.',
                style: TextStyle(fontSize: 15),
              ),
            );
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: RawMaterialButton(
          // función que se ejecutará al apretar el botón +, invocará a la página de añadir tarea
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddTaskPage()));
          },
          elevation: 2,
          fillColor: const Color.fromARGB(255, 220, 214, 248),
          padding: const EdgeInsets.all(15),
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
    );
  }
}
