import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:word/dato/dto/word.dart';
import 'package:http/http.dart' as http;

Future<Word> fetchWord(String word) async {
  final response = await http.get(
    Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word'),
  );

  if (response.statusCode == 200) {
    final jsoneData = jsonDecode(response.body);
    print('JSONE: ответ ${jsoneData[0]}');
    return Word.fromJson(jsoneData[0] as Map<String, dynamic>);
  } else {
    throw Exception('Не удалоcь найти слово: ${response.statusCode}');
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
int _selectedIndex = 0;
  // веб
  late WebViewController controller;
  // late List<Widget> _widgetOptions;

  final TextEditingController _searchController = TextEditingController();
  Word? _currentWord;
  bool _isLoading = false;


  void _searchWord() async {
  if (_searchController.text.isEmpty) return;

  setState(() {
    _isLoading = true;
  });

  try {
    final word = await fetchWord(_searchController.text);
    setState(() {
      _currentWord = word;
      _isLoading = false;
    });
  } catch (e) {
    setState(() {
      _isLoading = false;
    });
    print('Общая ошибка: $e');
  }
}

  @override
  void initState() {
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

  }

  @override
  void dispose(){
    _searchController.dispose();
    super.dispose();
  }

    @override
    Widget build(BuildContext context) {
      final _widgetOptions = <Widget>[
        Container(
          child: Column(
            children: [
              SizedBox(height: 30),
              Container(
                width: 343,
                height: 56,
                child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    suffixIcon: IconButton(
                      icon: Image.asset('assets/images/lup2.png'),
                      onPressed: _searchWord,
                    ),
                  ),
                  onChanged: (value){
                    if(value.isEmpty){
                        _currentWord = null;
                    }
                  },
                  onFieldSubmitted: (_) => _searchWord(),
                ),
              ),
              if (_isLoading)
                Expanded(child: Center(child: CircularProgressIndicator(),)),
              if (_currentWord != null)
                Expanded(child: Center(
                  child: _buildWordResult(_currentWord!),
                )),
              if (_currentWord == null && !_isLoading)
                Expanded(child: Center(
                  child: _buildEmptyState(),
                )),
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


      void _onItemTapped(int index) {
        setState(() {
          _selectedIndex = index;
        });
      }

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
                    activeIcon: Image.asset(
                        'assets/images/dictionaryActiv.png'),
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

Widget _buildWordResult(Word word) {
  return Container(
    margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Row(
          children: [
            Text(
              word.word,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            SizedBox(width: 10),
            if (word.phonetic != null && word.phonetic!.isNotEmpty)
              Text(
                word.phonetic!,
                style: TextStyle(fontSize: 18, color: Color.fromRGBO(227, 86, 42, 1)),
              ),
            SizedBox(width: 10),
            Image.asset('assets/images/license.png')
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Part of Speech:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 10),
                if (word.meanings.isNotEmpty)
                  Text(
                    word.meanings.first.partOfSpeech,
                  ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Meanings:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromRGBO(190, 186, 179, 1),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${word.meanings.firstOrNull?.definitions.firstOrNull?.definition ?? 'Нет определения'}',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 10),
                if (word.meanings.firstOrNull?.definitions.firstOrNull?.example != null)
                  Row(
                    children: [
                      Text(
                        'Example: ',
                        style: TextStyle(fontSize: 14, color: Color(0xFF007AFF)),
                      ),
                      Expanded(
                        child: Text(
                          word.meanings.first.definitions.first.example!,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        SizedBox( height: 400,),
        Center(
          child:  ElevatedButton(
            onPressed: () {
              // Handle button press
            },
            child: Text('Add to Dictionary', style: TextStyle( fontSize: 16, fontWeight: FontWeight.w500,),),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(311, 56),
              backgroundColor: Color.fromRGBO(227, 86, 42, 1), // Background color
              foregroundColor: Colors.white, // Text color
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Padding
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // Shape
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildEmptyState() {
  return Column(
    children: [
      SizedBox(height: 150),
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
  );
}
