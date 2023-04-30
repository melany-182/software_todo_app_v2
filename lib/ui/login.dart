import 'package:flutter/material.dart';
import 'package:software_todo_app_v2/ui/menu.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final usernameInput = TextEditingController();
  final passwordInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/todo_icon.png',
              height: 250,
            ),
            const SizedBox(height: 30), // deja un espacio
            const Text(
              'Todo App',
              style: TextStyle(fontSize: 30),
            ),
            const Text(
              'by m.k.',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: usernameInput,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                border: OutlineInputBorder(),
                labelText: 'Usuario',
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: passwordInput,
              decoration: const InputDecoration(
                icon: Icon(Icons.lock),
                border: OutlineInputBorder(),
                labelText: 'Contraseña',
              ),
              obscureText: true,
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
              // función que se ejecutará al apretar el botón Ingresar, invocará al menú principal
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Menu(),
                  ),
                );
              },
              child: const Text('Ingresar'),
            ),
          ],
        ),
      ),
    );
  }
}
