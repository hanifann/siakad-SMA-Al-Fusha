import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_sma_al_fusha/features/student/beranda_student/presentation/views/beranda_student_view.dart';
import 'package:siakad_sma_al_fusha/themes/colors.dart';
import 'package:siakad_sma_al_fusha/widgets/text_widget.dart';

class HomeStudentView extends StatelessWidget {
  const HomeStudentView({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeStudentPage();
  }
}

class HomeStudentPage extends StatefulWidget {
  const HomeStudentPage({super.key});

  @override
  State<HomeStudentPage> createState() => _HomeStudentPageState();
}

class _HomeStudentPageState extends State<HomeStudentPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle();

  static const List<Widget> _widgetOptions = <Widget>[
    BerandaStudentView(),
    Text(
      'jadwal',
      style: optionStyle,
    ),
    Text(
      'Nilai',
      style: optionStyle,
    ),
    Text(
      'pengumuman',
      style: optionStyle,
    ),
  ];

  static const List<BottomNavigationBarItem> _bottomNavItem = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Beranda',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.today),
      label: 'Jadwal',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.military_tech),
      label: 'Nilai',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.info),
      label: 'Pengumuman',
    ),
  ];

  static const List<String> _title = <String>[
    'Beranda',
    'jadwal',
    'Nilai',
    'Pengumuman'
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.10),
              offset: const Offset(0, -2),
              blurRadius: 8,
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: _bottomNavItem,
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          backgroundColor: Colors.white,
          unselectedItemColor: kPrimaryTextColor,
          // selectedItemColor: kPrimaryColor,
          selectedFontSize: 12.sp,
          unselectedFontSize: 12.sp,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          fixedColor: kPrimaryColor,
        ),
      ),
    );
  }

  AppBar appBarWidget() {
    return AppBar(
      elevation: 1,
      centerTitle: false,
      title: CustomTextWidget(
        text: _title[_selectedIndex],
        weight: FontWeight.bold,
        size: 24.sp,
      ),
      actions: [
        Container(
          padding: EdgeInsets.fromLTRB(10.w, 4.h, 4.w, 4.h),
          margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(666.r),
            color: kPrimaryColor,
          ),
          child: Row(
            children: [
              CustomTextWidget(
                text: 'Pelajar',
                color: Colors.white,
                weight: FontWeight.bold,
                size: 14.sp,
              ),
              SizedBox(width: 4.w,),
              Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}