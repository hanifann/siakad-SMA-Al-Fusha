// ignore_for_file: no_adjacent_strings_in_list

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_sma_al_fusha/features/student/beranda_student/presentation/widgets/row_visi_misi_widget.dart';

class BerandaStudentView extends StatelessWidget {
  const BerandaStudentView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BerandaStudentPage();
  }
}

class BerandaStudentPage extends StatelessWidget {
  const BerandaStudentPage({super.key});

  static const listMisi = [
    'Melaksanakan pembelajaran terpadu yang seimbang, '
    'kreatif dan menyenangkan.',
    'Membekali peserta didik dengan keahlian life skill yang komprehensif '
    'sesuai bidangnya.',
    'Membekali siswa dengan landasan moralitas religius dan menjunjung tinggi '
    'nilai pengabdian dan kejujuran.',
    'Membentuk mentalitas siswa yang siap mengisi dan menciptakan dunia usaha.',
    'Menguatkan pola managerial sekolah yang mandiri, inovatif dan futuristik.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
        children: [
          containerLogoWidget(),
          SizedBox(height: 16.h,),
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.15),
                  offset: const Offset(0, 2),
                  blurRadius: 10,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const RowVisiMisiWidget(
                  isList: false,
                  title: 'Visi',
                  value: 'Mencetak peserta didik yang unggul dalam prestasi, ' 
                  'berakhlakul karimah, taat beragama, dan berketerampilan',
                ),
                SizedBox(height: 12.h,),
                const RowVisiMisiWidget(
                  isList: true,
                  title: 'Misi',
                  list: listMisi,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container containerLogoWidget() {
    return Container(
      padding: EdgeInsets.all(8.r),
      width: 256.r,
      height: 256.r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.15),
            offset: const Offset(0, 2),
            blurRadius: 10,
          )
        ],
      ),
      child: Image.asset(
        'assets/images/logo.png',
      ),
    );
  }
}
