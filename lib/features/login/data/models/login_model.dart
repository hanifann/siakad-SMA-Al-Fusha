import 'package:siakad_sma_al_fusha/features/login/domain/entities/login.dart';

class LoginModel extends Login {
  const LoginModel({required super.data});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "data": data,
    };

}