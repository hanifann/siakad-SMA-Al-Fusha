import 'package:equatable/equatable.dart';

class Class extends Equatable{
    final List<ClassData> data;

    const Class({
        required this.data,
    });
    
      @override
      List<Object?> get props => [
        data
      ];

}

class ClassData extends Equatable{
    final String id;
    final String nama;

    const ClassData({
        required this.id,
        required this.nama,
    });
    
      @override
      List<Object?> get props => [
        id,
        nama
      ];

}
