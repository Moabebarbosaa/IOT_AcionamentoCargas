import 'package:acionamento_cargas_mobile_2/screens/model/firebase.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class FloatActionButton extends StatefulWidget {
  FloatActionButton({this.speech, this.connection, this.favBox});

  final SpeechToText speech;
  final bool connection;
  var favBox;

  @override
  _FloatActionButtonState createState() => _FloatActionButtonState(
      speech: speech, connection: connection, favBox: favBox);
}

class _FloatActionButtonState extends State<FloatActionButton> {
  _FloatActionButtonState({this.speech, this.connection, this.favBox});

  Firebase firebase = new Firebase();

  final SpeechToText speech;
  final bool connection;
  var favBox;

  bool _isListening = false;
  String _text = 'Press the button and start speaking';

  void _listen() async {
    if (!_isListening) {
      bool available = await speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_text != null) {
      _text = _text.toLowerCase();
    }
    print("CONEXAO:  $connection");

    if (_text == "ligar tomada") {
      firebase.setState(true, "Tomada", connection, favBox);
      _text = null;
    } else if (_text == "desligar tomada") {
      firebase.setState(false, "Tomada", connection, favBox);
      _text = null;
    } else if (_text == "ligar lâmpada") {
      firebase.setState(true, "Lâmpada", connection, favBox);
      _text = null;
    } else if (_text == "desligar lâmpada") {
      firebase.setState(false, "Lâmpada", connection, favBox);
      _text = null;
    }
    return AvatarGlow(
      animate: _isListening,
      glowColor: Color(0xffF5DF4D),
      endRadius: 75.0,
      duration: const Duration(milliseconds: 2000),
      repeatPauseDuration: const Duration(milliseconds: 100),
      repeat: true,
      child: FloatingActionButton(
        onPressed: _listen,
        child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        backgroundColor: Color(0xff2D2D2D),
      ),
    );
  }
}
