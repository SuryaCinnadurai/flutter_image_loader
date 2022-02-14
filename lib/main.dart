import 'package:flutter/material.dart';
import 'package:flutter_image_loader/controller.dart';
import 'package:flutter_image_loader/search_page.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final ImageController _controller = Get.put(ImageController());
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: Colors.blueGrey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Transform.translate(
                      offset: const Offset(0, -40),
                      child: const CircleAvatar(
                        backgroundColor: Color.fromRGBO(26, 27, 58, 1.0),
                        radius: 45,
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -30),
                      child: const Text(
                        'Welcome',
                        style: TextStyle(
                            fontSize: 25,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextField(
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(26, 27, 58, 1.0),
                              width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(26, 27, 58, 1.0),
                              width: 2.0),
                        ),
                        hintText: 'Pixabay images API',
                        contentPadding: EdgeInsets.all(13),
                        suffixIcon: Icon(
                          Icons.search,
                          color: Color.fromRGBO(26, 27, 58, 1.0),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6.0, left: 6.0),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              launch('https://pixabay.com/api/docs/.');
                            },
                            child: const Text(
                              'How to get pixabay images API?',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 11,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 25),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 15),
                          primary: const Color.fromRGBO(26, 27, 58, 1.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () async {
                          String url = _textEditingController.text;
                          bool isValidUrl =
                              url.contains('https://pixabay.com/api/?key=') &&
                                  url.contains('&q=') &&
                                  url.contains('&image_type=photo');
                          if (isValidUrl) {
                            _controller.onClose();
                            _controller.fetchDataFromApi(Uri.parse(url));
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    SearchPage(controller: _controller)));
                          }
                        },
                        child: const Text(
                          'Load Images',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
