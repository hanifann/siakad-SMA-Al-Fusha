import 'package:equatable/equatable.dart';

class Login extends Equatable{
    final String data;

    const Login({
        required this.data,
    });
    
      @override
      List<Object?> get props => [data];
}