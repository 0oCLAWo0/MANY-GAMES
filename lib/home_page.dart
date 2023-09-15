import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static String player1Name = 'PLAYER 1';
  static String player2Name = 'PLAYER 2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WELCOME'),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          genrateOptionButton(context, 'TIC TAC TOE', () {
            Navigator.pushNamed(context, '/player_names');
          }, Colors.green),
          genrateOptionButton(context, 'Xylophone', () {
            Navigator.pushNamed(context, '/xylophone');
          }, Colors.redAccent),
        ],
      )),
    );
  }

  Widget genrateOptionButton(
      BuildContext context, String label, VoidCallback onTap, Color color) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.width * 0.1,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
