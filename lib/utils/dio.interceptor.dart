


import 'package:dio/dio.dart';

class DioClient{


  static final Dio _dio = Dio();

  Dio get dio => _dio; 

  DioClient() {
     _dio.interceptors.clear();
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('Response: ${response.statusCode} ${response.data}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        return handler.next(e);
      },
    ));
  }


  UpdateInterceptor(String bearerToken){
    print("Setando interceptor");
    _dio.interceptors.clear();
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print('Request: ${options.method} ${options.path}');
        options.headers['Authorization'] = 'Bearer $bearerToken';
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('Response: ${response.statusCode} ${response.data}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        print('Error: ${e.response?.statusCode} ${e.message}');
        return handler.next(e);
      },
    ));
  }

  makeRequest(){
    
  }


}


