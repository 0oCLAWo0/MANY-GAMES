import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class XyloPhone extends StatelessWidget {
  String note = 'note1.wav';
  final assetsAudioPlayer = AssetsAudioPlayer();

  Widget createButton(String symbol, Color color, String note) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          
          assetsAudioPlayer.open(
            Audio("assets/audios/$note"),
          );
        },
        child: Container(
          width: double.infinity,
          color: color,
          child: Center(
            child: Text(
              symbol,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            createButton(
              'Sa',
              Colors.red,
              'note1.wav',
            ),
            createButton(
              'Re',
              Colors.orange,
              'note2.wav',
            ),
            createButton(
              'Ga',
              Colors.yellow,
              'note3.wav',
            ),
            createButton(
              'Ma',
              Colors.green,
              'note4.wav',
            ),
            createButton(
              'Pa',
              Colors.blue,
              'note5.wav',
            ),
            createButton(
              'Dha',
              Colors.indigo,
              'note6.wav',
            ),
            createButton(
              'Ni',
              Colors.purple,
              'note7.wav',
            ),
          ],
        ),
      ),
    );
  }
}
