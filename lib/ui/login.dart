import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final usernameInput = TextEditingController();
  final passwordInput = TextEditingController();

  void dispose() {
    usernameInput.dispose();
    passwordInput.dispose();
  }

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
          children: <Widget>[
            Image.asset(
              'images/todo_icon.png',
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
                border: OutlineInputBorder(),
                labelText: 'Usuario',
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              obscureText: true,
              controller: passwordInput,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Contraseña',
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              // función que se ejecutará al apretar el botón Ingresar, invocará al menú principal
              onPressed: () {
                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Menu(),
                  ),
                );
                */
              },
              child: const Text('Ingresar'),
            ),
          ],
        ),
      ),
    );
  }
}
