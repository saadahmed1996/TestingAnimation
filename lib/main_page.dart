import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_animations/book_ui.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _controller = PageController();
  final _notifierScroll = ValueNotifier(0.0);
  void _listener() {
    _notifierScroll.value = _controller.page!;
  }

  @override
  void initState() {
    _controller.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bookheight = size.height * 0.45;
    final bookWidth = size.height * 0.3;
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            bookAppBackground,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          height: kToolbarHeight,
          child: AppBar(
            centerTitle: false,
            leadingWidth: 0,
            title: Text(
              'Books',
              style: TextStyle(color: Colors.black),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
          ),
        ),
        ValueListenableBuilder<double>(
            valueListenable: _notifierScroll,
            builder: (context, value, _) {
              return PageView.builder(
                itemCount: books.length,
                controller: _controller,
                itemBuilder: ((context, index) {
                  final book = books[index];
                  final percentage = index - value;
                  final rotation = percentage.clamp(0.0, 1.0);
                  final fixRotation = pow(rotation, 0.35);
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              Container(
                                height: bookheight,
                                width: bookWidth,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 20,
                                        offset: Offset(5.0, 5.0),
                                        spreadRadius: 10,
                                      )
                                    ]),
                              ),
                              Transform(
                                alignment: Alignment.centerLeft,
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.002)
                                  ..rotateY(1.8 * fixRotation)
                                  ..translate(-rotation * size.width * 0.8)
                                  ..scale(1 + rotation),
                                child: Image.asset(
                                  book.image,
                                  fit: BoxFit.cover,
                                  height: bookheight,
                                  width: bookWidth,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 90),
                        Opacity(
                          opacity: 1 - rotation,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book.title,
                                style: TextStyle(fontSize: 30),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'By ${book.author}',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              );
            }),
      ],
    ));
  }
}
