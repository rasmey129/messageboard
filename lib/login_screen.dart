import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final emailCont = TextEditingController();
  final passwordCont = TextEditingController();

  Future<void> login() async{
    try {
      await _auth.signInWithEmailAndPassword(email: emailCont.text, password: passwordCont.text);
    } catch (e){
      print('login failed: e');
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(controller: emailCont, decoration: InputDecoration(labelText: 'Email')),
          TextField(
            controller: passwordCont, decoration: InputDecoration(labelText: 'Password'),
            obscureText: true),
            ElevatedButton(onPressed: login, child: Text('Login'))
        ],
      ),)
    );
  }
}