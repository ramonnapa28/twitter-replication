import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

CircularProgressIndicator genericLoading = const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(TWITTER_WHITE));

class InterFont extends StatelessWidget {
  const InterFont(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.color,
      this.fontWeight = FontWeight.normal,
      this.textAlign = TextAlign.left,
      this.letterSpacing = 0});

  final String text;
  final double fontSize, letterSpacing;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      maxLines: 4,
      softWrap: false,
      style: TextStyle(
          fontFamily: 'Inter',
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing),
    );
  }
}

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final onTap;
  final double height;
  final double width;
  final double fontSize;
  final String buttonName;
  final Icon icon;
  FontWeight fontWeight;
  Color bgColor;
  Color fontColor;
  CustomButton(
      {super.key,
      required this.onTap,
      required this.height,
      required this.width,
      this.buttonName = '',
      this.bgColor = TWITTER_WHITE,
      this.fontColor = Colors.white,
      this.fontSize = 1,
      this.icon = const Icon(null),
      this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: buttonName == ''
              ? icon
              : Text(
                  buttonName,
                  style: TextStyle(
                      color: fontColor,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      fontFamily: 'Inter'),
                ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final String hintText;
  final double height;
  final double width;
  final double hintTextSize;
  final double fontSize;
  Icon prefixIcon;
  final TextEditingController controller;
  final Color fillColor;
  bool isObscure;
  TextInputType keyboardType;
  int maxLength;
  CustomTextField(
      {super.key,
      required this.hintText,
      required this.height,
      required this.width,
      this.fillColor = Colors.black12,
      this.prefixIcon = const Icon(null),
      this.isObscure = false,
      this.keyboardType = TextInputType.text,
      required this.controller,
      required this.hintTextSize,
      required this.fontSize,
      this.maxLength = 200});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      style: TextStyle(
        fontSize: fontSize,
      ),
      keyboardType: keyboardType,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
      ],
      decoration: InputDecoration(
          focusColor: Colors.black12,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black12,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black12,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          filled: true,
          hintStyle: TextStyle(color: Colors.black12, fontSize: hintTextSize),
          hintText: hintText,
          fillColor: fillColor),
    );
  }
}

Widget CustomIconTextField({
  required hintText,
  required height,
  required width,
  required fontColor,
  fillColor = Colors.black12,
  prefixIcon = const Icon(null),
  isObscure = false,
  required controller,
  required hintTextSize,
  required fontSize,
  onChanged,
}) {
  return TextField(
    controller: controller,
    obscureText: isObscure,
    onChanged: onChanged,
    style: TextStyle(
      fontSize: fontSize,
      color: fontColor,
    ),
    decoration: InputDecoration(
        prefixIcon: prefixIcon,
        focusColor: Colors.black12,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: TWITTER_BLACK,
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: TWITTER_BLACK,
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        filled: true,
        hintStyle: TextStyle(
          color: Colors.black12,
          fontSize: hintTextSize,
          fontFamily: 'Inter',
        ),
        hintText: hintText,
        fillColor: fillColor),
  );
}

// Dialogs
void showCustomDialog(BuildContext context, {height, width, fontSize}) {
  showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
          child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(ScreenUtil().setSp(10)),
                  height: height * a1.value, // USE PROVIDED ANIMATION
                  width: width * a1.value,
                  decoration: const BoxDecoration(
                      color: TWITTER_BLACK,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultTextStyle(
                          style: TextStyle(
                            fontSize: fontSize * a1.value,
                            color: Colors.white,
                          ),
                          child: Text(
                            'Please fill up all blah blah',
                            textAlign: TextAlign.center,
                          ),
                        )
                      ]),
                ),
              )),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Placeholder();
      });
}

customDialog(BuildContext context, {required title, required content}) {
  AlertDialog alertDialog = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: <Widget>[
      ElevatedButton(
        child: Text('Okay'),
        style: ElevatedButton.styleFrom(
            backgroundColor: TWITTER_BLACK, foregroundColor: Colors.white),
        onPressed: () {
          Navigator.of(context).pop();
          // Navigator.pushNamed(context, '/register_success');
        },
      ),
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alertDialog;
    },
  );
}

customDialogWithSub(
    BuildContext context, String errorMessage, String errorMessageSub) {
  return showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        backgroundColor: Colors.white,
        //insetPadding: EdgeInsets.symmetric(horizontal: size.width * 0.7),
        content: Builder(
          builder: (context) {
            // Get available height and width of the build area of this widget. Make a choice depending on the size.
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: ScreenUtil().setHeight(15),
                  ),
                  SvgPicture.asset(
                    'assets/icons/warning.svg',
                    width: ScreenUtil().setWidth(75),
                    height: ScreenUtil().setHeight(75),
                    color: TWITTER_BLACK,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(35),
                  ),
                  InterFont(
                    text: errorMessage,
                    fontSize: ScreenUtil().setSp(35),
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(35),
                  ),
                  InterFont(
                    text: errorMessageSub,
                    fontSize: ScreenUtil().setSp(20),
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(60),
                  ),
                  CustomButton(
                      onTap: () => Navigator.pop(context),
                      height: ScreenUtil().setHeight(45),
                      width: ScreenUtil().screenWidth,
                      fontSize: ScreenUtil().setSp(20),
                      fontWeight: FontWeight.bold,
                      buttonName: 'Okay'),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

showLoadingDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        genericLoading,
        Container(
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(15)),
            child: const Text("Loading...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
