import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_sma_al_fusha/features/announcement/views/announcement_view.dart';
import 'package:siakad_sma_al_fusha/features/beranda/presentation/views/beranda_view.dart';
import 'package:siakad_sma_al_fusha/features/home/presentation/cubit/role_cubit.dart';
import 'package:siakad_sma_al_fusha/features/schedule/presentation/views/schedule_view.dart';
import 'package:siakad_sma_al_fusha/injection_container.dart';
import 'package:siakad_sma_al_fusha/themes/colors.dart';
import 'package:siakad_sma_al_fusha/widgets/text_widget.dart';

class HomeLecturerView extends StatelessWidget {
  const HomeLecturerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RoleCubit>()..getRoleEvent(),
      child: const HomeLecturerPage(),
    );
  }
}

class HomeLecturerPage extends StatefulWidget {
  const HomeLecturerPage({super.key});

  @override
  State<HomeLecturerPage> createState() => _HomeLecturerPageState();
}

class _HomeLecturerPageState extends State<HomeLecturerPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    BerandaView(),
    ScheduleView(),
    Text('penilaian'),
    AnnouncementView()
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
          padding: EdgeInsets.all(8.r),
          margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(666.r),
            color: kPrimaryColor,
          ),
          child: BlocBuilder<RoleCubit, RoleState>(
            builder: (context, state) {
              if(state is RoleLoaded){
                return CustomTextWidget(
                  text: state.role,
                  color: Colors.white,
                  weight: FontWeight.bold,
                  size: 14.sp,
                );
              } else {
                return CustomTextWidget(
                  text: '...',
                  color: Colors.white,
                  weight: FontWeight.bold,
                  size: 14.sp,
                );
              }
            },
          ),
        )
      ],
    );
  }
}
