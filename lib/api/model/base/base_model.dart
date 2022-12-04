import 'dart:convert';

import 'package:flutter/material.dart';

abstract class BaseModel {
  BaseModel.fromJson(Map<String, dynamic> map);

  @protected
  BaseModel.init();

  Map<String, dynamic> toJson();

  @override
  String toString() => jsonEncode(toJson());
}