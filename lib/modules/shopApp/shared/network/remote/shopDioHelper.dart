
import 'package:dio/dio.dart';
class shopDioHelper {
  static late   Dio dio  = Dio();


  static init(){
    dio = Dio(
        BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
        )

    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic> ? query,
    String lang = 'en',
    String ?  token,
  }) async{



    dio.options.headers = {
      'lang': lang,
      'Authorization' : token,
      'content-Type':'application/json',
    };


    return await dio.get(url , queryParameters: query,);
  }


  static Future<Response> postData({
    required String url,
    final Map<String, dynamic>? query,
    required  Map<String, dynamic> data,
    String lang = 'en',
    String ?  token,
}) async{

    dio.options.headers = {
    'lang': lang,
    'Authorization' : token,
      'content-Type':'application/json',

    };
  return dio.post(
    url ,
    data: data,
  );
}




  static Future<Response> putData({
    required String url,
    final Map<String, dynamic>? query,
    required  Map<String, dynamic> data,
    String lang = 'en',
    String ?  token,
  }) async{

    dio.options.headers = {
      'lang': lang,
      'Authorization' : token,
      'content-Type':'application/json',

    };
    return dio.put(
      url ,
      data: data,
    );
  }

}