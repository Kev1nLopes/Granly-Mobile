import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:dio/dio.dart';
import 'package:wpp/controllers/chat_controller.dart';
import 'package:wpp/controllers/user_controller.dart';
import 'package:wpp/models/find.model.dart';
import 'package:wpp/models/friend.model.dart';
import 'package:wpp/models/message.model.dart';
import 'package:wpp/models/request.model.dart';
import 'package:wpp/models/user.model.dart';
import 'package:wpp/utils/app.environment.dart';
import 'package:wpp/utils/dio.interceptor.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() {
    return MessagePageState();
  }
}

class MessagePageState extends State<MessagePage> {
  int _count = 0;
  late IO.Socket socket;
  late UserController userContext;
  late ChatController chatContext;
  late Dio dio;
  int _currentIndex = 0;
  List<Friend> friendList = [];
 
  List<Find> findList = [];

  // Icon(Icons.home),
  // Icon(Icons.contacts),
  // Icon(Icons.account_box_rounded),

  @override
  void initState() {
    super.initState();
    dio = DioClient().dio;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      userContext = Provider.of<UserController>(context, listen: false);
      chatContext = Provider.of<ChatController>(context, listen: false);
      fetchMessages();

      socket = IO.io(
        'wss://67473pxl-3000.brs.devtunnels.ms',
        <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': false,
        },
      );

      socket.connect();
      socket.onConnect((_) {
        print('connect');
        socket.emit('login', {'username': userContext.user?.user?.username});
      });

      socket.on('messageNotify', (data) {
        print('nova mensagem $data');
        Message message = Message.fromJson(data);

        chatContext.NewSocketMessage(message.author!.username!, message);
      });
    });
  }

  fetchPage(int newPageIndex) async {
    setState(() {
      _currentIndex = newPageIndex;
    });

    if (newPageIndex == 0) {
      fetchMessages();
    } else if (newPageIndex == 1) {
      fetchFriends();
      fetchFind();
    }
  }

  fetchFriends() async {
    try {
      var baseUrl = Enviroment.baseUrl;
      var response = await dio.get<List<dynamic>>(
        '$baseUrl/contacts/friends',
        options: Options(
          contentType: 'application/json; charset=UTF-8',
          headers: {'Authorization': 'Bearer ${userContext.user?.token}'},
        ),
      );
      // print(response.statusCode);
      List<Friend> friends = [];
      // print("Kevin Lindo");
      // print(response.data);
      response.data?.forEach((element) {
        print(element);
        Friend friend = Friend.fromJson(element);
        print(friend.username!);
        friends.add(friend);
      });

      setState(() {
        friendList = friends;
      });
    } on DioException catch (e) {
      print('Deu muito ruim');
      print(e);
    } catch (e) {
      print('Erro ao buscar contatos');
      print(e);
    }
  }



  fetchFind() async {
    try {
      var baseUrl = Enviroment.baseUrl;
      var response = await dio.get<List<dynamic>>(
        '$baseUrl/contacts/friends',
        options: Options(
          contentType: 'application/json; charset=UTF-8',
          headers: {'Authorization': 'Bearer ${userContext.user?.token}'},
        ),
      );
      // print(response.statusCode);
      List<Find> finds = [];
      // print("Kevin Lindo");
      // print(response.data);
      response.data?.forEach((element) {
        print(element);
        Find find = Find.fromJson(element);
        print(find.username!);
        finds.add(find);
      });

      setState(() {
        findList = finds;
      });
    } on DioException catch (e) {
      print('Deu muito ruim');
      print(e);
    } catch (e) {
      print('Erro ao buscar contatos');
      print(e);
    }
  }

  fetchMessages() async {
    try {
      if (chatContext.messages.keys.length > 0) {
        chatContext.resetAllMessages();
      }
      print("Teste kevin");
      var baseUrl = Enviroment.baseUrl;
      var response = await dio.get<Map<String, dynamic>>(
        '$baseUrl/messages',
        options: Options(
          contentType: 'application/json; charset=UTF-8',
          headers: {'Authorization': 'Bearer ${userContext.user?.token}'},
        ),
      );

      if (response.statusCode == 200) {
        response.data?.forEach((key, value) {
          if (value is List) {
            value.forEach((element) {
              print("Percorrendo valores");
              Message message = Message.fromMap(element);

              chatContext.NewSocketMessage(key, message);
            });
          }
        });
      }

      print('LastMessage ${chatContext.messages.keys.toString()}');
    } on DioException catch (e) {
      print(e.response?.data);
      final snackBar = SnackBar(
        content: Text(e.response?.data!.toString() ?? 'Erro desconhecido'),
        backgroundColor: Colors.red[500],
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      final snackBar = SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red[500],
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    userContext = context.watch<UserController>();
    chatContext = context.watch<ChatController>();

    List<Widget> body = [ListChats(), ListFriends(), Profile()];

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Granlys Chat"),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                setState(() {
                  print("Reload bolado");
                  if (_currentIndex == 0) fetchMessages();
                  if (_currentIndex == 1) fetchFriends();
                });
              },
              icon: const Icon(Icons.refresh_rounded),
            ),
            IconButton(
                onPressed: () => {
                      showModalBottomSheet(context: context, builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Column(
                            children: [
                              Container(
                                child: GestureDetector(child: Text("Descobrir"), onTap: (){
                                  Navigator.of(context).pushNamed('/find');
                                },),
                                width: MediaQuery.of(context).size.width * 0.8,

                              ),
                              Container(
                                child: GestureDetector(child: Text("Aprovar"), onTap: (){
                                  Navigator.of(context).pushNamed('/request');
                                },),
                                width: MediaQuery.of(context).size.width * 0.8,

                              )

                              
                            ]
                          )
                        );
                      })
                    },
                icon: const Icon(Icons.add)),
          ],
        ),
        body:  body[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int newIndex) {
            fetchPage(newIndex);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contacts),
              label: 'Contatos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box_rounded),
              label: 'Perfil',
            ),
          ],
        ));
  }

  Consumer<ChatController> ListChats() {
    return Consumer<ChatController>(
      builder: (context, chat, child) {
        return ListView.builder(
          itemCount: chat.messages.keys.length,
          itemBuilder: (BuildContext context, int index) {
            var key = chat.messages.keys.elementAt(index);
            var message = chat.messages[key]![chat.messages[key]!.length - 1];
            return Messages(context, message, key);
          },
        );
      },
    );
  }

  Container NewFriends() {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey.shade400,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                        );
                      });
                },
                child: Icon(Icons.group_add_rounded)),
          ),
          VerticalDivider(),
          Expanded(
            child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 20,
                                child: Text(
                                  "Encontrar amigos",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(),
                            ],
                          ),
                        );
                      });
                },
                child: Icon(Icons.find_replace_rounded)),
          ),
        ],
      ),
    );
  }

  InkWell Messages(BuildContext context, Message message, String signatario) {
    var author = message.author?.username == signatario
        ? message.author?.id
        : message.signatario?.id;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/chat",
            arguments: {'signatario': signatario});
        chatContext.setCurrentChat(author!);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.grey.shade400,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 50,
                height: 50,
                child: CircleAvatar(
                  radius: 75,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(signatario, style: const TextStyle(color: Colors.blue)),
                  Text(message.message!),
                ],
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(''),
                  const SizedBox(height: 5),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: message.read == true
                        ? Center(
                            child: Text(
                              '${message.readAt}',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Consumer<ChatController> ListFriends() {
    return Consumer<ChatController>(
      builder: (context, chat, child) {
        return ListView.builder(
          itemCount: friendList.length,
          itemBuilder: (BuildContext context, int index) {
            var friend = friendList[index];
            return FriendCard(friend, context);
          },
        );
      },
    );
  }

  InkWell FriendCard(Friend friend, BuildContext context) {
    return InkWell(
      onTap: () {
        print(friend.username.toString());
        Navigator.pushNamed(context, "/chat",
            arguments: {'signatario': friend.username.toString()});
        print(friend.id.toString());
        chatContext.NewChat(friend.username!);
        chatContext.setCurrentChat(friend.id!);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.grey.shade400,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 50,
                height: 50,
                child: CircleAvatar(
                  radius: 75,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(friend.username!,
                      style: const TextStyle(color: Colors.blue)),
                  Text('Amigos desde ${friend.createdAt!}'),
                ],
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(''),
                  const SizedBox(height: 5),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container Profile() {
    TextEditingController username =
        TextEditingController(text: userContext.user!.user!.username);
    TextEditingController email =
        TextEditingController(text: userContext.user!.user!.email);
    bool isLoading = false;

    void updateUser() async {
      setState(() {
        isLoading = true;
      });

      try {
        var baseUrl = Enviroment.baseUrl;
        var response = await dio.put('$baseUrl/user',
            data: {
              'username': username.text,
              'email': email.text,
              'native_language': 'pt-BR',
            },
            options: Options(headers: {
              Headers.contentTypeHeader: "application/json; charset=UTF-8",
              'Authorization': 'Bearer ${userContext.user!.token}'
            }));

        print(response.data);
        // AuthUser user = AuthUser.fromJson(response.data);

        // userContext.setUser(user);
        final snackBarCode = SnackBar(
          content: Text('Dados Alterados com sucesso'),
          backgroundColor: Colors.blue[500],
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBarCode);
      } on DioException catch (e) {
        print(e.response!.data);
        final snackBarCode = SnackBar(
          content: Text(e.response!.data),
          backgroundColor: Colors.red[500],
          action: SnackBarAction(
            label: 'Tentar novamente',
            onPressed: () {
              // Ação quando o botão do SnackBar é pressionado
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBarCode);
      } catch (e) {
        print(e);
        final snackBarCode = SnackBar(
          content: Text('Não foi possível alterar os dados'),
          backgroundColor: Colors.red[500],
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBarCode);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.15,
              child: Center(
                  child: Text(
                userContext.user!.user!.username![0],
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              )),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue, width: 2),
              ),
            ),

            TextField(
              controller: username,
              decoration: const InputDecoration(
                  labelText: 'Username', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: email,
              decoration: const InputDecoration(
                  labelText: 'E-mail', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: isLoading ? null : () => updateUser(),
              child: Text(
                'Salvar',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  minimumSize:
                      Size(MediaQuery.of(context).size.width / 1.8, 50),
                  backgroundColor: Colors.blue),
            )
            // Text(userContext.user!.user!.username!),
            // Text(userContext.user!.user!.email!),
          ],
        ),
      ),
    );
  }
}
