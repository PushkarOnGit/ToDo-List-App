import '../components/my_button.dart';
import '../components/my_textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //signUp function
  void signUp() async {
    //circular progress indicator
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.black,
            backgroundColor: Colors.white,
          ));
        });

    //check if password == confirm password
    if (passwordController.text == confirmPasswordController.text) {
      //try to register user
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

        //pop progress indicator
        Navigator.pop(context);

      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayMessage(e.code, e.message);
      }
    } else {
      Navigator.pop(context);
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Passwords Mismatch',
                textAlign: TextAlign.center,
              ),
              content: Text(
                'The \'Password\' and  \'Confirm Passoword\' field doesn\'t match with each other. Please check and try again.',
                textAlign: TextAlign.center,
              ),
            );
          });
    }
    Navigator.pop(context);
  }

  //dislay error message
  void displayMessage(String code, String? message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              code,
              textAlign: TextAlign.center,
            ),
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
                    'Register here and post a lot!',
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

                  SizedBox(
                    height: 10,
                  ),

                  // password textfield
                  MyTextField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm Password',
                      obscureText: true),

                  SizedBox(
                    height: 25,
                  ),

                  //Sign up button
                  MyButton(
                    onTap: signUp,
                    buttonText: 'Sign Up',
                  ),

                  SizedBox(
                    height: 25,
                  ),

                  //not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already a member? ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey[700]),
                      ),
                      GestureDetector(
                          onTap: widget.onTap,
                          child: Text(
                            'Login now!',
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
