import 'dart:convert';

import 'package:equatable/equatable.dart';

ErrorModel errorFromJson(String str) => ErrorModel.fromJson(jsonDecode(str));

class ErrorModel extends Equatable{
    const ErrorModel({
      this.message,
    });

    final String? message;

    factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        message: json["message"] == null ? null : json['message'],
    );
    
    @override
    List<Object?> get props => [
      message,
    ];
}
