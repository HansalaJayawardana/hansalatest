import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'No Guessing Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess the Number'),
      ),
      body: const Center(
        child: GuessNumberWidget(),
      ),
    );
  }
}

class GuessNumberWidget extends StatefulWidget {
  const GuessNumberWidget({super.key});

  @override
  _GuessNumberWidgetState createState() => _GuessNumberWidgetState();
}

class _GuessNumberWidgetState extends State<GuessNumberWidget> {
  final _formKey = GlobalKey<FormState>();
  final int _secretNumber = 7;
  int _guessesLeft = 3;
  final TextEditingController _controller = TextEditingController();

  void _handleGuess(int guess) {
    if (guess == _secretNumber) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CorrectGuessPage()),
      );
    } else {
      _guessesLeft--;
      if (_guessesLeft == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const GameOverPage()),
        );
      } else {
        setState(() {
          _controller.clear();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'I have a secret number in my mind (1 - 10). You have $_guessesLeft chances to guess it.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Form(
          key: _formKey,
          child: TextFormField(
            controller: _controller,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a number';
              }
              return null;
            },
            onFieldSubmitted: (value) {
              if (_formKey.currentState.validate()) {
                int guess = int.parse(value);
                _handleGuess(guess);
              }
            },
          ),
        ),
        const SizedBox(height: 20),
        RaisedButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              int guess = int.parse(_controller.text);
              _handleGuess(guess);
            }
          },
          child: const Text('Guess'),
        ),
      ],
    );
  }
}

class CorrectGuessPage extends StatelessWidget {
  const CorrectGuessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Correct Guess'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Congratulations! You\'ve guessed it correctly.',
              textAlign: TextAlign.center,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Text('Restart Game'),
            ),
          ],
        ),
      ),
    );
  }
}

class GameOverPage extends StatelessWidget {
  const GameOverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Over'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Game Over.',
              textAlign: TextAlign.center,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Text('Restart Game'),
            ),
          ],
        ),
      ),
    );
  }
}
