import 'package:flutter/material.dart';
import 'package:responsi_123210111/dao.dart';
import 'package:responsi_123210111/home_page.dart';
import 'package:responsi_123210111/model/user.dart';
import 'package:responsi_123210111/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
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
            ElevatedButton(
                onPressed: () {
                  login();
                },
                child: Text("Login")
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterPage(),));
                },
                child: Text("Register")
            ),
            // Text("$test")
          ],
        ),
      ),
    );
  }

  // Future<void> insert() async {
  //   await DBdao().insertUser("ilham", "azhari", "1");
  // }

  Future<void> login() async {
    final user =
    await DBdao().check(_usernameController.text, _passwordController.text);

    if(user != null) {
      test = "abcd";
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('username', _usernameController.text);
      prefs.setString('password', _passwordController.text);
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));

    }
  }

}
