import 'package:equatable/equatable.dart';

class LessonCode extends Equatable{
    final List<String> data;

    const LessonCode({
        required this.data,
    });
    
      @override
      List<Object?> get props => [
        data
      ];

}
