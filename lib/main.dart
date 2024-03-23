import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const HomePage()
    );
  }
}

class HomePage extends StatefulWidget{
  const HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();


}



class _HomePageState extends State<HomePage>{
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Granly chat'),
        actions: <Widget>[
          IconButton(onPressed: () => {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () => {}, icon: Icon(Icons.more_vert_rounded))
        ],
        
      
      ),
      body: Messages(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.call_to_action_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.date_range_outlined), label: ''),

        
      ],
      currentIndex: _pageIndex,
      onTap: _selectPage,
      ),
    );
  }


  void _selectPage(int index){
    setState(() {
      _pageIndex = index;
    });
    
  }


}

class Messages extends StatelessWidget {
  const Messages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  SingleChildScrollView(child: Column(children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.1,
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
              
              Container(
                width: 50,
                height: 50,
                child: CircleAvatar(
                  radius: 75,
                  backgroundImage: NetworkImage('https://static.wikia.nocookie.net/killer-bean/images/9/9b/KBF_Killer_Bean.png/revision/latest/scale-to-width-down/350?cb=20221008001433'),
                ),
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Kevin lopes', style: TextStyle(color:  Colors.blue),),
                  Text('Um mensagem motivacional'),
                  
                ],
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('10 min ago'),
                  SizedBox(height: 5),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue
                    ),
                    child: Center(child: Text('3', style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),),
                  )

                ],
              )

            ],),
          ),
        ),
      ],),)
    );
  }
}

