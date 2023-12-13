import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_app/features/login_page/login_bloc/login_bloc.dart';
import 'package:medicine_app/features/login_page/login_bloc/login_event.dart';
import 'package:medicine_app/features/login_page/login_bloc/login_state.dart';
import 'package:medicine_app/features/main_page/main_screen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    return BlocProvider(
      create: (context) => AuthBloc(firebaseAuth: _firebaseAuth),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authBloc = BlocProvider.of<AuthBloc>(context);

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticatedState) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FailureState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('Error: ${state.error}'),
                  duration: Duration(seconds: 2),
                ),
              );
            });
            return buildLoginForm(emailController, passwordController, _authBloc);
          } else {
            return buildLoginForm(emailController, passwordController, _authBloc);
          }
        },
      ),
    );
  }

  Widget buildLoginForm(TextEditingController emailController,
      TextEditingController passwordController, AuthBloc _authBloc) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Image.asset('images/finance.png', height: 150, width: 150),
        SizedBox(height: 10),
        Center(child: Container(
          margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
          child: Text('Добро пожаловать!', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),))),
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'Логин',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20.0),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Пароль',
            border: OutlineInputBorder(),
          ),
        ),
        
        SizedBox(height: 20.0),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            minimumSize: Size(double.infinity, 50),
          ),
          onPressed: () {
            _authBloc.add(LoginButtonPressed(
              username: emailController.text,
              password: passwordController.text,
            ));
          },
          child: Text('Войти', style: TextStyle(fontSize: 18, color: Colors.white), ),
        ),
      ],
    );
  }
}
