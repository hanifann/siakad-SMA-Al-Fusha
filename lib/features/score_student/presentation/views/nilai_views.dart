import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siakad_sma_al_fusha/features/login/presentation/widgets/column_title_and_textfield_widget.dart';
import 'package:siakad_sma_al_fusha/features/score_student/domain/entities/tahun_ajaran.dart';
import 'package:siakad_sma_al_fusha/features/score_student/presentation/bloc/nilai_bloc.dart';
import 'package:siakad_sma_al_fusha/features/score_student/presentation/bloc/tahun_ajaran_bloc.dart';
import 'package:siakad_sma_al_fusha/features/score_student/presentation/widgets/container_nilai_widget.dart';
import 'package:siakad_sma_al_fusha/features/score_student/presentation/widgets/custom_dropdown_btn_widget.dart';
import 'package:siakad_sma_al_fusha/injection_container.dart';
import 'package:siakad_sma_al_fusha/widgets/text_widget.dart';

class NilaiView extends StatelessWidget {
  const NilaiView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
        BlocProvider(
          create: (context) => sl<NilaiBloc>()..add(GetUserIdEvent()),
        ),
          BlocProvider(
            create: (context) => sl<TahunAjaranBloc>()..add(GetTahunAjaranEvent()),
          ),
        ],
      child: const NilaiPage(),
    );
  }
}

class NilaiPage extends StatefulWidget {
  const NilaiPage({super.key});

  @override
  State<NilaiPage> createState() => _NilaiPageState();
}

class _NilaiPageState extends State<NilaiPage> {
  bool isExpand = false;
  String? idUsers;
  String? tahunAjaran;
  bool isFirst = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          tahunAjaranBlocBuilderWidget(),
          SizedBox(height: 16.h,),
          nilaiBlocConsumerWidget()
        ],
      )
    );
  }

  BlocBuilder<TahunAjaranBloc, TahunAjaranState> tahunAjaranBlocBuilderWidget() {
    return BlocBuilder<TahunAjaranBloc, TahunAjaranState>(
      builder: (context, state) {
        if(state is TahunAjaranLoaded){
          if(isFirst){
            context.read<NilaiBloc>().add(
              GetNilaiEvent(idUsers!, state.tahunAjaran.data.first.id)
            );
          }

          isFirst = false;

          return ColumnTitleAndTextFieldWidget(
            textfield: CustomDropdownBtnWidget(
              items: state.tahunAjaran.data.map<DropdownMenuItem<String>>((TahunAjaranData e) {
                return DropdownMenuItem<String>(
                  value: e.id,
                  child: CustomTextWidget(
                    text: e.nameThnAjaran,
                    size: 14.sp,
                    weight: FontWeight.w500,
                  ),
                );
              }).toList(), 
              onChange: (value) {
                setState(() {
                  tahunAjaran = value!;
                });
                context.read<NilaiBloc>().add(
                  GetNilaiEvent(idUsers!, tahunAjaran!)
                );
              },
              value: tahunAjaran ?? state.tahunAjaran.data.first.id,
            ), 
            title: 'Tahun Ajaran'
          );
        } else if (state is TahunajaranFailed){
          return CustomTextWidget(
            text: state.error.message!
          );
        } else {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: 1.sw,
              height: 50.h,
              color: Colors.white,
            ),
          );
        }
      },
    );
  }

  BlocConsumer<NilaiBloc, NilaiState> nilaiBlocConsumerWidget() {
    return BlocConsumer<NilaiBloc, NilaiState>(
      listener: (context, state) {
        if(state is UserDataLoaded){
          setState(() {
            idUsers = state.user.data[0].idUsers;
          });
        }
      },
      builder: (context, state) {
        if(state is NilaiLoaded){
          return ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ContainerNilaiWidget(
                isExpand: isExpand, 
                nilai: state.nilai.data[index], 
                onIconTap: () {
                  setState(() {
                    isExpand = !isExpand;
                  });
                },
              );
            }, 
            separatorBuilder: (_, __) => SizedBox(height: 16.h), 
            itemCount: state.nilai.data.length
          );
        } else if (state is NilaiFailed){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/error.png',
                  height: 256.r,
                  width: 256.r,
                ),
                SizedBox(height: 16.h,),
                CustomTextWidget(
                  text: state.error.message!,
                  size: 14.sp,
                  weight: FontWeight.w500,
                )
              ],
            ),
          ); 
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }
}