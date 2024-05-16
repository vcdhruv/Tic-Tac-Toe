import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class GameScreenPage extends StatefulWidget {
  String p1, p2;

  GameScreenPage({required this.p1, required this.p2, super.key});

  @override
  State<GameScreenPage> createState() => _GameScreenPageState();
}

class _GameScreenPageState extends State<GameScreenPage> {
  late List<List<String>> _board;
  late String _currentPlayer;
  late String _winner;
  late bool _gameOver;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _board = List.generate(3, (index) => List.generate(3, (index) => ""));
    _currentPlayer = "X";
    _winner = "";
    _gameOver = false;
  }

  //reset
  void _resetGame() {
    setState(() {
      _board = List.generate(3, (index) => List.generate(3, (index) => ""));
      _currentPlayer = "X";
      _winner = "";
      _gameOver = false;
    });
  }

  void _makeMove(int row, int col) {
    if (_board[row][col] != "" || _gameOver) {
      return;
    }

    // winner check
    setState(
      () {
        _board[row][col] = _currentPlayer;
        if (_board[row][0] == _currentPlayer &&
            _board[row][1] == _currentPlayer &&
            _board[row][2] == _currentPlayer) {
          _winner = _currentPlayer;
          _gameOver = true;
        } else if (_board[0][col] == _currentPlayer &&
            _board[1][col] == _currentPlayer &&
            _board[2][col] == _currentPlayer) {
          _winner = _currentPlayer;
          _gameOver = true;
        } else if (_board[0][0] == _currentPlayer &&
            _board[1][1] == _currentPlayer &&
            _board[2][2] == _currentPlayer) {
          _winner = _currentPlayer;
          _gameOver = true;
        } else if (_board[0][2] == _currentPlayer &&
            _board[1][1] == _currentPlayer &&
            _board[2][0] == _currentPlayer) {
          _winner = _currentPlayer;
          _gameOver = true;
        }

        //switch players
        _currentPlayer = _currentPlayer == "X" ? "0" : "X";

        //tie check
        if (!_board.any((row) => row.any((cell) => cell == ""))) {
          _gameOver = true;
          _winner = "It's a Tie";
        }

        if (_winner != "") {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            btnOkText: "Play Again",
            title: _winner == "X"
                ? widget.p1 + "Won!"
                : _winner == "O"
                    ? widget.p2 + "Won!"
                    : "It's A Tie",
            btnOkOnPress: () {
              _resetGame();
            },
          )..show();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF323D5B),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            SizedBox(
              height: 120,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Turn : ",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        _currentPlayer == "X"
                            ? widget.p1 + "($_currentPlayer)"
                            : widget.p2 + "($_currentPlayer)",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: _currentPlayer == "X"
                                ? Colors.white
                                : Colors.red),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFF5F6B84),
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(5),
              child: GridView.builder(
                itemCount: 9,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  int row = index ~/ 3;
                  int col = index % 3;
                  return GestureDetector(
                    onTap: () => _makeMove(row, col),
                    child: Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Color(0xFF0E1E3A),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          _board[row][col],
                          style: TextStyle(
                              fontSize: 120,
                              fontWeight: FontWeight.bold,
                              color: _board[row][col] == "X"
                                  ? Colors.white
                                  : Colors.red),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
