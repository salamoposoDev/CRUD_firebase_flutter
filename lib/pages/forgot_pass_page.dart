import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content:
                  Text('Reset password link has been send! Check your Email'),
            );
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Enter Your Email and we will send you reset password link',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: ('Email'),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          MaterialButton(
            onPressed: passwordReset,
            color: Colors.deepPurple[400],
            child: const Text(
              'Reset Password',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
