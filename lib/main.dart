import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'splash_screen.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'chat_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Message Board App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AuthenticationWrapper(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegistrationScreen(),
        '/chat': (context) => ChatScreen(
              boardId: ModalRoute.of(context)!.settings.arguments as String,
            ),
        '/profile': (context) => ProfileScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use FirebaseAuth to get the currently signed-in user
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return SplashScreen();
    } else {
      return LoginScreen();
    }
  }
}
