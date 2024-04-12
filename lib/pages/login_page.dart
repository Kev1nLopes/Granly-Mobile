import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  String _username = '';
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(

            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: const Text(
                    'Um código de validação foi enviado para o seu email "email". Por favor, insira-o abaixo para acessar sua conta.',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                SizedBox(height: 30,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Container(
                      width: 50,
                      height: 80,
                      child: TextField(
                          maxLength: 1,
                          decoration: InputDecoration(
                              counterText: "",
                              hintText: "0",
                              hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                              )
                          )
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      width: 50,
                      height: 80,
                      child: TextField(
                          maxLength: 1,
                          decoration: InputDecoration(
                              counterText: "",
                              hintText: "0",
                              hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                              )
                          )
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      width: 50,
                      height: 80,
                      child: TextField(
                          maxLength: 1,
                          decoration: InputDecoration(
                              counterText: "",
                              hintText: "0",
                              hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                              )
                          )
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      width: 50,
                      height: 80,
                      child: TextField(
                          maxLength: 1,
                          decoration: InputDecoration(
                              counterText: "",
                              hintText: "0",
                              hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                              )
                          )
                      ),
                    ),
                    const SizedBox(width: 20),

                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/home');
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: Size(MediaQuery.of(context).size.width * 0.4, 40)
                    ),
                    child: const Text(
                      'Acessar',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
