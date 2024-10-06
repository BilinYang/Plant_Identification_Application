import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:dart_random_choice/dart_random_choice.dart';

var name = "";
TextEditingController _controller = TextEditingController();
var _guessed_letter;
var secretWord='';
String _error = '';
var lettersGuessed = [];
var letters_not_guessed = '';
int _numwords = 0;
int _secretlen = 0;
//var _guessed_letter;
int _num_guesses_left = 8;
var _availalt = '';
var _guessedWord = '';
bool _start = false;
bool _fiavis = false;
var _info = '';

//
// void main() {
//   runApp(const MyApp());
// }

class Hangman extends StatelessWidget {
  const Hangman({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: MaterialStateProperty.all(Size(30, 20)),
            padding: MaterialStateProperty.all(EdgeInsets.zero),


            //foregroundColor: MaterialStateProperty.all(Colors.white),
            foregroundColor: MaterialStateProperty.resolveWith(
                  (states) {
                if (states.contains(MaterialState.focused) &&
                    !states.contains(MaterialState.pressed)) {
                  return Colors.blue;
                } else if (states.contains(MaterialState.pressed)) {
                  return Colors.deepPurple;
                }

                return Colors.white;
              },
            ),
            //backgroundColor: MaterialStateProperty.all(Colors.green),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.blue;
              } else if (states.contains(MaterialState.disabled)) {
                return Colors.grey;
              }
              return Colors.blue;
            }),
            overlayColor: MaterialStateProperty.all(Colors.red),
            fixedSize: MaterialStateProperty.all(Size(10, 10)),
            elevation: MaterialStateProperty.all(1),
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)

                )
            )
        ),


        ),
      ),
      home: const MyHomePage(title: 'Hangman Game'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<bool> _isButtonDisabled = List<bool>.filled(26,false,growable:false);


  var complete_alphabet_string = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';

  var separation_line = '------------------------------------------';
  late List<String> wordlist;

  @override
  void initState() {
    super.initState();
    loadWords();
    _num_guesses_left = 8;
    _start = false;
    for (int i=0; i<26; i++){
      _isButtonDisabled[i] = false;
    }

    setState(() {
      //_loading = true;
    });
    //loadModel().then((value) {
    //setState(() {});
    //});
  }

  void _presskey(int index) {
    setState(() {
      _isButtonDisabled[index] = true;
    });
    hangman(secretWord);
    setState(() {
    });
  }

  Future<String> getFileData(String path) async {
    return await rootBundle.loadString(path);
  }
  void loadWords() async {
    var path = 'assets/words_for_hangman.txt';
    // new File(path)
    //     .openRead()
    //     .transform(utf8.decoder)
    //     .transform(new LineSplitter())
    //     .forEach((l) => print('line: $l'));
    String data = await getFileData(path);
    wordlist = data.split(" ");

    setState(() {
      _numwords = wordlist.length;
    });
  }

  String chooseWord(List<String> wordlist){

    return randomChoice<String>(wordlist);

  }

  String getAvailableLetters(List lettersGuessed) {
    var alphabet_string = 'abcdefghijklmnopqrstuvwxyz';
    letters_not_guessed = '';
    for (int i=0; i<26; i++) {
      if ( !lettersGuessed.contains(alphabet_string[i])){
        letters_not_guessed=letters_not_guessed+alphabet_string[i];
      }
    }
    print(lettersGuessed);
    return letters_not_guessed;
  }

  String getGuessedWord(String secretWord, List lettersGuessed) {
    var returnedstring = '';
    for (int i = 0; i < secretWord.length; i++) {
      if (!lettersGuessed.contains(secretWord[i])) {
        returnedstring += '_ ';
      }
      else {
        returnedstring += secretWord[i];
      }
    }
    return returnedstring;
  }

  bool isWordGuessed(String secretWord, List lettersGuessed) {
    for (int i = 0; i < secretWord.length; i++) {
      if (!lettersGuessed.contains(secretWord[i])) {
        return false;
      }
    }
    return true;
  }


  void hangman(String secretWord) {

    print("here");
    print("$secretWord");
    print(_guessed_letter.length);

    if (_guessed_letter.length > 1) {
      _error = 'Your input consists of more than one character: ' +
          getGuessedWord(secretWord, lettersGuessed);
      print(getGuessedWord(secretWord, lettersGuessed));

    }
    else if (!complete_alphabet_string.contains(_guessed_letter)) {
      _error = 'Your input is not a letter';
      _guessedWord = getGuessedWord(secretWord, lettersGuessed);
    }
    else if (lettersGuessed.contains(_guessed_letter.toLowerCase())) {
      _error = "Oops! You've already guessed that letter";
      _guessedWord = getGuessedWord(secretWord, lettersGuessed);
    }
    else {
      _guessed_letter = _guessed_letter.toLowerCase();
      for (int i=26; i < 52;i++) {
        if (complete_alphabet_string[i]==_guessed_letter) {
          _isButtonDisabled[i-26] = true;
          print(_isButtonDisabled[i-26]);
        }
      }


      lettersGuessed.add(_guessed_letter);
      if (secretWord.contains(_guessed_letter)) {
        _error = 'Good guess ';
        _guessedWord = getGuessedWord(secretWord, lettersGuessed);

        _availalt = getAvailableLetters(lettersGuessed);
      }
      else {
        _error = 'Oops! That letter is not in my word ';
        _guessedWord = getGuessedWord(secretWord, lettersGuessed);
        _availalt = getAvailableLetters(lettersGuessed);
        _num_guesses_left -= 1;
        print(_num_guesses_left);
      }


      if (isWordGuessed(secretWord, lettersGuessed)==true) {
        _info = 'Congratulations, you won!';
        _fiavis = true;
      }
      if (_num_guesses_left == 0) {
        _info = 'Sorry, you ran out of guesses. ' + 'The word was ' + secretWord;
        _fiavis = true;
      }

      //break)
    }
    //setState(() {});
  }


  void _gamestart() {
    secretWord=chooseWord(wordlist);
    print(secretWord);
    _secretlen=secretWord.length;
    _guessed_letter = '';
    _error = '';
    lettersGuessed = [];
    _num_guesses_left = 8;
    _start = true;
    _availalt = getAvailableLetters(lettersGuessed);
    _fiavis = false;
    _guessedWord = getGuessedWord(secretWord, lettersGuessed);
    for (int i=0; i<26; i++){
      _isButtonDisabled[i] = false;
    }
    //hangman(secretWord);
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Container(
        //alignment: Alignment.topLeft,
        //color: Colors.yellow,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,

          children: <Widget>[
            Container(
              //color: Colors.red,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10, top: 5),
              //width: 54,
              //height: 34,
              child: const Text(
                'Loaded word list from file...',
                style: TextStyle(fontSize: 15),
              ),
            ), //图片
            // SizedBox(
            //   height: 30,
            // ),
            Container(
              //color: Colors.blue,
              alignment: Alignment.centerLeft,

              margin: EdgeInsets.only(left: 10, top: 2),
              //width: 34,
              //height: 34,
              child: Text(
                '$_numwords  words loaded.',
                style: TextStyle(fontSize: 15),

              ),
            ),

            SizedBox(
              height: 5,
            ),
            Container(height: 1, color: Colors.grey,),

            Container(
              // color: Colors.blue,
              alignment: Alignment.center,

              margin: EdgeInsets.only(left: 10, top: 10),
              //width: 34,
              //height: 34,
              child: Text(
                'Welcome to the game Hangman!',
                style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),

              ),
            ),
            SizedBox(
              height: 12,
            ),

            Visibility(
              visible: _start
                  ? true
                  : false,
              child: Container(
                child: Text(
                  'I am thinking of a word that is $_secretlen letters long',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Visibility(
              visible: _start
                  ? true
                  : false,
              child: Container(
                child: Text(
                  'You have $_num_guesses_left guesses left',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            Visibility(
              visible: _start
                  ? true
                  : false,
              child: Container(
                child: Text(
                  separation_line,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),

            Visibility(
              visible: _start
                  ? true
                  : false,
              child: Container(
                child: Text(
                  'Available letters:   $_availalt',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            Visibility(
              visible: _start
                  ? true
                  : false,
              child: Container(
                child: Text(
                  'Guess Word:   $_guessedWord',
                  style: TextStyle(fontSize: 25,
                      color: Colors.green),
                ),
              ),
            ),

            // Visibility(
            //   visible: _start
            //       ? true
            //       : false,
            //   child: Container(
            //     child: Text(
            //       separation_line,
            //       style: TextStyle(fontSize: 15),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),

            Visibility(
              visible: _start & (!_fiavis)
                  ? true
                  : false,
              child: Container(
                  margin: EdgeInsets.only(left: 50, right: 50, top: 10),
                  child:
                  Column(
                    children: [
                      Text("you input $_guessed_letter"),
                      Center(
                        child: TextField(
                          controller: _controller,
                          cursorWidth: 1,
                          cursorHeight: 24,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 12),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            labelText: 'Please guess a letter: ',
                            helperText: "Pass",
                            errorText: _error,
                            prefixIcon: Icon(Icons.key),
                          ),
                          // onSubmitted: (String value) async {
                          //   await showDialog<void>(
                          //     context: context,
                          //     builder: (BuildContext context) {
                          //     return AlertDialog(
                          //       title: const Text('Thanks!'),
                          //       content: Text(
                          //         'You typed "$value", which has length ${value.characters}'),
                          //       actions: [
                          //           TextButton(
                          //           onPressed: () {
                          //             Navigator.pop(context);
                          //           },
                          //           child: const Text('OK'),
                          //       ),
                          //     ],
                          //     );
                          //   },
                          // );
                          //   },
                          onSubmitted: (String value) {
                            setState(() {
                              _guessed_letter = value;
                              // print("$_guessed_letter change");
                              _controller.clear();
                            });
                            if (_guessed_letter.length==1){
                              for (int i=26; i < 52;i++) {
                                if (complete_alphabet_string[i] ==
                                    _guessed_letter) {
                                  _isButtonDisabled[i - 26] = true;
                                  print(_isButtonDisabled[i - 26]);
                                }
                              }
                            }
                            _MyHomePageState().hangman(secretWord);
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  )

              ),
            ),

            Visibility(
              visible: _fiavis
                  ? true
                  : false,
              child: Container(
                child: Text(
                  _info,

                  style: TextStyle(fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.red
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Visibility(
                  visible: _start & (!_fiavis)
                      ? true
                      : false,
                  child: Container(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabled[0] ? null : () {
                          setState(() {
                            _guessed_letter = 'a';
                            _presskey(0);
                          });
                        },
                        child: const Text("A"),
                      )
                  ),
                ),
                Visibility(
                  visible: _start & (!_fiavis)
                      ? true
                      : false,
                  child: Container(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabled[1] ? null : () {
                          setState(() {
                            _guessed_letter = 'b';
                            _presskey(1);
                          });
                        },
                        child: const Text("B"),
                      )
                  ),
                ),
                Visibility(
                  visible: _start & (!_fiavis)
                      ? true
                      : false,
                  child: Container(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabled[2] ? null : () {
                          setState(() {
                            _guessed_letter = 'c';
                            _presskey(2);
                          });
                        },
                        child: const Text("C"),
                      )
                  ),
                ),
                Visibility(
                  visible: _start & (!_fiavis)
                      ? true
                      : false,
                  child: Container(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabled[3] ? null : () {
                          setState(() {
                            _guessed_letter = 'd';
                            _presskey(3);
                          });
                        },
                        child: const Text("D"),
                      )
                  ),
                ),
                Visibility(
                  visible: _start & (!_fiavis)
                      ? true
                      : false,
                  child: Container(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabled[4] ? null : () {
                          setState(() {
                            _guessed_letter = 'e';
                            _presskey(4);
                          });
                        },
                        child: const Text("E"),
                      )
                  ),
                ),
                Visibility(
                  visible: _start & (!_fiavis)
                      ? true
                      : false,
                  child: Container(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabled[5] ? null : () {
                          setState(() {
                            _guessed_letter = 'f';
                            _presskey(5);
                          });
                        },
                        child: const Text("F"),
                      )
                  ),
                ),
                Visibility(
                  visible: _start & (!_fiavis)
                      ? true
                      : false,
                  child: Container(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabled[6] ? null : () {
                          setState(() {
                            _guessed_letter = 'g';
                            _presskey(6);
                          });
                        },
                        child: const Text("G"),
                      )
                  ),
                ),
                Visibility(
                  visible: _start & (!_fiavis)
                      ? true
                      : false,
                  child: Container(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabled[7] ? null : () {
                          setState(() {
                            _guessed_letter = 'h';
                            _presskey(7);
                          });
                        },
                        child: const Text("H"),
                      )
                  ),
                ),
                Visibility(
                  visible: _start & (!_fiavis)
                      ? true
                      : false,
                  child: Container(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabled[8] ? null : () {
                          setState(() {
                            _guessed_letter = 'i';
                            _presskey(8);
                          });
                        },
                        child: const Text("I"),
                      )
                  ),
                ),
                Visibility(
                  visible: _start & (!_fiavis)
                      ? true
                      : false,
                  child: Container(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabled[9] ? null : () {
                          setState(() {
                            _guessed_letter = 'j';
                            _presskey(9);
                          });
                        },
                        child: const Text("J"),
                      )
                  ),
                ),
              ],

            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Visibility(
                  visible: _start & (!_fiavis)
                      ? true
                      : false,
                  child: Container(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabled[10] ? null : () {
                          setState(() {
                            _guessed_letter = 'k';
                            _presskey(10);
                          });
                        },
                        child: const Text("K"),
                      )
                  ),
                ),
                Visibility(
                  visible: _start & (!_fiavis)
                      ? true
                      : false,
                  child: Container(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabled[11] ? null : () {
                          setState(() {
                            _guessed_letter = 'l';
                            _presskey(11);
                          });
                        },
                        child: const Text("L"),
                      )
                  ),
                ),
                Visibility(
                  visible: _start & (!_fiavis)
                      ? true
                      : false,
                  child: Container(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabled[12] ? null : () {
                          setState(() {
                            _guessed_letter = 'm';
                            _presskey(12);
                          });
                        },
                        child: const Text("M"),
                      )
                  ),
                ),
                Visibility(
                  visible: _start & (!_fiavis)
                      ? true
                      : false,
                  child: Container(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabled[13] ? null : () {
                          setState(() {
                            _guessed_letter = 'n';
                            _presskey(13);
                          });
                        },
                        child: const Text("N"),
                      )
                  ),
                ),
                Visibility(
                  visible: _start & (!_fiavis)
                      ? true
                      : false,
                  child: Container(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabled[14] ? null : () {
                          setState(() {
                            _guessed_letter = 'o';
                            _presskey(14);
                          });
                        },
                        child: const Text("O"),
                      )
                  ),
                ),
                Visibility(
                  visible: _start & (!_fiavis)
                      ? true
                      : false,
                  child: Container(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabled[15] ? null : () {
                          setState(() {
                            _guessed_letter = 'p';
                            _presskey(15);
                          });
                        },
                        child: const Text("P"),
                      )
                  ),
                ),
                Visibility(
                  visible: _start & (!_fiavis)
                      ? true
                      : false,
                  child: Container(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabled[16] ? null : () {
                          setState(() {
                            _guessed_letter = 'q';
                            _presskey(16);
                          });
                        },
                        child: const Text("Q"),
                      )
                  ),
                ),
                Visibility(
                  visible: _start & (!_fiavis)
                      ? true
                      : false,
                  child: Container(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabled[17] ? null : () {
                          setState(() {
                            _guessed_letter = 'r';
                            _presskey(17);
                          });
                        },
                        child: const Text("R"),
                      )
                  ),
                ),
                Visibility(
                  visible: _start & (!_fiavis)
                      ? true
                      : false,
                  child: Container(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabled[18] ? null : () {
                          setState(() {
                            _guessed_letter = 's';
                            _presskey(18);
                          });
                        },
                        child: const Text("S"),
                      )
                  ),
                ),
                Visibility(
                  visible: _start & (!_fiavis)
                      ? true
                      : false,
                  child: Container(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabled[19] ? null : () {
                          setState(() {
                            _guessed_letter = 't';
                            _presskey(19);
                          });
                        },
                        child: const Text("T"),
                      )
                  ),
                ),
              ],

            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 30,
                ),
                Container(
                  width: 30,
                ),
                Visibility(
                  visible: _start & (!_fiavis)
                      ? true
                      : false,
                  child: Container(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabled[20] ? null : () {
                          setState(() {
                            _guessed_letter = 'u';
                            _presskey(20);
                          });
                        },
                        child: const Text("U"),
                      )
                  ),
                ),
                Visibility(
                  visible: _start & (!_fiavis)
                      ? true
                      : false,
                  child: Container(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabled[21] ? null : () {
                          setState(() {
                            _guessed_letter = 'v';
                            _presskey(21);
                          });
                        },
                        child: const Text("V"),
                      )
                  ),
                ),
                Visibility(
                  visible: _start & (!_fiavis)
                      ? true
                      : false,
                  child: Container(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabled[22] ? null : () {
                          setState(() {
                            _guessed_letter = 'w';
                            _presskey(22);
                          });
                        },
                        child: const Text("W"),
                      )
                  ),
                ),
                Visibility(
                  visible: _start & (!_fiavis)
                      ? true
                      : false,
                  child: Container(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabled[23] ? null : () {
                          setState(() {
                            _guessed_letter = 'x';
                            _presskey(23);
                          });
                        },
                        child: const Text("X"),
                      )
                  ),
                ),
                Visibility(
                  visible: _start & (!_fiavis)
                      ? true
                      : false,
                  child: Container(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabled[24] ? null : () {
                          setState(() {
                            _guessed_letter = 'y';
                            _presskey(24);
                          });
                        },
                        child: const Text("Y"),
                      )
                  ),
                ),
                Visibility(
                  visible: _start & (!_fiavis)
                      ? true
                      : false,
                  child: Container(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabled[25] ? null : () {
                          setState(() {
                            _guessed_letter = 'z';
                            _presskey(25);
                          });
                        },
                        child: const Text("Z"),
                      )
                  ),
                ),
                Container(
                  width: 30,
                ),
                Container(
                  width: 30,
                ),
              ],

            ),



            // const Text(
            //   'Loading word list from file...',
            // ),
            // Text(
            //   '$_numwords  words loaded.',
            //   //style: Theme.of(context).textTheme.headlineMedium,
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _gamestart();
        },
        tooltip: 'Start Game!',
        //shape: ShapeBorder.,
        child: Image(image: AssetImage('images/startbutton.png')),
        //child: const Icon(Icons.add),

      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


//Function _buttonPress() {
//if (_isButtonDisabled) {
//return null;
// } else {
//return () {
// do anything else you may want to here
//_incrementCounter();
//};
// }
//}

// class ExTextField extends StatefulWidget {
//   const ExTextField({super.key});
//
//   @override
//   State<ExTextField> createState() => _ExTextFieldState();
// }
//
// class _ExTextFieldState extends State<ExTextField> {
//   var _ierror;
//   // _getErrorText() {
//   //   return _error;
//   // }
//
//   @override
//   void initState() {
//     super.initState();
//     //_controller = TextEditingController();
//     _controller.text = "";
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   Widget build(BuildContext context) {
//     return
//       Column(
//         children: [
//           Text("you input $_guessed_letter"),
//         Center(
//           child: TextField(
//             controller: _controller,
//             cursorWidth: 1,
//             cursorHeight: 24,
//             decoration:  InputDecoration(
//               contentPadding: EdgeInsets.only(bottom: 12),
//               border: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.red),
//               ),
//               labelText: 'Please guess a letter: ',
//               helperText: "Pass",
//               errorText: _ierror,
//               prefixIcon: Icon(Icons.key),
//             ),
//             // onSubmitted: (String value) async {
//             //   await showDialog<void>(
//             //     context: context,
//             //     builder: (BuildContext context) {
//             //     return AlertDialog(
//             //       title: const Text('Thanks!'),
//             //       content: Text(
//             //         'You typed "$value", which has length ${value.characters}'),
//             //       actions: [
//             //           TextButton(
//             //           onPressed: () {
//             //             Navigator.pop(context);
//             //           },
//             //           child: const Text('OK'),
//             //       ),
//             //     ],
//             //     );
//             //   },
//             // );
//             //   },
//             onSubmitted: (String value) {
//               setState(() {
//                 _guessed_letter = value;
//                 print("$_guessed_letter change");
//                 //_controller.clear();
//
//               });
//               _MyHomePageState().hangman(secretWord);
//               setState(() {
//                 _ierror = _error;
//
//               });
//
//           },
//         ),
//       ),
//       ],
//       );
//   }
// }
