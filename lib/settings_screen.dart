import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final dobController = TextEditingController();

  Future<void> updateEmail(BuildContext context) async {
    try {
      await FirebaseAuth.instance.currentUser?.updateEmail(emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email updated')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating email')),
      );
    }
  }

  Future<void> updatePassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance.currentUser?.updatePassword(passwordController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password updated')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating password')),
      );
    }
  }

  Future<void> updateDOB(BuildContext context) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        await FirebaseFirestore.instance.collection('users').doc(userId).update({
          'dob': dobController.text,
          'updatedAt': Timestamp.now(),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('DOB updated')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating DOB')),
      );
    }
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    emailController.text = FirebaseAuth.instance.currentUser?.email ?? '';
    
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          ElevatedButton(
            onPressed: () => updateEmail(context),
            child: Text('Update Email'),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(labelText: 'New Password'),
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: () => updatePassword(context),
            child: Text('Update Password'),
          ),
          TextField(
            controller: dobController,
            decoration: InputDecoration(labelText: 'Date of Birth'),
          ),
          ElevatedButton(
            onPressed: () => updateDOB(context),
            child: Text('Update DOB'),
          ),
          ElevatedButton(
            onPressed: () => logout(context),
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}