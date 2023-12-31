import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:many_games/home_page.dart';
import 'package:many_games/reusable.dart';
import 'package:quickalert/quickalert.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  List<List<Icon?>> board = List.generate(3, (_) => List.filled(3, null));
  int scoreKeeperP1 = 0;
  int scoreKeeperP2 = 0;
  int rounds = 1;
  bool isPlayer1Turn = true;
  bool isPlayer1Winner = false;
  bool isPlayer2Winner = false;
  int turnCount = 0;
  Color? winningColor;
  Timer? confettiStopTimer;
  final controller = ConfettiController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Scaffold(
          backgroundColor: Colors.amberAccent,
          body: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20, left: 30),
                child: Text(
                  'ROUNDS :  $rounds',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromARGB(255, 78, 74, 74)),
                ),
              ),
              Reusable.createPlayers('${HomePage.player1Name}:  $scoreKeeperP1',
                  Icons.circle_outlined, Colors.blue),
              const SizedBox(
                height: 20,
              ),
              Reusable.createPlayers('${HomePage.player2Name}:  $scoreKeeperP2',
                  Icons.close, Colors.red),
              const SizedBox(
                height: 60,
              ),
              createRow(0),
              createRow(1),
              createRow(2),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Reusable.buildButtons(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    label: 'BACK',
                    symbol: Icons.arrow_back,
                  ),
                  Reusable.buildButtons(
                    onTap: playAgainLogic,
                    label: 'PLAY AGAIN',
                    symbol: Icons.change_circle,
                  ),
                ],
              ),
            ],
          ),
        ),
        ConfettiWidget(
          confettiController: controller,
          shouldLoop: true,
          blastDirectionality: BlastDirectionality.explosive,
          numberOfParticles: 32,
        ),
      ],
    );
  }

  Widget createRow(int row) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        createBox(row, 0),
        createBox(row, 1),
        createBox(row, 2),
      ],
    );
  }

  Widget createBox(int row, int col) {
    double sz = MediaQuery.of(context).size.width * 0.3;
    Icon? object = board[row][col];

    return GestureDetector(
      onTap: () {
        if (object == null && !isPlayer1Winner && !isPlayer2Winner) {
          setState(() {
            final assetsAudioPlayer = AssetsAudioPlayer();
            assetsAudioPlayer.open(
              Audio("assets/audios/tap.mp3"),
            );
            turnCount++;
            board[row][col] = isPlayer1Turn
                ? const Icon(
                    Icons.circle_outlined,
                    color: Colors.blue,
                    size: 40,
                  )
                : const Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 40,
                  );
            checkWinner(row, col);
            isPlayer1Turn = !isPlayer1Turn;
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: sz,
        height: sz,
        color: const Color.fromARGB(255, 163, 188, 48),
        margin: const EdgeInsets.all(5),
        child: object,
      ),
    );
  }

  void checkWinner(int row, int col) {
    // Check rows, columns, and diagonals for a winner.
    if (checkRow(row) ||
        checkColumn(col) ||
        checkDiagonal() ||
        checkAntiDiagonal()) {
      setState(() {
        final assetsAudioPlayer = AssetsAudioPlayer();
        assetsAudioPlayer.open(
          Audio("assets/audios/winner.mp3"),
        );
        controller.play();
        // Start a timer to stop the confetti after 5 seconds
        confettiStopTimer = Timer(const Duration(seconds: 5), () {
          controller.stop();
        });
      });
      if (isPlayer1Turn) {
        setState(() {
          isPlayer1Winner = true;
          scoreKeeperP1++;
          winningColor = Colors.white;
          showWinnerPopUp(1);
        });
      } else {
        setState(() {
          isPlayer2Winner = true;
          scoreKeeperP2++;
          winningColor = Colors.white;
          showWinnerPopUp(2);
        });
      }
    } else if (turnCount == 9) {
      showWinnerPopUp(0);
    }
  }

  bool checkRow(int row) {
    return board[row][0] == board[row][1] && board[row][1] == board[row][2];
  }

  bool checkColumn(int col) {
    return board[0][col] == board[1][col] && board[1][col] == board[2][col];
  }

  bool checkDiagonal() {
    if (board[1][1] != null) {
      return board[0][0] == board[1][1] && board[1][1] == board[2][2];
    }

    return false;
  }

  bool checkAntiDiagonal() {
    if (board[1][1] != null) {
      return board[0][2] == board[1][1] && board[1][1] == board[2][0];
    }
    return false;
  }

  void showWinnerPopUp(int result) {
    QuickAlert.show(
      widget: Center(
        child: Text(
         result == 0
              ? 'IT\'S A TIE'
              : result == 1
                  ? 'CONGRATULATIONS ${HomePage.player1Name}'
                  : 'CONGRATULATIONS ${HomePage.player2Name}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 67, 8, 78),
                  ),
        ),
      ),
      barrierDismissible: true,
      onConfirmBtnTap: () {
        playAgainLogic();
        Navigator.pop(context);
      },
      context: context,
      type: QuickAlertType.custom,
      confirmBtnText: 'PLAY AGAIN',
      confirmBtnColor: const Color.fromARGB(255, 2, 10, 51),
    );
  }

  void playAgainLogic() {
    setState(() {
      controller.stop();
      ++rounds;
      board = List.generate(3, (_) => List.filled(3, null));
      isPlayer1Turn = true;
      isPlayer1Winner = false;
      isPlayer2Winner = false;
      turnCount = 0;
    });
  }
}
