import 'dart:convert';

import 'package:comunidade_de_engenheiros_de_software/api/model/base/base_model.dart';
import 'package:comunidade_de_engenheiros_de_software/util/reflector.dart';
import 'package:dio/dio.dart';
import 'package:reflectable/mirrors.dart';

class DataResponse<T extends BaseModel> {
  final Response<String>? response;

  DataResponse(this.response);

  T get data {
    if (response == null || response!.data == null) {
      throw Exception("A resposta ou corpo não pode ser nulo");
    }
    return toObject<T>(response!.data!);
  }

  bool get isSuccessful => response?.isSuccessful ?? false;
}

class ListDataResponse<T extends BaseModel> {
  Response<String>? response;

  ListDataResponse(this.response);

  List<T> get data {
    if (response == null || response!.data == null) {
      throw Exception("A resposta ou corpo não pode ser nulo");
    }
    return toListObject<T>(response!.data!);
  }

  bool get isSuccessful => response?.isSuccessful ?? false;
}

extension ResponseData on Response<String> {
  DataResponse<T> response<T extends BaseModel>() => DataResponse<T>(this);

  ListDataResponse<T> responseList<T extends BaseModel>() => ListDataResponse<T>(this);
}

extension StatusCode on Response {
  bool get isSuccessful {
    return statusCode != null && (statusCode ?? -1) >= 200 && (statusCode ?? -1) <= 300;
  }
}

T toObject<T extends BaseModel>(String data) {
  Map<String, dynamic> json = jsonDecode(data);
  ClassMirror classMirror = reflector.reflectType(T) as ClassMirror;
  return classMirror.newInstance('fromJson', [json]) as T;
}

List<T> toListObject<T extends BaseModel>(String data) {
  List<dynamic> json = jsonDecode(data);
  return json.map((e) {
    ClassMirror classMirror = reflector.reflectType(T) as ClassMirror;
    return classMirror.newInstance('fromJson', [e]) as T;
  }).toList();
}
