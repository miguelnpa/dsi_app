import 'package:flutter/material.dart';
import "screens/edit_suggestion.dart";
import 'screens/random_words.dart';

void main() => runApp(StartupGenerator());

class StartupGenerator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
      ).copyWith(
        secondary: Colors.blue[800],
      )),
      title: 'Startup Name Generator',
      home: RandomWords(),
      routes: {
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/edit': (context) => EditSuggestion(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
