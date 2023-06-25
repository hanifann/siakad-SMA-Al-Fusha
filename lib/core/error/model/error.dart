import 'dart:convert';

import 'package:equatable/equatable.dart';

ErrorModel errorFromJson(String str) => ErrorModel.fromJson(jsonDecode(str));

class ErrorModel extends Equatable{
    const ErrorModel({
      required this.statusCode,
      this.message,
    });

    final int statusCode;
    final String? message;

    factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        statusCode: json["statusCode"],
        message: json["message"] == null ? null : json['message'],
    );
    
    @override
    List<Object?> get props => [
      statusCode,
      message,
    ];
}
