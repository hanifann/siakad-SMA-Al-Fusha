import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_sma_al_fusha/features/login/presentation/widgets/column_title_and_textfield_widget.dart';
import 'package:siakad_sma_al_fusha/features/login/presentation/widgets/custom_textfield_widget.dart';
import 'package:siakad_sma_al_fusha/themes/colors.dart';
import 'package:siakad_sma_al_fusha/widgets/text_widget.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginPage();
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController usernameEditingController;
  late TextEditingController passwordEditingController;
  bool isObscure = true;

  @override
  void initState() {
    usernameEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 140.w,
                height: 180.h,
              ),
              SizedBox(height: 36.h,),
              userNameTextFieldWidget(),
              SizedBox(height: 24.h,),
              passwordTextFieldWidget(),
              SizedBox(height: 48.h,),
              masukBtnWidget()
            ],
          ),
        ),
      ),
    );
  }

  SizedBox masukBtnWidget() {
    return SizedBox(
      width: 1.sw,
      child: ElevatedButton(
        onPressed: () {
          
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          padding: EdgeInsets.only(
            top: 12.h,
            bottom: 11.h
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              8.r,
            ),
          ),
        ), 
        child: CustomTextWidget(
          text: 'Masuk',
          color: Colors.white,
          weight: FontWeight.bold,
          size: 18.sp,
        ),
      ),
    );
  }

  ColumnTitleAndTextFieldWidget passwordTextFieldWidget() {
    return ColumnTitleAndTextFieldWidget(
      textfield: CustomTextfieldWidget(
        controller: passwordEditingController, 
        hint: 'Password',
        isObscure: isObscure,
        suffixIcon: isObscure ? 
        Icons.visibility_outlined : 
        Icons.visibility_off_outlined,
        onSuffixTap: () {
          setState(() {
            isObscure = !isObscure;
          });
        },
      ), 
      title: 'Password',
    );
  }

  ColumnTitleAndTextFieldWidget userNameTextFieldWidget() {
    return ColumnTitleAndTextFieldWidget(
      textfield: CustomTextfieldWidget(
        controller: usernameEditingController, 
        hint: 'Username',
      ), 
      title: 'Username',
    );
  }
}
