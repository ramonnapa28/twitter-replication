import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Assuming you're using this for SvgPicture
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For ScreenUtil()
import 'package:provider/provider.dart'; // For context.read()
import 'package:sample_api/utils/widgets.dart';
import '../services/user_service.dart'; // Import your UserService
import '../models/user_model.dart'; // Import your User model
import '../providers/user_provider.dart'; // Import UserProvider
import '../utils/constants.dart'; // Import your constants

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Method to validate user input and handle login
  void validate() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      customDialog(
        context,
        title: 'Error',
        content: 'Input all required fields',
      );
    } else {
      showLoadingDialog(context);
      UserService userService = UserService();
      try {
        await userService.fetchAllUsers();
        bool userFound = false;

        for (var user in userService.data) {
          if ((user['username'] == usernameController.text) &&
              (user['email'] == passwordController.text)) {
            User loggedInUser = User(
              id: user['id'],
              name: user['name'],
              age: user['age'],
              username: user['username'],
              email: user['email'],
              address: user['address'],
              phone: user['phone'],
              website: user['website'],
              occupation: user['occupation'],
              hobbies: user['hobbies'],
            );

            // Save user information in provider
            context.read<UserProvider>().setUserModel(loggedInUser);
            Navigator.pushReplacementNamed(context, '/home_screen');
            userFound = true;
            break;
          }
        }

        if (!userFound) {
          Navigator.pop(context);
          customDialog(
            context,
            title: 'Error',
            content: 'Invalid Username or Password',
          );
        }
      } catch (e) {
        Navigator.pop(context);
        customDialog(
          context,
          title: 'Error',
          content: 'An error occurred during login',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TWITTER_BLACK,
      body: SingleChildScrollView(
        child: Container(
          color: TWITTER_BLACK,
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  height: ScreenUtil().setHeight(40)), // Spacing at the top
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(25),
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/x-logo.svg',
                      height: ScreenUtil().setHeight(85),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(30)),
                    CustomIconTextField(
                      fillColor: TWITTER_GREY,
                      fontColor: TWITTER_WHITE,
                      prefixIcon: const Icon(
                        Icons.person,
                        color: TWITTER_BLACK,
                      ),
                      controller: usernameController,
                      hintText: 'Username',
                      hintTextSize: ScreenUtil().setSp(15),
                      fontSize: ScreenUtil().setSp(15),
                      height: ScreenUtil().setHeight(45),
                      width: ScreenUtil().screenWidth,
                    ),
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    CustomIconTextField(
                      fillColor: TWITTER_GREY,
                      fontColor: TWITTER_WHITE,
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: TWITTER_BLACK,
                      ),
                      controller: passwordController,
                      isObscure: true,
                      hintText: 'Password',
                      hintTextSize: ScreenUtil().setSp(15),
                      fontSize: ScreenUtil().setSp(15),
                      height: ScreenUtil().setHeight(45),
                      width: ScreenUtil().screenWidth,
                    ),
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    CustomButton(
                      bgColor: TWITTER_GREY,
                      onTap: validate,
                      height: ScreenUtil().setHeight(45),
                      width: ScreenUtil().screenWidth,
                      fontSize: ScreenUtil().setSp(20),
                      fontWeight: FontWeight.bold,
                      buttonName: 'Login',
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: ScreenUtil().setHeight(40)), // Spacing at the bottom
              Container(
                width: ScreenUtil().screenWidth,
                height: ScreenUtil().setHeight(40),
                color: TWITTER_BLACK,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'You do not have an account?',
                      style: TextStyle(
                        color: Colors.grey.shade200,
                        fontSize: ScreenUtil().setSp(15),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to registration screen or show register dialog
                        print("Navigate to registration screen");
                      },
                      child: Text(
                        'Register here',
                        style: TextStyle(
                          color: TWITTER_WHITE,
                          fontSize: ScreenUtil().setSp(15),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
