import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Assuming you're using ScreenUtil
import 'package:sample_api/utils/widgets.dart';
import '../providers/user_provider.dart'; // Import your UserProvider
import '../models/user_model.dart'; // Import your User model
import '../utils/constants.dart'; // Import your constants
import 'login_screen.dart'; // Import your LoginScreen

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProvider? userProvider;
  User? user;

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context, listen: true);
    user = userProvider?.getUserModel;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(25),
            vertical: ScreenUtil().setHeight(25),
          ), // EdgeInsets.symmetric
          color: TWITTER_BLACK,
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.person_3,
                color: TWITTER_GREY,
                size: ScreenUtil().setSp(50),
              ), // Icon
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ), // SizedBox
              InterFont(
                text: user?.name ?? 'Ramon Jr. A Napa',
                fontSize: ScreenUtil().setSp(30),
                color: TWITTER_WHITE,
              ), // InterFont
              SizedBox(
                height: ScreenUtil().setHeight(3),
              ), // SizedBox
              InterFont(
                text: user?.occupation ?? 'Student',
                fontSize: ScreenUtil().setSp(20),
                color: TWITTER_WHITE,
              ), // InterFont
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ), // SizedBox
              InterFont(
                text: 'Age: ${user?.age ?? '22'}',
                fontSize: ScreenUtil().setSp(12),
                color: TWITTER_WHITE,
              ), // InterFont
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ), // SizedBox
              InterFont(
                text:
                    'Address: ${user?.address["street"] ?? 'Barcelona Street'}, ${user?.address['city'] ?? 'Paranaque City'}',
                fontSize: ScreenUtil().setSp(12),
                color: TWITTER_WHITE,
              ), // InterFont
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ), // SizedBox
              InterFont(
                text: 'Phone: ${user?.phone ?? '09361015257'}',
                fontSize: ScreenUtil().setSp(12),
                color: TWITTER_WHITE,
              ), // InterFont
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ), // SizedBox
              InterFont(
                text: 'Website: ${user?.website ?? 'Twitter'}',
                fontSize: ScreenUtil().setSp(12),
                color: TWITTER_WHITE,
              ), // InterFont
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ), // SizedBox
              InterFont(
                text: 'Hobbies: ${user?.hobbies.join(', ') ?? 'Watching'}',
                fontSize: ScreenUtil().setSp(12),
                color: TWITTER_WHITE,
              ), // InterFont
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ), // SizedBox
            ],
          ), // Column
        ), // Container
      ), // SingleChildScrollView
    ); // Scaffold
  }
}
