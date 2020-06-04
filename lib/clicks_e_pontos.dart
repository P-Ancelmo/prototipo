import 'package:flutter/foundation.dart';

class Info with ChangeNotifier{

  int _click = 0;

  int get click => _click;

  void incrementClick(){
    _click++;
    notifyListeners();
  }

  void decrementClick(){
    _click--;
    notifyListeners();
  }

  void zeraClick(){
    _click = 0;
    notifyListeners();
  }
}

