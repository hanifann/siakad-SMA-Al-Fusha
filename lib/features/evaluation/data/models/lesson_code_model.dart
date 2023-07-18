import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/lesson_code.dart';

class LessonCodeModel extends LessonCode {
  const LessonCodeModel({required super.data});
  
  factory LessonCodeModel.fromJson(Map<String, dynamic> json) => LessonCodeModel(
        data: List<String>.from(json["data"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x)),
    };
}