


import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key); // Correção no construtor

  @override
  State<MessagePage> createState() {
    return MessagePageState();
  }
}



class MessagePageState extends State<MessagePage>{
  var users = ['Kevin', 'Breno', 'Teste', 'Ana', 'Paula', 'Marina', 'Carla', 'Julia', 'Bianca', 'Beatriz', 'Carla', 'Julia', 'Bianca', 'Beatriz'];


   Future<void> fetchApi() async {
     final url = Uri.https('https://meowfacts.herokuapp.com/');
      var response = await http.get(url);
      print(response.body);

   }




  @override
  Widget build(BuildContext context){



    return Scaffold(
      appBar: AppBar(
        title: const Text("Granlys Chat"),
         actions: <Widget>[
          IconButton(onPressed: () => {

          }, icon: const Icon(Icons.search)),
          IconButton(onPressed: () => {}, icon: const Icon(Icons.more_vert_rounded))
        ],
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index){
        return Messages(receiver: users[index]);
      })

    );
  }

}


class Messages extends StatelessWidget {
  final String receiver;

  const Messages({
    super.key,
    required this.receiver
  });

 

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/chat", arguments: receiver);
      },
      child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Colors.grey.shade400
                ),
              )
              
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
                    Text(receiver.toString(), style: const TextStyle(color:  Colors.blue),),
                    const Text('Um mensagem motivacional'),
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('10 min ago'),
                    const SizedBox(height: 5),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue
                      ),
                      child: const Center(child: Text('3', style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),),
                    ),
                  
                  ],
                )
      
              ],),
            ),
          ),
    );
  }
}