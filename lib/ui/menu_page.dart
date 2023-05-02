import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:software_todo_app_v2/bloc/tasks_cubit.dart';
import 'package:software_todo_app_v2/bloc/tasks_state.dart';
import 'package:software_todo_app_v2/ui/add_task_page.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          if (BlocProvider.of<TasksCubit>(context).state.tasks.isNotEmpty) {
            return Container(
              padding: const EdgeInsets.all(25),
              child: ListView.builder(
                itemCount:
                    BlocProvider.of<TasksCubit>(context).state.tasks.length,
                itemBuilder: (context, index) {
                  String changeStateString = '';
                  if (BlocProvider.of<TasksCubit>(context)
                          .state
                          .tasks[index]
                          .getState() ==
                      'Pendiente') {
                    changeStateString = 'COMPLETAR';
                  } else {
                    changeStateString = 'MARCAR COMO PENDIENTE';
                  }
                  Color stateStringColor = Colors.red;
                  if (BlocProvider.of<TasksCubit>(context)
                          .state
                          .tasks[index]
                          .getState() ==
                      'Pendiente') {
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
                                BlocProvider.of<TasksCubit>(context)
                                    .state
                                    .tasks[index]
                                    .getState(),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: stateStringColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            BlocProvider.of<TasksCubit>(context)
                                .state
                                .tasks[index]
                                .getDescription(),
                            style: const TextStyle(fontSize: 17.5),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            BlocProvider.of<TasksCubit>(context)
                                .state
                                .tasks[index]
                                .getDeadline(),
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(
                            BlocProvider.of<TasksCubit>(context)
                                .state
                                .tasks[index]
                                .getLabel()
                                .getName(),
                            style: const TextStyle(fontSize: 15),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  BlocProvider.of<TasksCubit>(context)
                                      .changeTaskState(
                                          BlocProvider.of<TasksCubit>(context)
                                              .state
                                              .tasks[index]);
                                  debugPrint(
                                      "Estado de la tarea actualizado! Lista de tareas actualizada: ${BlocProvider.of<TasksCubit>(context).state.tasks.toString()}");
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
                      /* // botón para eliminar tarea
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTaskPage(),
              ),
            );
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
