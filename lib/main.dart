import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:software_todo_app_v2/bloc/labels_cubit.dart';
import 'package:software_todo_app_v2/bloc/login_cubit.dart';
import 'package:software_todo_app_v2/bloc/tasks_cubit.dart';
import 'package:software_todo_app_v2/ui/add_task_page.dart';
import 'package:software_todo_app_v2/ui/login_page.dart';
import 'package:software_todo_app_v2/ui/manage_labels_page.dart';
import 'package:software_todo_app_v2/ui/menu_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // este es el nivel más alto de la aplicación
    return MultiBlocProvider(
      providers: [
        BlocProvider<TasksCubit>(create: (context) => TasksCubit()),
        BlocProvider<LabelsCubit>(create: (context) => LabelsCubit()),
        BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
      ],
      child: MaterialApp(
        title: 'Software Todo App v2',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          '/menu': (context) => const MenuPage(),
          '/add_task': (context) => AddTaskPage(),
          '/manage_labels': (context) => ManageLabelsPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
