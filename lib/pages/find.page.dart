


import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wpp/controllers/user_controller.dart';
import 'package:wpp/models/find.model.dart';
import 'package:wpp/models/request.model.dart';
import 'package:wpp/utils/app.environment.dart';
import 'package:wpp/utils/dio.interceptor.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}





class _RequestPageState extends State<RequestPage> {

  late UserController userContext;
  List<Find> requestList = [];
  Dio dio = DioClient().dio;

    fetchRequests() async {
    try {
      var baseUrl = Enviroment.baseUrl;
      var response = await dio.get<List<dynamic>>(
        '$baseUrl/contacts/all',
        options: Options(
          contentType: 'application/json; charset=UTF-8',
          headers: {'Authorization': 'Bearer ${userContext.user?.token}'},
        ),
      );
      // print(response.statusCode);
      List<Find> requests = [];
      // print("Kevin Lindo");
      // print(response.data);
      response.data?.forEach((element) {
        print(element);
        Find request = Find.fromJson(element);
        print(request.username);
        requests.add(request);
      });

      setState(() {
        requestList = requests;
      });
    } on DioException catch (e) {
      print(e.response!.data);
      print('Deu muito ruim');
      print(e);
    } catch (e) {
      print('Erro ao buscar contatos');
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchRequests();

  }

  @override
  Widget build(BuildContext context) {
    userContext = context.watch<UserController>();

     return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 80,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              userContext.dispose();
                              Navigator.of(context).pop();
                            },
                          ),
                          
                        ],
                      ),
                      
                    ]),
              ),
              Text(
                'Descobrir contatos',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: requestList.length,
                  itemBuilder: (BuildContext context, int index) {
                    
                    return RequestCard(
                      requestList[index], context
                    );
                  },
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

    InkWell RequestCard(Find request, BuildContext context) {
    return InkWell(
      onTap: () {
        print(request.username.toString());
        
        print(request.id.toString());
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
                  Text(request.username!,
                      style: const TextStyle(color: Colors.blue)),
                  
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
}