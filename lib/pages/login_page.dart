import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/my_button.dart';
import '../components/my_textField.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //login Method
  void logIn() async {
    //loading circle
    showDialog(
        context: context,
        builder: (context){
          return Center(child: CircularProgressIndicator(color: Colors.black, backgroundColor: Colors.white,));
        }
    );

    //try logging in
    try {
      await FirebaseAuth.instance.
      signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessage(e.code, e.message);

    }
  }

  void displayMessage(String code,String? message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(code, textAlign: TextAlign.center,),
            content: Text(message!),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //logo
                  Text(
                    'T o D o',
                    style: GoogleFonts.oswald(
                        fontWeight: FontWeight.bold, fontSize: 55),
                  ),

                  SizedBox(
                    height: 40,
                  ),
                  //Welcome back message
                  Text(
                    'Welcome back, you\'ve been missed!',
                    style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  ),

                  SizedBox(
                    height: 25,
                  ),

                  //email textfield
                  MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false),

                  SizedBox(
                    height: 10,
                  ),

                  // password textfield
                  MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true),

                  // forgot password?
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Passoword?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.1,
                                color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  //login button
                  MyButton(
                    buttonText: 'Login',
                    onTap: logIn,
                  ),

                  SizedBox(
                    height: 25,
                  ),

                  //not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member? ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey[700]),
                      ),
                      GestureDetector(
                          onTap: widget.onTap,
                          child: Text(
                            'Register now!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.blue),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
