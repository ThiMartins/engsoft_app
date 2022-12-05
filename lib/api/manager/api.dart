import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

bool apiIsInitialized = false;
String baseUrl = 'http://192.168.10.58:3000/';

late Dio _dio;

Dio createDio({
  bool showLog = true,
}) {
  final dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    responseType: ResponseType.json,
    validateStatus: (statusCode) => statusCode != null,
  ));

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        handler.next(options);
      },
    ),
  );

  if (kDebugMode && showLog) {
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  return dio;
}

abstract class API {
  static Dio get currentDio => _dio;

  static Future loadAPI({
    bool showLog = true,
  }) async {
    _dio = createDio(showLog: showLog);
    apiIsInitialized = true;
  }
}
