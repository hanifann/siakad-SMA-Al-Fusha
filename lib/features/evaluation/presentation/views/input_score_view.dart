import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/presentation/bloc/lesson_code_bloc.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/presentation/bloc/score_bloc.dart';
import 'package:siakad_sma_al_fusha/features/login/presentation/widgets/column_title_and_textfield_widget.dart';
import 'package:siakad_sma_al_fusha/features/login/presentation/widgets/custom_textfield_widget.dart';
import 'package:siakad_sma_al_fusha/injection_container.dart';
import 'package:siakad_sma_al_fusha/themes/colors.dart';
import 'package:siakad_sma_al_fusha/widgets/custom_dialog_widget.dart';
import 'package:siakad_sma_al_fusha/widgets/text_widget.dart';

class InputScoreView extends StatelessWidget {
  const InputScoreView({super.key, required this.idUser, required this.namaSiswa});
  final String idUser;
  final String namaSiswa;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<LessonCodeBloc>()..add(GetLessonCodeEvent()),
        ),
        BlocProvider(
          create: (context) => sl<ScoreBloc>(),
        ),
      ],
      child: InputScorePage(
        idUser: idUser,
        namaSiswa: namaSiswa,
      ),
    );
  }
}

class InputScorePage extends StatefulWidget {
  const InputScorePage({super.key, required this.idUser, required this.namaSiswa});
  final String idUser;
  final String namaSiswa;
  @override
  State<InputScorePage> createState() => _InputScorePageState();
}

class _InputScorePageState extends State<InputScorePage> {
  late TextEditingController lessonCodeTextController;
  late TextEditingController rphTextController;
  late TextEditingController ptsTextController;
  late TextEditingController patTextController;
  late TextEditingController nameTextController;
  late String dropdownValue;

  @override
  void initState() {
    lessonCodeTextController = TextEditingController();
    rphTextController = TextEditingController();
    ptsTextController = TextEditingController();
    patTextController = TextEditingController();
    nameTextController = TextEditingController(text: widget.namaSiswa);
    super.initState();
  }

  @override
  void dispose() {
    lessonCodeTextController.dispose();
    rphTextController.dispose();
    ptsTextController.dispose();
    patTextController.dispose();
    nameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        children: [
          namaTextFieldWidget(),
          SizedBox(height: 16.h,),
          lessonBlocConsumerWidget(),
          SizedBox(height: 16.h,),
          rphTextFieldWidget(),
          SizedBox(height: 16.h,),
          ptsTextFieldWidget(),
          SizedBox(height: 16.h,),
          patTextFieldWidget(),
          SizedBox(height: 16.h,),
          blocListenerScoreWidget(context)
        ],
      ),
    );
  }

  BlocListener<ScoreBloc, ScoreState> blocListenerScoreWidget(BuildContext context) {
    return BlocListener<ScoreBloc, ScoreState>(
      listener: (context, state) {
        if(state is ScoreSuccess){
          context.pop();
          showDialog(
            context: context, 
            builder: (_) {
              return AlertDialog(
                titlePadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                contentPadding: EdgeInsets.all(8.r),
                title: CustomTextWidget(
                  text: 'Berhasil',
                  size: 16.sp,
                  weight: FontWeight.bold,
                ),
                content: CustomTextWidget(
                  text: 'Nilai berhasil di inputkan',
                  size: 14.sp,
                  weight: FontWeight.w500,
                ),
                actions: [
                  TextButton(
                    onPressed: () => context.pop(), 
                    child: const Text('Kembali')
                  )
                ],
              );
            }
          );
        } else if (state is ScoreFailed){
          context.pop();
          showDialog(
            context: context, 
            builder: (_) => ErrorDialog(errorValue: state.error.message!)
          );
        } else {
          showDialog(
            context: context, 
            builder: (_)=> const LoadingDialog()
          );
        }
      },
      child: SizedBox(
        height: 36.h,
        child: ElevatedButton(
          onPressed: () {
            context.read<ScoreBloc>().add(
              PostScoreEvent(
                idUser: widget.idUser, 
                lessonCode: dropdownValue, 
                rph: rphTextController.text, 
                pts: ptsTextController.text, 
                pat: patTextController.text
              )
            );
          }, 
          child: CustomTextWidget(
            text: 'Input nilai',
            color: Colors.white,
            size: 14.sp,
            weight: FontWeight.w600,
          )
        ),
      ),
    );
  }

  ColumnTitleAndTextFieldWidget patTextFieldWidget() {
    return ColumnTitleAndTextFieldWidget(
      textfield: CustomTextfieldWidget(
        controller: patTextController, 
        hint: 'Nilai PAT',
        textInputType: TextInputType.number,
      ), 
      title: 'Nilai PAT'
    );
  }

  ColumnTitleAndTextFieldWidget ptsTextFieldWidget() {
    return ColumnTitleAndTextFieldWidget(
      textfield: CustomTextfieldWidget(
        controller: ptsTextController, 
        hint: 'Nilai PTS',
        textInputType: TextInputType.number,
      ), 
      title: 'Nilai PTS'
    );
  }

  ColumnTitleAndTextFieldWidget rphTextFieldWidget() {
    return ColumnTitleAndTextFieldWidget(
      textfield: CustomTextfieldWidget(
        controller: rphTextController, 
        hint: 'Nilai RPH',
        textInputType: TextInputType.number,
      ), 
      title: 'Nilai RPH'
    );
  }

  BlocConsumer<LessonCodeBloc, LessonCodeState> lessonBlocConsumerWidget() {
    return BlocConsumer<LessonCodeBloc, LessonCodeState>(
      listener: (context, state) {
        if(state is LessonCodeFailed){
          showDialog(
            context: context, 
            builder: (_) => ErrorDialog(
              errorValue: state.error.message!
            ),
          );
        } else if (state is LessonCodeLoaded){
          context.pop();
          setState(() {
            dropdownValue = state.lessonCode.data.first;
          });
        } else{
          showDialog(
            context: context, 
            builder: (_) => const LoadingDialog()
          );
        }
      },
      builder: (context, state) {
        if(state is LessonCodeLoaded){
          return lessonCodeDropdownWidget(state);
        } else {
          return lessonCode();
        }
      },
    );
  }

  ColumnTitleAndTextFieldWidget lessonCodeDropdownWidget(LessonCodeLoaded state) {
    return ColumnTitleAndTextFieldWidget(
      title: 'Kode mata pelajaran',
      textfield: DropdownButton(
        isExpanded: true,
        underline: Container(
          height: 2,
          color: kPrimaryTextColor,
        ),
        hint: const Text('Kode mata pelajaran'),
        items: state.lessonCode.data.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: CustomTextWidget(
              text: value,
              weight: FontWeight.w500,
              size: 16.sp,
            ),
          );
        }).toList(), 
        onChanged: (value) {
          setState(() {
            dropdownValue = value!;
          });
        },
        value: dropdownValue,
      ),
    );
  }

  ColumnTitleAndTextFieldWidget lessonCode() {
    return ColumnTitleAndTextFieldWidget(
      textfield: CustomTextfieldWidget(
        controller: lessonCodeTextController, 
        hint: 'lesson',
        isEnabled: false,
      ), 
      title: 'Kode mata pelajaran'
    );
  }

  ColumnTitleAndTextFieldWidget namaTextFieldWidget() {
    return ColumnTitleAndTextFieldWidget(
      textfield: CustomTextfieldWidget(
        controller: nameTextController, 
        hint: 'nama',
        isEnabled: false,
      ), 
      title: 'Nama'
    );
  }

    AppBar appBarWidget() {
    return AppBar(
      elevation: 1,
      centerTitle: false,
      title: CustomTextWidget(
        text: 'Input Nilai',
        weight: FontWeight.bold,
        size: 24.sp,
      ),
    );
  }
}
