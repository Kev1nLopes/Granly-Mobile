





import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmailPage extends StatelessWidget{
  String _email = '';

  @override
  Widget build(BuildContext context){

    handleNome(String valor){
        _email = valor;
    }

    handleSubmit(){
      print(_email);
    }

    return Scaffold(
      body:  Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text('Bem vindo ao Granly', style: TextStyle(fontSize: 32),),
                  SizedBox(height: 10),
                  Center(
                    child:  Text('Informe seu e-mail para acessar o sistema', style: TextStyle(fontSize: 18),),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    onChanged: handleNome,
                    decoration: InputDecoration(
                      hintText: 'Informe seu e-mail',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 8.0
                        )
                      ),

                      labelText: "Email"
                    ),
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(onPressed: () => {
                    Navigator.of(context).pushReplacementNamed('/login')
                  }, child: Text('Entrar', style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    minimumSize: Size(MediaQuery.of(context).size.width / 1.8, 50),
                    backgroundColor: Colors.blue
                  ),)
                ],
              ),
          ),
        ),
      ),
    );

  }

}

