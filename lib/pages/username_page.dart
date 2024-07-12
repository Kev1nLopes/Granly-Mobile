





import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wpp/controllers/user_controller.dart';
import 'package:wpp/models/signUp.model.dart';
import 'package:wpp/utils/app.environment.dart';
import 'package:wpp/utils/dio.interceptor.dart';

class UsernamePage extends StatefulWidget{

  @override
  UserNamePageState createState() => UserNamePageState();
}


class UserNamePageState extends State<UsernamePage>{

  Dio dio = DioClient().dio;

  @override
  Widget build(BuildContext context){

    TextEditingController _nomeController = TextEditingController();
    UserController UserContext = Provider.of<UserController>(context);

    handleSubmit() async{
      try{
        var baseUrl = Enviroment.baseUrl;
        var resposta = await dio.post(
          '$baseUrl/auth/signUp',
          data: {
            'username': _nomeController.text,
            'email': UserContext.email
          }
        );

        if(resposta.statusCode == 200){
          SignUp response = SignUp.fromJson(resposta.data);
          if(response.hasAccount == true){
            UserContext.setUsername(response.username.toString());
            Navigator.of(context).pushNamed('/login');
          }
        }
        print(resposta.statusCode);
        print(resposta.data);
      } on DioException catch(e){
        print("Kevin lindo");
        print(e.response?.data);
         final snackBarCode = SnackBar(
            content: Text(e.response?.data.toString() ?? 'Erro desconhecido'),
            backgroundColor: Colors.red[500],
            action: SnackBarAction(
              label: 'Tentar novamente',
              onPressed: () {
                // Ação quando o botão do SnackBar é pressionado
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBarCode);
        print(e.response?.data);
      }catch(e){
        print(e);
      }


    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Text(
              'Bem vindo ao granly, para que tenha uma boa experiência insira seu nome de usuário',
              style: TextStyle(fontSize: 18),
             ),
            SizedBox(height: 10),
             TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder()
              ),
              controller: _nomeController,
             ),
             SizedBox(height: 10),
              ElevatedButton(
                    onPressed: handleSubmit,
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
    );
  }


}