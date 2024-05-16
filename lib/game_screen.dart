import 'package:flutter/material.dart';

class GameScreenPage extends StatefulWidget {
  @override
  State<GameScreenPage> createState() => _GameScreenPageState();
}

class _GameScreenPageState extends State<GameScreenPage> {
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  bool first_turn = true;
  var winnerDeclaration = '';
  int Oscore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  bool winnerFound = true;
  int gameOver = 3;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Player O",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            Oscore.toString(),
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Text(
                            "Player X",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            xScore.toString(),
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        onTapped(index);
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: Text(
                            displayXO[index],
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    gameOver==0?Text(winnerDeclaration+" the game",style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),):Text(
                      winnerDeclaration,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius:BorderRadius.circular(15),
                        ),
                        child: TextButton(
                            onPressed: () {
                              return clearButtons();
                            },
                            child: Text(
                              "New Game",
                              style:
                              TextStyle(fontSize: 25, color: Colors.white),
                            )))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void winner() {
    //for rows
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      setState(() {
        winnerDeclaration = "Player " + displayXO[0] + " Wins";
        updateScore(displayXO[0]);
        winnerFoundEmptyAfterWin(displayXO);
      });
    }
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      setState(() {
        winnerDeclaration = "Player " + displayXO[3] + " Wins";
        updateScore(displayXO[3]);
        winnerFoundEmptyAfterWin(displayXO);
      });
    }
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      setState(() {
        winnerDeclaration = "Player " + displayXO[6] + " Wins";
        updateScore(displayXO[6]);
        winnerFoundEmptyAfterWin(displayXO);
      });
    }
    //for columns
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      setState(() {
        winnerDeclaration = "Player " + displayXO[0] + " Wins";
        updateScore(displayXO[0]);
        winnerFoundEmptyAfterWin(displayXO);
      });
    }
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      setState(() {
        winnerDeclaration = "Player " + displayXO[1] + " Wins";
        updateScore(displayXO[1]);
        winnerFoundEmptyAfterWin(displayXO);
      });
    }
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      setState(() {
        winnerDeclaration = "Player " + displayXO[2] + " Wins";
        updateScore(displayXO[2]);
        winnerFoundEmptyAfterWin(displayXO);
      });
    }
    //for diagonals
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      setState(() {
        winnerDeclaration = "Player " + displayXO[0] + " Wins";
        updateScore(displayXO[0]);
        winnerFoundEmptyAfterWin(displayXO);
      });
    }
    if (displayXO[2] == displayXO[4] &&
        displayXO[2] == displayXO[6] &&
        displayXO[2] != '') {
      setState(() {
        winnerDeclaration = "Player " + displayXO[2] + " Wins";
        updateScore(displayXO[2]);
        winnerFoundEmptyAfterWin(displayXO);
      });
    }
    if(!winnerFound || filledBoxes==9){
      setState(() {
        winnerDeclaration = "Tied";
        winnerFoundEmptyAfterWin(displayXO);
      });
    }
    // clearButtons();
  }

  void onTapped(int index) {
    setState(() {
      if (first_turn && displayXO[index] == '') {
        displayXO[index] = "O";
      } else if (!first_turn && displayXO[index] == '') {
        displayXO[index] = "X";
      }
      first_turn = !first_turn;
      filledBoxes++;
      winner();
    });
  }

  void updateScore(String win) {
    if (win == "O") {
      Oscore++;
    }
    if (win == "X") {
      xScore++;
    }
  }

  void clearButtons() {

    setState(() {
      for(int i=0;i<9;i++){
        displayXO[i]='';
      }
      winnerDeclaration = '';
      Oscore=0;
      xScore=0;
    });
    filledBoxes=0;
  }

  void winnerFoundEmptyAfterWin(List arr){
    print(gameOver);
    for(int i=0;i<arr.length;i++){
      displayXO[i]="";
    }
    filledBoxes=0;
    gameOver--;
  }

}
