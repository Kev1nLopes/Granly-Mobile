import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wpp/controllers/user_controller.dart';
import 'package:dio/dio.dart';
import 'package:wpp/models/user.model.dart';
import 'package:wpp/utils/app.environment.dart';
import 'package:wpp/utils/dio.interceptor.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() {
    // TODO: implement createState
    return LoginPageState();
  }
}
class LoginPageState extends State<LoginPage> {

  bool isLoading = false;
  final dio = DioClient().dio;

  @override
  Widget build(BuildContext context) {
    TextEditingController _CodeController = TextEditingController();

    UserController UserContext = Provider.of<UserController>(context);
    String nome = UserContext.username.toUpperCase();
    String email = UserContext.email;



 
   

    handleSubmit() async {
      try{
        setState(() {
          isLoading = true;
        });
          if(_CodeController.text.length != 4){
            final snackBarCode = SnackBar(
              content: const Text('O código inválido'),
              backgroundColor: Colors.red[500],
              action: SnackBarAction(
                label: '',
                onPressed: () {
                  
                },
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBarCode);
            throw Error();
          }
          var baseUrl = Enviroment.baseUrl;
          var resposta = await dio.post(
          '$baseUrl/auth/verifyPin',
            data: jsonEncode({
              'email': email,
              'pin': _CodeController.text
            }),
            options: Options(contentType: 'application/json; charset=UTF-8')
          );


   
          AuthUser user = AuthUser.fromJson(resposta.data);
          UserContext.setUser(user);
          if(user.pinValid != null && user.pinValid == true){
            if(user.token != null){
              DioClient().UpdateInterceptor(user.token!);
            }
            Navigator.of(context).pushNamed('/home');
            UserContext.dispose();
            return;
          }
          final snackBar = SnackBar(
            content: const Text('Código inválido'),
            backgroundColor: Colors.red[500],
            action: SnackBarAction(
              label: '',
              onPressed: () {
                
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } on DioException catch(error){
        print(error.message);
        final snackBar = SnackBar(
            content: const Text('Código inválido'),
            backgroundColor: Colors.red[500],
            action: SnackBarAction(
              label: '',
              onPressed: () {
                
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }catch(e){
        print(e.toString());
        print("Deu ruim no envio do codigo ");

        final snackBar = SnackBar(
            content: const Text('Código inválido'),
            backgroundColor: Colors.red[500],
            action: SnackBarAction(
              label: '',
              onPressed: () {
                
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } finally {
        setState(() {
          isLoading = false;
        });
      }


    }

    return Scaffold( 
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    '$nome, O código de validação foi enviado para o email <$email>. Por favor, insira-o abaixo para acessar sua conta.',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _CodeController,
                    decoration:
                        InputDecoration(
                          icon: Icon(Icons.code),
                          border: OutlineInputBorder(),
                          labelText: 'Coloque o código aqui'),
                          
                  ),
                ),
                ElevatedButton(
                    onPressed: isLoading ? null : handleSubmit,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize:
                            Size(MediaQuery.of(context).size.width * 0.4, 40)),
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
