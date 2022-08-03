import 'package:flutter/material.dart';
import 'package:cardcreditflutter/Src/Home.dart';

import 'Src/Constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(
      cardsData: [
        CreditCardData(
          backgroundColor: Colors.orange,
        ),
        CreditCardData(
          backgroundColor: Colors.grey.shade900,
        ),
        CreditCardData(
          backgroundColor: Colors.cyan,
        ),
        CreditCardData(
          backgroundColor: Colors.blue,
        ),
        CreditCardData(
          backgroundColor: Colors.purple,
        ),
      ],
    ),
    );
  }
}


