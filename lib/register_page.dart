import 'package:flutter/material.dart';
import 'package:responsi_123210111/dao.dart';
import 'package:responsi_123210111/home_page.dart';
import 'package:responsi_123210111/login_page.dart';
import 'package:responsi_123210111/model/user.dart';
import 'package:responsi_123210111/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password1Controller = TextEditingController();

  String buatNgetes = "";
  var test;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration:  InputDecoration(
                  hintText: "username"
              ),
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration:  InputDecoration(
                hintText: "password",
              ),
            ),
            TextFormField(
              controller: _password1Controller,
              obscureText: true,
              decoration:  InputDecoration(
                hintText: "password lagi",
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  insert();
                },
                child: Text("Register")
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                },
                child: Text("Login")
            ),
            // Text("$test")
          ],
        ),
      ),
    );
  }

  Future<void> insert() async {
    if(_passwordController.text == _password1Controller.text) {
      await DBdao().insertUser(_usernameController.text, _passwordController.text, "0");
    }
  }

  // Future<void> login() async {
  //   final user =
  //   await DBdao().check(_usernameController.text, _passwordController.text);
  //
  //   if(user != null) {
  //     test = "abcd";
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.setString('username', _usernameController.text);
  //     prefs.setString('password', _passwordController.text);
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
  //
  //   }
  // }

}
