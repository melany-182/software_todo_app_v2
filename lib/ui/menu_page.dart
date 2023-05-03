import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:software_todo_app_v2/bloc/login_state.dart';
import 'package:software_todo_app_v2/bloc/tasks_cubit.dart';
import 'package:software_todo_app_v2/bloc/tasks_state.dart';
import 'package:software_todo_app_v2/ui/add_task_page.dart';

class MenuPage extends StatelessWidget {
  MenuPage({Key? key}) : super(key: key);

  final tasksCubit = TasksCubit();

  @override
  Widget build(BuildContext context) {
    tasksCubit.tasks(); // obtención de las tareas a través del cubit
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: BlocConsumer<TasksCubit, TasksState>(
        bloc: tasksCubit,
        listener: (context, state) {
          if (state.status == PageStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'Error al obtener la data de las tareas: ${state.errorMessage}'),
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
                  String changeStateString = '';
                  if (state.data[index].state == 'Pendiente') {
                    changeStateString = 'COMPLETAR';
                  } else {
                    changeStateString = 'MARCAR COMO PENDIENTE';
                  }
                  Color stateStringColor = Colors.red;
                  if (state.data[index].state == 'Pendiente') {
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
                                state.data[index].state,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: stateStringColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            state.data[index].description,
                            style: const TextStyle(fontSize: 17.5),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.data[index].deadline,
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(
                            state.data[index].label.name,
                            style: const TextStyle(fontSize: 15),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                /*
                                onTap: () {
                                  // TODO: se llama al cubit para que ejecute el cambio de estado de la tarea
                                  context
                                      .read<TasksCubit>()
                                      .changeTaskState(state.data[index]);
                                  debugPrint(
                                      "Estado de la tarea actualizado! Lista de tareas actualizada: ${state.data.toString()}");
                                },
                                */
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