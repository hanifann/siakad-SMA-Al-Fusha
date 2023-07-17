import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/presentation/bloc/class_bloc.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/presentation/widgets/container_data_kelas_widget.dart';
import 'package:siakad_sma_al_fusha/injection_container.dart';
import 'package:siakad_sma_al_fusha/widgets/error_widget.dart';

import '../../../../themes/colors.dart';

class ClassView extends StatelessWidget {
  const ClassView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ClassBloc>()..add(GetAllClassEvent()),
      child: const ClassPage(),
    );
  }
}

class ClassPage extends StatelessWidget {
  const ClassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return classBlocConsumerWidget();
  }

  BlocBuilder<ClassBloc, ClassState> classBlocConsumerWidget() {
    return BlocBuilder<ClassBloc, ClassState>(
      builder: (context, state) {
        if(state is ClassLoaded){
          return  ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            itemBuilder: (context, index){
              return GestureDetector(
                onTap: () {
                  context.push(
                    '/student',
                    extra: state.data.data[index]
                  );
                },
                child: ContainerDataKelasWidget(classData: state.data.data[index])
              );
            }, 
            separatorBuilder: (_,__) => SizedBox(height: 12.h,), 
            itemCount: state.data.data.length
          );
        } else if (state is ClassFailed){
          return CustomErrorWidget(message: state.error.message!);
        } else {
          return classLoadingWidget();
        }
      },
    );
  }

  ListView classLoadingWidget() {
    return ListView.separated(
      shrinkWrap: true,
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
}