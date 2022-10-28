import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

import 'package:helloworld/widgets/custom_logo.dart';
import 'package:helloworld/widgets/custom_edit.dart';
import 'package:helloworld/widgets/custom_button.dart';
import 'package:helloworld/models/usuario.dart';
import 'package:helloworld/db/database.dart';
import 'package:helloworld/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController textUsuario = TextEditingController();
  final TextEditingController textSenha = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool buttonClick = false;

  void _login() {
    if (buttonClick) {
      return;
    }

    setState(
      () {
        buttonClick = true;
      },
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Validando Informações...'),
      ),
    );

    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (_formKey.currentState!.validate()) {
          Usuario? usuario = Database().login(
            textUsuario.text.trim(),
            textSenha.text.trim(),
          );

          if (usuario == null) {
            // usuario não existe
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Usuário não encontrado.'),
                backgroundColor: Colors.red,
              ),
            );
          } else {
            Database().usuarioLogado = usuario;

            Navigator.of(context).pushReplacementNamed(Routes.HOME);
          }
        }

        setState(
          () {
            buttonClick = false;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const CustomLogo(),
              const SizedBox(height: 200),
              CustomEdit(
                controller: textUsuario,
                hintText: 'Informe o email',
                icon: Icons.person,
                validator: (value) {
                  if (value == null) {
                    return "Informe o email";
                  }

                  if (value.trim() == "") {
                    return "Informe o email";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 15),
              CustomEdit(
                controller: textSenha,
                hintText: 'Informe a senha',
                icon: Icons.password,
                isPassword: true,
                validator: (value) {
                  if (value == null) {
                    return "Informe a senha";
                  }

                  if (value.trim() == "") {
                    return "Informe a senha";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 15),
              CustomButton(
                caption: 'Entrar',
                onTap: _login,
                loading: buttonClick,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
