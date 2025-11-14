
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:word/search.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
             Image.asset('assets/images/kids.png'),
            const SizedBox(height: 25),
            Text(
              'Sign up',
              style: TextStyle(fontSize: 24, color: Color.fromRGBO(60, 58, 54, 1),fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const Text(
              'Create your account!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Color.fromRGBO(120, 116, 109, 1)),
            ),

            Padding(
                padding: const EdgeInsets.all(16.0),
                child:Center(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'What do people call you?',
                            labelText: 'Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          onSaved: (String? value) {
                          },
                          validator: (String? value) {
                            return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                          },
                        ),
                        SizedBox(height: 16,),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'What do people call you?',
                            labelText: 'E-mail',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          onSaved: (String? value) {
                          },
                          validator: (String? value) {
                            return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                          },
                        ),
                        SizedBox(height: 16,),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'What do people call you?',
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onSaved: (String? value) {
                          },
                          validator: (String? value) {
                            return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                          },
                        ),
                        SizedBox(height: 90),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (context) => const BottomNavigationBarExample(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(311, 56),
                                backgroundColor: Color.fromRGBO(227, 86, 42, 1),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              child: Text('Next',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                )

            )
          ],
        ),
      ),
    );
  }
}

