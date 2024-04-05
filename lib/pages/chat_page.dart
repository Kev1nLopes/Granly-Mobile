import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Mensagem{
  final int authorId;
  final String message;


  Mensagem({required this.authorId, required this.message});
}


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

  List<Mensagem> messages = [
    Mensagem(authorId: 1, message: 'Bom dia'),
    Mensagem(authorId: 2, message: 'Bom dia'),
    Mensagem(authorId: 1, message: 'Ta bem ?'),
    Mensagem(authorId: 2, message: 'To sim!'),
    Mensagem(authorId: 2, message: 'E você ?'),
    Mensagem(authorId: 1, message: 'To bem'),
    Mensagem(authorId: 1, message: 'Vamos fazer algo hoje ?'),
    Mensagem(authorId: 2, message: 'Hoje eu não posso.'),
    Mensagem(authorId: 2, message: 'Amanhã eu to livre'),
    Mensagem(authorId: 1, message: 'Amanhã eu nã possoo :( '),
    Mensagem(authorId: 1, message: 'Ta díficil'),
    Mensagem(authorId: 1, message: 'Olha '),
    Mensagem(authorId: 1, message: 'Precisamos falar sobre o grêmio '),
    Mensagem(authorId: 1, message: 'Time ta uma merda'),
    Mensagem(authorId: 1, message: 'JP galvão não faz nada '),
    Mensagem(authorId: 1, message: 'Meu vô jogaria melhor '),
    Mensagem(authorId: 1, message: 'é foda '),
    Mensagem(authorId: 1, message: 'Sempre o grêmio '),
    Mensagem(authorId: 2, message: 'Time fudido'),
    Mensagem(authorId: 2, message: 'Mas tem pior'),
    Mensagem(authorId: 2, message: 'Não da pra reclamar')

  ];

  void newMessage() {
    setState(() {
      messages.add(Mensagem(authorId: 2, message: _controller.text));
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final String? receiver = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(receiver ?? ' '),
          actions: <Widget>[
            IconButton(onPressed: () => {}, icon: const Icon(Icons.search)),
            IconButton(onPressed: () => {}, icon: const Icon(Icons.more_vert_rounded))
          ],
          backgroundColor: Colors.grey[50],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height - 160,
          width: MediaQuery.of(context).size.width,
          color: Colors.green[50],
          child:  ListView(
            children: messages.map((msg) =>
                Message(mensagem: msg, sizeFont: 12, AuthUserId: 1,)).toList(),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Digite aqui...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: newMessage,
                 child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue
                  ),
                  child: IconButton(icon: const Icon(Icons.send), onPressed: newMessage, style: ButtonStyle(iconColor: MaterialStateProperty.all<Color>(Colors.white)),)), 
                )
              ],
            ),
          ),
        ));
  }
}

class Message extends StatelessWidget {
  final Mensagem mensagem;
  final int AuthUserId;
  final double sizeFont;
  final Key? key;
  const Message({Key? this.key, required this.mensagem, required this.sizeFont, required this.AuthUserId});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        Align(
          alignment: AuthUserId == mensagem.authorId ? Alignment.topLeft : Alignment.topRight,
          child: Container(
          width: MediaQuery.of(context).size.width * 0.48,
          child:  ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: AuthUserId == mensagem.authorId ? Colors.blue : Colors.lightGreen,
                child: Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      mensagem.message.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: sizeFont),
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
