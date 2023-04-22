import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:software_todo_app_v2/bloc/tasks_cubit.dart';
import 'package:software_todo_app_v2/bloc/tasks_state.dart';
import 'package:software_todo_app_v2/ui/add_task.dart';

class Menu extends StatelessWidget {
  Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: Builder(builder: (context) {
        if (BlocProvider.of<TasksCubit>(context).state.tasks.isNotEmpty) {
          return Column(
            children: [
              BlocBuilder<TasksCubit, TasksState>(builder: (context, state) {
                return const SizedBox(); // TODO
              }),
            ],
          );
        } else {
          return const Center(
            child: Text(
              'No existen tareas registradas.',
              style: TextStyle(fontSize: 15),
            ),
          );
        }
      }),
      floatingActionButton: RawMaterialButton(
        // función que se ejecutará al apretar el botón +, invocará a la página de añadir tarea
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTask()));
        },
        elevation: 2,
        fillColor: const Color.fromARGB(255, 220, 214, 248),
        padding: const EdgeInsets.all(25),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 35,
        ),
      ),
    );
  }
}
