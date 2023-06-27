import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_sma_al_fusha/features/student/score_student/presentation/bloc/nilai_bloc.dart';
import 'package:siakad_sma_al_fusha/injection_container.dart';
import 'package:siakad_sma_al_fusha/themes/colors.dart';
import 'package:siakad_sma_al_fusha/widgets/text_widget.dart';

class NilaiView extends StatelessWidget {
  const NilaiView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NilaiBloc>()..add(GetUserIdEvent()),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<NilaiBloc, NilaiState>(
        listener: (context, state) {
          if(state is UserDataLoaded){
            context.read<NilaiBloc>().add(GetNilaiEvent(state.user.data[0].id));
          }
        },
        builder: (context, state) {
          if(state is NilaiLoaded){
            return ListView.separated(
              padding: EdgeInsets.all(16.r),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(left: 4.w),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: kPrimaryColor.withOpacity(.15),
                        blurRadius: 15
                      )
                    ]
                  ),
                  child: Container(
                    height: 60.h,
                    padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 9.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.r),
                        bottomRight: Radius.circular(8.r)
                      ),
                    ),
                    child: Row(
                      children: [
                        CustomTextWidget(
                          text: state.nilai.data[index].nama,
                          weight: FontWeight.w600,
                          size: 14.sp,
                        ),
                        const Spacer(),
                        CustomTextWidget(
                          text: state.nilai.data[index].rataRata,
                          weight: FontWeight.w600,
                          size: 14.sp,
                          color: const Color.fromRGBO(77, 138, 240, 1),
                        ),
                        SizedBox(width: 8.w,),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpand = !isExpand;
                            });
                          },
                          child: const Icon(Icons.expand_more)
                        )
                      ],
                    ),
                  ),
                );
              }, 
              separatorBuilder: (_, __) => SizedBox(height: 16.h), 
              itemCount: state.nilai.data.length
            );
          } else if (state is NilaiFailed){
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
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
              ),
            ); 
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      )
    );
  }
}