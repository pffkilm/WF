// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebViewExample extends StatefulWidget {
//   const WebViewExample ({super.key});
//
//   @override
//   State<WebViewExample> createState() => WebView();
// }
//
// class WebView  extends State<WebViewExample> {
//   late WebViewController controller;
//
//   void initState(){
//     super.initState();
//     controller = WebViewController()
//     ..loadRequest(Uri.parse('https://puzzle-english.com/'));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: WebViewWidget(
//         controller: controller,
//       ),
//     );
//   }
// }