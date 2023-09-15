

import 'package:flutter/material.dart';
import 'package:many_games/home_page.dart';
import 'package:many_games/player_names.dart';
import 'package:many_games/tic_tac_toe.dart';
import 'package:many_games/xylophone.dart';

void main() => runApp(const ManyGames());

class ManyGames extends StatelessWidget {
  const ManyGames({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.amberAccent,
        appBarTheme: const AppBarTheme(
          color: Colors.amberAccent,
        ),
      ),
      routes: {
        '/home_page': (context) => const HomePage(), // Define the home route
        '/player_names' : (context) =>  TakePlayerNames(),
        '/tic_tac_toe': (context) => const TicTacToe(), // Define the TicTacToe route
        '/xylophone' :(context) =>  XyloPhone(),
      },
    );
  }
}