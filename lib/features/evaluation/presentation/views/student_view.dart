import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/data/models/class_model.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/presentation/bloc/student_bloc.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/presentation/widgets/container_data_kelas_widget.dart';
import 'package:siakad_sma_al_fusha/injection_container.dart';
import 'package:siakad_sma_al_fusha/themes/colors.dart';
import 'package:siakad_sma_al_fusha/widgets/error_widget.dart';
import 'package:siakad_sma_al_fusha/widgets/text_widget.dart';

class StudentView extends StatelessWidget {
  const StudentView({super.key, required this.classDataModel});
  final ClassDataModel classDataModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<StudentBloc>()..add(GetTokenEvent()),
      child: StudentPage(classDataModel: classDataModel),
    );
  }
}

class StudentPage extends StatelessWidget {
  const StudentPage({super.key, required this.classDataModel});
  final ClassDataModel classDataModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: 'Kelas ${classDataModel.nama}',
                size: 18.sp,
                weight: FontWeight.bold,
              ),
              BlocConsumer<StudentBloc, StudentState>(
                listener: (context, state) {
                  if(state is TokenLoaded){
                    context.read<StudentBloc>().add(
                      GetStudentByClassEvent(classDataModel.id)
                    );
                  }
                },
                builder: (context, state) {
                  if(state is StudentLoaded){
                    return studentLoadedWidget(state);
                  } else if (state is StudentFailed){
                    return CustomErrorWidget(message: state.error.message!);
                  } else {
                    return studentLoadingWidget();
                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }

    ListView studentLoadingWidget() {
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.all(16.r),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: kPrimaryColor.withOpacity(.1),
          child: Container(
            height: 80.h,
            width: 1.sw,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: Colors.white
            ),
          ),
        );
      }, 
      separatorBuilder: (_,__) => SizedBox(height: 12.h,), 
      itemCount: 5
    );
  }

  ListView studentLoadedWidget(StudentLoaded state) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 12.sp),
      primary: false,
      itemBuilder: (context, index) {
        return ContainerDataKelasWidget(
          classData: ClassDataModel(
            id: '1',
            nama: state.student.data[index].namaUser,
          ),
          isKelas: false,
        );
      }, 
      separatorBuilder: (_,__)=> SizedBox(height: 16.sp,), 
      itemCount: state.student.data.length
    );
  }

  AppBar appBarWidget() {
    return AppBar(
      elevation: 1,
      centerTitle: false,
      title: CustomTextWidget(
        text: 'Daftar Siswa',
        weight: FontWeight.bold,
        size: 24.sp,
      ),
    );
  }
}
