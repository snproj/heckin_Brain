import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Heckin(),
));

String currentLetter = "A";

String encodedText = "";

String toBeDecoded = "";

int letterIndex = 0;

void switchLetter (String _currentLetter, int upOrDown) {
  
  //int letterIndex = keyString.indexOf("$_currentLetter");

  if (upOrDown == 1) {
    letterIndex += 1;
    encodedText += "p";
    try{
      currentLetter = keyString[letterIndex];
      //currentLetter = keyString[letterIndex + 1];
    } catch(RangeError) {
      letterIndex = 0;
      currentLetter = keyString[letterIndex];
    }
  } else {
    letterIndex -= 1;
    encodedText += "m";
    try{
      currentLetter = keyString[letterIndex];
      //currentLetter = keyString[letterIndex - 1];
    } catch(RangeError) {
      letterIndex = keyString.length - 1;
      currentLetter = keyString[letterIndex];
    }
  }

  keyStringFirstHalf = keyString.substring(0, letterIndex);
  keyStringSecondHalf = keyString.substring(letterIndex + 1, keyString.length);
  print("currentLetter: " + currentLetter);
}

/*
void switchLetter(String currentletter, int upOrDown) {
  if (upOrDown == 1) {
    currentLetter = "BBBB";
  }
}
*/

String displayLetter = "";

void putLetter (String _currentLetter) {
  encodedText += "o";
  displayLetter += _currentLetter;
  print("displayLetter: " + displayLetter);
}

String keyString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

String keyStringFirstHalf = keyString.substring(0, letterIndex);
String keyStringSecondHalf = keyString.substring(letterIndex + 1, keyString.length);

void deleteLetter() {
  try {
    displayLetter = displayLetter.substring(0, displayLetter.length - 1);
  } catch(e) {
    // Do nothing
  }

  try{
    int lastO = encodedText.lastIndexOf("o");
    encodedText = encodedText.substring(0, lastO);
    int secondLastO = encodedText.lastIndexOf("o");
    encodedText = encodedText.substring(0, secondLastO + 1);
    currentLetter = displayLetter[displayLetter.length - 1];
  } catch(e) {
    encodedText = "";
    currentLetter = keyString[0];
  }

  letterIndex = keyString.indexOf(currentLetter);
  keyStringFirstHalf = keyString.substring(0, letterIndex);
  keyStringSecondHalf = keyString.substring(letterIndex + 1, keyString.length);
}

decodeString(String _toBeDecoded) {

  currentLetter = keyString[0];

  for(int i = 0; i < _toBeDecoded.length; i++) {
    if(_toBeDecoded[i] == "p") {
      switchLetter(currentLetter, 1);
    } else if (_toBeDecoded[i] == "m") {
      switchLetter(currentLetter, 0);
    } else if (_toBeDecoded[i] == "o") {
      putLetter(currentLetter);
    } else {
      // Do nothing
    }
  }
}

class Heckin extends StatefulWidget {
  @override
  _HeckinState createState() => _HeckinState();
}

class _HeckinState extends State<Heckin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Center(
                  child: Text(
            "HeckinBrain TyperMachine",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            )
          ),
        )
      ),
      body: Column(
        children: <Widget>[

          //SizedBox(height: 30.0),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Container(
                    child: SelectableText(
                      "$displayLetter",
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Text(
                    "$keyStringFirstHalf",
                    style: TextStyle(
                      color: Colors.white,
                    )
                  )
                )
              ),

              Container(
                child: Text(
                  "$currentLetter",
                  style: TextStyle(
                    fontSize: 40.0, 
                    color: Colors.white, 
                  ),
                ),
              ),

              Expanded(
                child: Center(
                  child: Text(
                    "$keyStringSecondHalf",
                    style: TextStyle(
                      color: Colors.white,
                    )
                  )
                )
              ),
            ],
          ),

          //SizedBox(height: 30.0),
          /* separate currentLetter and keyString
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  "$currentLetter",
                  style: TextStyle(
                    fontSize: 40.0, 
                    color: Colors.white, 
                  ),
                ),
              ),
            ],
          ),

          //SizedBox(height: 30.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: SelectableText(
                    "$keyString",
                    style: TextStyle(
                      color: Colors.white,
                    )
                  )
                )
              )
            ],
          ),

          */

          Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  child: Text(
                    "DECREMENT",
                  ),
                  onPressed: (){
                    setState(() {
                      switchLetter(currentLetter, 0);
                    });
                  },
                  color: Colors.red,
                )
              ),

              Expanded(
                child: RaisedButton(
                  child: Text(
                    "INCREMENT",
                  ),
                  onPressed: (){
                    setState(() {
                      switchLetter(currentLetter, 1);
                    });
                  },
                  color: Colors.green,
                )
              )
            ],
          ),

          SizedBox(height: 30.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text(
                  "PRINT",
                ),
                onPressed: () {
                  setState(() {
                    putLetter(currentLetter);
                  });
                },
              )
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text(
                  "DELETE",
                ),
                onPressed: () {
                  setState(() {
                    deleteLetter();
                  });
                },
              )
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text(
                  "CLEAR",
                ),
                onPressed: () {
                  setState(() {
                    displayLetter = "";
                    currentLetter = keyString[0];
                    encodedText = "";
                    letterIndex = 0;
                    keyStringFirstHalf = keyString.substring(0, letterIndex);
                    keyStringSecondHalf = keyString.substring(letterIndex + 1, keyString.length);
                  });
                },
              )
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: SelectableText(
                    "$encodedText",
                    style: TextStyle(
                      color: Colors.white,
                    )
                  )
                )
              )
            ],
          ),

          SizedBox(height: 10.0),

          Row( // newKeyString
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Container(
                    //  color: Colors.white,
                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Enter New Keystring.",
                        fillColor: Colors.grey,
                        filled: true,
                      ),
                      onChanged: (newKeyString) {
                        setState(() {
                          keyString = newKeyString;
                          currentLetter = keyString[0];
                        });
                      },
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      )
                    ),
                  )
                )
              )
            ],
          ),

          Row( // toBeDecoded
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Container(
                    //color: Colors.white,
                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Enter Text To Be Decoded.",
                        fillColor: Colors.grey,
                        filled: true,
                      ),
                      onChanged: (newToBeDecoded) {
                        toBeDecoded = newToBeDecoded;
                      },
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      )
                    ),
                  )
                )
              )
            ],
          ),

          SizedBox(height: 10.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text(
                  "DECODE",
                ),
                onPressed: () {
                  setState(() {
                    print(toBeDecoded);
                    decodeString(toBeDecoded);
                  });
                },
              )
            ],
          ),
        ],
      )
    );
  }
}