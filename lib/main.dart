import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/auth/auth.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyC4jKq5UZeWIldyU7wtVavwtYcK3OX_G9Q",
      appId: "1:312525609624:android:86fbe203d5ed9704440eed",
      messagingSenderId: "312525609624",
      projectId: "todo-list-16ef5",
    ),
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        dividerTheme: DividerThemeData(
          color: Colors.transparent,

        ),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.grey[900],
          iconTheme: IconThemeData(
            color: Colors.white,
            size: 30,
          ),
          titleTextStyle: GoogleFonts.oswald(color: Colors.white, fontSize: 27,letterSpacing: 2),
        ),
        scaffoldBackgroundColor: Colors.grey[300],
      ),
      home: AuthPage(),
    );
  }
}
