import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:wpp/controllers/user_controller.dart';
import 'package:wpp/models/album.model.dart';
import 'package:wpp/models/user.model.dart';
import 'package:wpp/models/welcome.model.dart';
import 'package:wpp/utils/app.environment.dart';
import 'package:wpp/utils/dio.interceptor.dart';



class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => EmailPageState();
}


class EmailPageState extends State<EmailPage> {
  String _email = '';
  bool isLoading = false;
  late UserController UserContext;

  final dio = DioClient().dio;

  verifyToken(String token) async{
    setState(() {
      isLoading = true;
    });
    try{
      UserContext.setLocaleToken('');
      var baseUrl = Enviroment.baseUrl;
      var response = await dio.post('$baseUrl/auth/verifyToken', data: {'token': token});
      if(response.statusCode == 200){
        AuthUser user = AuthUser.fromJson(response.data);
        UserContext.setUser(user);
        print(user.user!.username!);
        UserContext.dispose();
        Navigator.of(context).pushNamed('/home');  
      }
      print(response.data);
    } on  DioException catch(e){
        print(e.response!.data!);
        print(e.response!.statusCode!);
    } catch(e){
      print(e);
      UserContext.setLocaleToken('');
      print('Não foi possível validar token');
    }finally{
      
      setState(() {
        isLoading = false;
      });
    }

  }


  @override
  void initState() {
    super.initState();

    
  }


  @override
  Widget build(BuildContext context) {
    handleNome(String valor) {
      _email = valor;
    }

    handleSubmit() {
      print(_email);
    }

    // UserContext = context.watch<UserController>();
    UserContext = Provider.of<UserController>(context, listen: true);
    print(UserContext.locale['token']);
    if(UserContext.locale['token'] != ''){
      print(UserContext.locale['token']);
      verifyToken(UserContext.locale['token']!);
    }

    Future<Map<String, dynamic>?> fetchAlbum() async {
      try {
        setState(() {
          isLoading = true;
        });
        print(_email);
        var baseUrl = Enviroment.baseUrl;
        final response = await dio.post(
          '$baseUrl/auth/signIn',
          data: jsonEncode(<String, String>{
            'email': _email.toLowerCase(),
          }), 
          options: Options(
            headers: {
              Headers.contentTypeHeader: "application/json; charset=UTF-8"
            }
          )
          
          
          
        );
        print(response.data);

        if (response.statusCode == 200) {
         
          Welcome resposta = Welcome.fromJson(response.data);
          
          UserContext.setEmail(_email.toLowerCase());
          if(resposta?.hasAccount == true){
            UserContext.setUsername(resposta.username.toString());
            print(UserContext.username);
            Navigator.of(context).pushNamed('/login');

          }else{
            Navigator.of(context).pushNamed('/username');
          }
        } else {
          throw Exception('Não deu bom');
        }
      } on DioException catch (e) {
          print(e.response?.statusCode);
      } catch (e) {
        print('Alguma exception no login $e');
        return null;
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }


    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bem vindo ao Granly',
                  style: TextStyle(fontSize: 32),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'Informe seu e-mail para acessar o sistema',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  onChanged: handleNome,
                  decoration: InputDecoration(
                      hintText: 'Informe seu e-mail',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              BorderSide(color: Colors.red, width: 8.0)),
                      labelText: "Email"),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: isLoading ? null : () => fetchAlbum(),
                  child: Text(
                    'Entrar',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      minimumSize:
                          Size(MediaQuery.of(context).size.width / 1.8, 50),
                      backgroundColor: Colors.blue),   
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
