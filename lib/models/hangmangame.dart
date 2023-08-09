import 'package:http/http.dart' as http;

class HangmanGame {
  String _word;
  String _correctGuesses = "";
  String _wrongGuesses = "";
  int _score =0;

  //Constructor starts off with blank strings that we will concatenate during the course of play
  //Defines the initial state of an object
  HangmanGame(String word) {
    _word = word;
    _correctGuesses = "";
    _wrongGuesses = "";
    _score =0;
  }

  get length => null;

  String correctGuesses() {
    return _correctGuesses;
  }

  String wrongGuesses() {
    return _wrongGuesses;
  }

  String word() {
    return _word;
  }

  bool guess(String letter) {
    // TODO: Fill this in
    RegExp test = new RegExp(r'[a-zA-Z]');
    
    //If the user guesses a null guess
    if (letter == null || letter == "" || !test.hasMatch(letter)) 
    {
      throw ArgumentError();
    }
    //If the user guesses a string with with more than one letter
    if (letter.length > 1 || letter == "" || !test.hasMatch(letter)) 
    {
      throw ArgumentError();
    }


    letter = letter.toLowerCase();

    if (_word.contains(letter)) {
      //return false if input is not part of the alphabet
      if (_correctGuesses.contains(letter))
       {
        return false;
       }
      //This means the letter is correct
      _correctGuesses += letter;
      for(int i = 0; i < _word.length; ++i)
      {
        if(_word[i] == letter)
        {
          _score += 8;
         }
      }
      return true;
    
    } else {
      //same as the other one, it checks if it's part of the alphabet
      if (_wrongGuesses.contains (letter)) 
      {
        _score = _score -8;
        return false;
      }
      //This means the letter is not in word
      _wrongGuesses += letter;
      return true;
    }
    
  }

  String blanksWithCorrectGuesses() {
    // TODO: Fill this in
    String tmp = "";
    for (int a = 0; a < _word.length; a++) {
      if (_correctGuesses.contains(_word[a])) 
      {
        tmp += _word[a];
      } else 
        {
         tmp += "-";
        }
    }
    return tmp;
  }
 

  String status() {
    // TODO: Fill this in
    String status = blanksWithCorrectGuesses();
    if (_wrongGuesses.length >= 7) {
      return "lose";
    } else if (status == _word) 
      {
         return "win";
      } else 
        {
          return "play";
        }

  }


  //when running integration tests always return "banana"
  static Future<String> getStartingWord(bool areWeInIntegrationTest) async {
    String word;
    Uri endpoint = Uri.parse("http://randomword.saasbook.info/RandomWord");
    if (areWeInIntegrationTest) {
      word = "banana";
    } else {
      try {
        var response = await http.post(endpoint);
        word = response.body;
      } catch (e) {
        word = "error";
      }
    }

    return word;
  }

  int score(){
      _score = 3 * _score;
      if (_score < 2) {
        _score = 0;
      }
      return _score;
    }
}
