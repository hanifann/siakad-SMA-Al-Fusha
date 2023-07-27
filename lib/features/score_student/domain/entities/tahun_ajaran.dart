import 'package:equatable/equatable.dart';

class TahunAjaran extends Equatable{
    final List<TahunAjaranData> data;

    const TahunAjaran({
        required this.data,
    });
    
      @override
      List<Object?> get props =>[
        data
      ];

}

class TahunAjaranData extends Equatable{
    final String id;
    final String nameThnAjaran;
    final String isActive;

    const TahunAjaranData({
        required this.id,
        required this.nameThnAjaran,
        required this.isActive,
    });
    
      @override
      List<Object?> get props => [
        id,
        nameThnAjaran,
        isActive
      ];

}
