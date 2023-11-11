import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// ignore: must_be_immutable
class RecipeView extends StatefulWidget {
  String url;
  RecipeView(this.url, {super.key});

//  const RecipeView({super.key});

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  bool isloading = true;
  late InAppWebViewController inAppWebViewController;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 90, 31, 27),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 96, 22, 16),
        title: const Text(
          'Food  Recipe App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
            onWebViewCreated: (InAppWebViewController controller) {
              inAppWebViewController = controller;

              // setState(() {
              //   isloading = false;
              // });
            }),
      ),
    ));
  }
}
