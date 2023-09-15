import 'package:flutter/material.dart';
import 'package:many_games/home_page.dart';

class TakePlayerNames extends StatelessWidget {
  final TextEditingController player1Controller = TextEditingController();
  final TextEditingController player2Controller = TextEditingController();

  TakePlayerNames({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              const Text(
                'ENTER PLAYERS NAME',
                style: TextStyle(
                    color: Color.fromARGB(255, 7, 8, 46),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 40,
              ),
              createPlayerRow(context,
                  controller: player1Controller,
                  icon: Icons.circle,
                  iconColor: Colors.blue,
                  hintext: 'Player1'),
              const SizedBox(
                height: 20,
              ),
              createPlayerRow(context,
                  controller: player2Controller,
                  icon: Icons.circle,
                  iconColor: Colors.red,
                  hintext: 'Player2'),
              const SizedBox(
                height: 100,
              ),
              GestureDetector(
                onTap: () async {
                  HomePage.player1Name = player1Controller.text.isNotEmpty
                      ? player1Controller.text.toString()
                      : 'PLAYER 1';

                  HomePage.player2Name = player2Controller.text.isNotEmpty
                      ? player2Controller.text.toString()
                      : 'PLAYER 2';

                  
                    Navigator.pushNamed(context, '/tic_tac_toe');
                  // } else if (HomePage.choice == 2) {
                  //   Navigator.pushNamed(context, '/three_stones');
                  // }
                },
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 74, 20, 60),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'START',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 74, 20, 60),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'BACK',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row createPlayerRow(BuildContext context,
      {required TextEditingController controller,
      required IconData icon,
      required Color iconColor,
      required String hintext}) {
    return Row(
      children: [
        const SizedBox(
          width: 70,
        ),
        Icon(
          icon,
          color: iconColor,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          margin: const EdgeInsets.only(
            left: 20,
          ),
          color: const Color.fromARGB(255, 230, 224, 224),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintext,
              hintStyle: const TextStyle(color: Colors.white),
              fillColor: Colors.black,
              filled: true, // No next field
            ),
          ),
        ),
      ],
    );
  }
}
