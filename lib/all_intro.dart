import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:word/sigUpValidation.dart';
import 'package:word/signUp.dart';


class AllIntro extends StatefulWidget {
  const AllIntro({super.key});

  @override
  State<AllIntro> createState() => _all_intro();
}

class _all_intro extends State<AllIntro> {
  final _controller = PageController();
  int _countPage =0;

  void _nextPage() {
    if (_controller.page! < 2) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const MyCustomForm()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.hasClients) {
        setState(() {
          _countPage = _controller.page!.round();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: [
              Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/intro11.png'),
                      const SizedBox(height: 16),
                      Text(
                        'Learn anytime \nand anywhere',
                        style: TextStyle(fontSize: 24, color: Color.fromRGBO(60, 58, 54, 1),fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      const Text(
                        'Quarantine is the perfect time to spend your \nday learning something new, from anywhere!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/intro2.png'),
                      const SizedBox(height: 16),
                      Text(
                        'Find a course \nfor you',
                        style: TextStyle(fontSize: 24, color: Color.fromRGBO(60, 58, 54, 1),fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      const Text(
                        'Quarantine is the perfect time to spend your \nday learning something new, from anywhere!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/intro3.png'),
                      const SizedBox(height: 16),
                      Text(
                        'Improve your skills',
                        style: TextStyle(fontSize: 24, color: Color.fromRGBO(60, 58, 54, 1),fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      const Text(
                        'Quarantine is the perfect time to spend your \nday learning something new, from anywhere!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Color.fromRGBO(120, 116, 109, 1),fontWeight: FontWeight.w400,),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              top: 40,
              right: 20,
              child:
             TextButton(onPressed: (){
               Navigator.of(context).push(
                 MaterialPageRoute<void>(
                   builder: (context) => const MyCustomForm(),
                 ),
               );
             } ,
                 child:  Text('Skip',
                   style: TextStyle(
                       color: Color.fromRGBO(120, 116, 109, 1),
                   fontSize: 14,
                   fontWeight: FontWeight.w500),
                 ))
          ),
          Positioned(
            bottom: 190,
              left: 0,
              right: 0,
              child :Center(
                child: Container(
                  child:
                  SmoothPageIndicator(
                    controller: _controller,  // PageController
                    count:  3,
                    effect: ExpandingDotsEffect(
                      activeDotColor: Color.fromRGBO(101, 170, 234, 1),
                      dotColor: Color.fromRGBO(213, 212, 212, 1),
                      dotHeight: 6 ,
                      dotWidth: 6,
                    ),
                  ),
                ),
              ),
          ),
            Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  _nextPage();
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
                child: Text(_countPage == 2 ? 'Let’s Start': 'Next',
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

    );

  }
  }
