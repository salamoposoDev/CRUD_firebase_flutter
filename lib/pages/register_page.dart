// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({
    super.key,
    required this.showLoginPage,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // CollectionReference users = FirebaseFirestore.instance.collection('users');
  // INPUT TEXT CONTOLLER
  final _textFullnameController = TextEditingController();
  final _textEmailController = TextEditingController();
  final _textPassController = TextEditingController();
  final _textPassValidation = TextEditingController();
  final _textAgeController = TextEditingController();

  @override
  void dispose() {
    _textFullnameController.dispose();
    _textEmailController.dispose();
    _textPassController.dispose();
    _textPassValidation.dispose();
    _textAgeController.dispose();
    super.dispose();
  }

  // Future registerUser(String fullname, String email, String password) async {
  //   await users.add({
  //     'name': fullname,
  //     'email': email,
  //     'password': password,
  //   });
  // }

  Future signUp() async {
    // final uid = FirebaseAuth.instance.currentUser;
    showDialog(
      context: context,
      builder: (index) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.deepPurple,
          ),
        );
      },
    );
    if (confirmPassword()) {
      FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _textEmailController.text.trim(),
        password: _textPassController.text.trim(),
      );

      DatabaseReference pushData = FirebaseDatabase.instance.ref('user').push();
      await pushData.set({
        'nama': _textFullnameController.text,
        'email': _textEmailController.text,
        'age': _textAgeController.text,
        'password': _textPassController.text,
      });
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // registerUser(
      //   _textFullnameController.text.trim(),
      //   _textEmailController.text.trim(),
      //   _textPassController.text.trim(),
      // );
    }
  }

  bool confirmPassword() {
    if (_textPassValidation.text.trim() == _textPassController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      // ignore: prefer_const_literals_to_create_immutables
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.app_registration,
                  size: 100,
                ),
                // HELLO
                const SizedBox(height: 45),
                Text(
                  'Hello There!',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 36,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Register Below With Your Details',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 60),
                // NAME TEXT FIELD
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: TextField(
                        controller: _textFullnameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Full Name',
                          // ignore: prefer_const_constructors
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              _textFullnameController.clear();
                            },
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // AGE TEXT FIELD
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: TextField(
                        controller: _textAgeController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Age',
                            prefixIcon: Icon(Icons.numbers)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // EMAIL TEXT FIELD
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: TextField(
                        controller: _textEmailController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                            prefixIcon: const Icon(
                              Icons.email,
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  _textEmailController.clear();
                                },
                                icon: const Icon(Icons.clear))),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // PASSWORD TEXT FIELD
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: TextField(
                        controller: _textPassController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          prefixIcon: const Icon(
                            Icons.password,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.visibility),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // VALIDATE PASSWORD TEXT FIELD
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: TextField(
                        controller: _textPassValidation,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Confirm Password',
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.visibility),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // REGISTER BUTTON
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: GestureDetector(
                    onTap: signUp,
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                        child: Text(
                          'Sign Up ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                // NOT A MEMBER? REGISTER NOW
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Im a member',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: const Text(
                        ' Login Now',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
