import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wpp/controllers/chat_controller.dart';
import 'package:wpp/controllers/user_controller.dart';
import 'package:wpp/models/message.model.dart';
import 'package:wpp/utils/app.environment.dart';
import 'package:wpp/utils/dio.interceptor.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() {
    // TODO: implement createState
    return ChatPageState();
  }
}

class ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  String inputMessage = "";

  List<Message> messages = [];

  Map<String, dynamic>? receiver;

  Dio dio = DioClient().dio;

  late UserController UserContext;
  late ChatController chatContext;

  fetchMessages(int id) async {
   
    try {
      print('------------------ ${id}');
      var response = await dio.get('${Enviroment.baseUrl}/messages/$id',
          options: Options(
              headers: {'Authorization': 'Bearer ${UserContext.user?.token}'}));

      if (response.statusCode == 200) {
        chatContext.resetMessages(receiver!['signatario']);
        response.data.forEach((key, value) {
          if (value is List) {
            print(value.length);
            value.forEach((element) {
              
             
              // ArrayMessages.add(Message.fromJson(element));
              Message message = Message.fromJson(element);
              
              if(receiver!['signatario'] != null){
                chatContext.NewSocketMessage(receiver!['signatario'], message);

              }
            });
          }
        });
        
      }
      // Atualize a lista de mensagens aqui, se necessário
    } on DioException catch (e) {
      print(e.message);
    }
  }

  @override
  void initState() {
    super.initState();
    print("Entrou na chat page");

  }

  void newMessage(String message) async {
    print(message);

    try {
      print(receiver);
      var response = await dio.post<Map<String, dynamic>>(
          '${Enviroment.baseUrl}/messages',
          data: {'receiver_id': chatContext.currentChat, 'message': message},
          options: Options(
              headers: {'Authorization': 'Bearer ${UserContext.user?.token}'}));

      if (response.data != null) {
        var data = response.data!['data'];
        var message = Message.fromJson(data);
        chatContext.NewSocketMessage(receiver!['signatario'], message);
      } else {
        print('Response data is null');
      }
    } on DioException catch (e) {
      print(e.response?.data);
    }

    
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    chatContext = context.watch<ChatController>();
    UserContext = context.watch<UserController>();

    
    receiver = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    // fetchMessages(chatContext.currentChat); 
      
      
    
    
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 80,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Text(
                            receiver!['signatario'] ?? ' ',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      Align(
                        child: IconButton(
                          icon: Icon(Icons.more_vert),
                          onPressed: () {},
                        ),
                      )
                    ]),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: chatContext.messages[receiver!['signatario']]!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final msg =  chatContext.messages[receiver!['signatario']]![index];
                    return MessageArea(
                      mensagem: msg,
                      userId: UserContext.user!.user!.id!,
                      isLastMessage: index == chatContext.messages[receiver!['signatario']]!.length - 1,
                    );
                  },
                ),
              ),
              TextFieldArea(context),
            ],
          ),
        ),
      ),
    );
  }

  Padding TextFieldArea(BuildContext context) {
    TextEditingController messageController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              controller: messageController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          Container(
            width: 60.0, // largura do círculo
            height: 60.0, // altura do círculo
            decoration: const BoxDecoration(
              color: Colors.blue, // cor do círculo
              shape: BoxShape.circle, // forma do contêiner como círculo
            ),
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white),
              onPressed: () {
                newMessage(messageController.text);
                messageController.clear();
                // sua ação aqui
              },
            ),
          )
        ],
      ),
    );
  }
}

class MessageArea extends StatelessWidget {
  final Message mensagem;
  final int userId;
  final bool isLastMessage;

  MessageArea({
    super.key,
    required Message this.mensagem,
    required int this.userId,
    required bool this.isLastMessage,
  });

  @override
  Widget build(BuildContext context) {

    print(userId);
    print(isLastMessage);
    print(mensagem.message!);

    // TODO: implement build
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        Align(
          alignment: userId == mensagem.author!.id!
              ? Alignment.topLeft
              : Alignment.topRight,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.48,
            margin: EdgeInsets.only(bottom: isLastMessage ? 10 : 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: (userId != null) && userId == mensagem.author!.id!
                    ? Colors.blue
                    : Colors.lightGreen,
                child: Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      mensagem.message!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
