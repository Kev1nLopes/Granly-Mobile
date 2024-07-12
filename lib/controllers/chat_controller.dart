



import 'package:flutter/material.dart';
import 'package:wpp/models/message.model.dart';

class ChatController extends ChangeNotifier {
  Map<String, List<Message>> _AppMessages = {};
  int _currentChat = 0;

  Map<String, List<Message>> get messages => _AppMessages;
  int get currentChat => _currentChat;


  void NewSocketMessage(String author, Message message){

    if(_AppMessages.containsKey(author)){
      _AppMessages[author]!.add(message);
      print('Nova mensagem inserida 1');
      
      
    }else{
      _AppMessages[author] = [message];
      print('Nova mensagem inserida 2');
    }
   
    notifyListeners();

  }

  void NewChat(String author){
    if(_AppMessages.containsKey(author)){
      print('Ja existe chat aberto com ese author');
    }else{
      _AppMessages[author] = [];

    }
    notifyListeners();
  }

  

  void setCurrentChat(int chat){
    _currentChat = chat;
    notifyListeners();
  }

  void resetMessages(String author){

    _AppMessages[author] = [];
    notifyListeners();
  }

   void resetAllMessages(){

    _AppMessages.clear();
    notifyListeners();
  }
}