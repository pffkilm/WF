import 'package:flutter/material.dart';
import 'package:word/all_intro.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _splash_screen();
}

class _splash_screen extends State<SplashScreen> {


  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => const AllIntro(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/splash_girl.png'),
            Text('WordsFactory',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                  color: Color.fromRGBO(60, 58, 54, 1)
              ),
              ),
          ],
        ),
      ),

    );
  }
}

