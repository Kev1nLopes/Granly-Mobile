import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

  List<String> messages = [
    'Você é mais forte do que pensa e mais capaz do que imagina. Confie na sua força. Bom dia!',
    'Se as coisas na sua vida parecem um pouco lentas, talvez seja a vida te dizendo que você está indo rápido demais. Respire fundo, tenha paciência e saiba que tudo tem o seu tempo. Bom dia!',
    'Você é mais forte do que pensa e mais capaz do que imagina. Confie na sua força. Bom dia!',
    'Bom dia! As melhores coisas ainda estão por vir! Tenha fé!',
    'Que o seu dia seja marcado por novas conquistas e objetivos concluídos! Uma excelente manhã para todos!',
    'Que a jornada de hoje venha acompanhada de muitas vitórias.',
    'Bom dia! Peça para receber, busque para encontrar, sonhe para conquistar.',
    'Acreditar em si mesmo é um ato de amor-próprio. Um dia cheio de conquistas é o que desejo para você hoje.',
    'Foco, força e coragem para que hoje seja um dia marcado por metas concluídas. Bom dia!',
    'Tenha fé em Deus e amor no coração para cumprir todos os objetivos de hoje! Um bom dia!',
  ];

  void newMessage() {
    setState(() {
      messages.add(_controller.text);
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
          height: MediaQuery.of(context).size.height - 200,
          width: MediaQuery.of(context).size.width,
          color: Colors.green[50],
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                  children: messages
                      .map((message) => Message(message: message, fontSize: 12))
                      .toList()),
            ),
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
  final String message;
  final double fontSize;
  final Key? key;
  const Message({Key? this.key, required this.message, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Colors.blue,
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    message.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
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
