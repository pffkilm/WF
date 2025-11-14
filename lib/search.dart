import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';


class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
int _selectedIndex = 0;
bool isDark = false;
  // веб
  late WebViewController controller;
  late List<Widget> _widgetOptions;

  @override
  void initState(){
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://ru.duolingo.com/'));


    _widgetOptions = <Widget>[
      Container(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    controller: controller,
                    padding: const WidgetStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    onTap: () {
                      controller.openView();
                    },
                    onChanged: (_) {
                      controller.openView();
                    },
                    backgroundColor: const WidgetStatePropertyAll<Color>(
                        Color.fromRGBO(255, 255, 255, 1)),
                    shape: WidgetStateProperty.resolveWith<OutlinedBorder?>(
                          (Set<WidgetState> states) {
                        return RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        );
                      },
                    ),
                    trailing: <Widget>[
                      Tooltip(
                        child: IconButton(
                          onPressed: null,
                          icon: Image.asset('assets/images/lup2.png'),
                        ),
                      ),
                    ],
                  );
                },
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                  return <Widget>[
                    ListTile(
                      title: Text('cooking'),
                    ),
                    ListTile(
                      title: Text('app'),
                    ),
                  ];
                },
              ),
            ),
            SizedBox(
              height: 150,
            ),
            Image.asset('assets/images/coolGirl.png'),
            SizedBox(height: 30),
            Text('No word',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(60, 58, 54, 1))),
            SizedBox(height: 15),
            Text(
              'Input something to find it in dictionary',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(120, 116, 109, 1)),
            ),
          ],
        ),
      ),
      Container(
        child: Column(
          children: [
            Text('Страница в разработке'),
          ],
        ),
      ),
      WebViewWidget(controller: controller),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
        bottomNavigationBar: Container(
          width: 375,
          height: 98,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Image.asset('assets/images/dictionary.png'),
                  activeIcon: Image.asset('assets/images/dictionaryActiv.png'),
                  label: 'Dictionary'),
              BottomNavigationBarItem(
                  icon: Image.asset('assets/images/travil.png'),
                  label: 'Training'),
              BottomNavigationBarItem(
                  icon: Image.asset('assets/images/video.png'),
                  activeIcon: Image.asset('assets/images/videoActiv.png'),
                  label: 'Video'),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Color.fromRGBO(227, 86, 42, 1),
            backgroundColor: Color(0xFFFFFFFF),
            onTap: _onItemTapped,
          ),
        ));
  }
}
