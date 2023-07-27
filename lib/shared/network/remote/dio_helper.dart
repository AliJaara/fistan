import 'package:dio/dio.dart';

class DioHelper{
static late Dio dio;
static init(){
  dio= Dio(
      BaseOptions(baseUrl: 'https://student.valuxapps.com/api/'
      ),
  );
}
static Future<Response> getData({
  required String path,
  queryParameters,
  String? lang,
  String? token,
})async{
  dio.options.headers={
    'Content-Type':'application/json',
    'lang':lang,
    'Authorization':token,
  };
 return await dio.post(
      path,
    queryParameters: queryParameters
  );
}
}