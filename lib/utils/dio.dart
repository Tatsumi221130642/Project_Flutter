import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:provider/provider.dart';

class DioUtils {
  static final Dio _dio = Dio();
  static FlutterSecureStorage _secureStorage= FlutterSecureStorage(); 

  static Dio get dio {
    _setupInterceptors();
    return _dio;
  }

  static void _setupInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        //Retrieve the access token from your authentication provider
        String? accessToken = await _secureStorage.read(key: 'access_token') ;

        if (accessToken != null) {
          options.headers["Authorization"] = "Bearer $accessToken";
        }
        //attach the access token to the authorization header
        options.contentType = 'application/json';

        return handler.next(options);
      },
      onError: (DioException dioException, ErrorInterceptorHandler handler) {
        if (dioException.response != null) {
          print("Response data: ${dioException.response?.data}");
        }
        return handler.next(dioException);
      },
    ));

    _dio.interceptors.add(InterceptorsWrapper(
        onResponse: (Response response, ResponseInterceptorHandler handler) {
      if (response.statusCode == 401) {}
      return handler.next(response);
    }));
  }
}
