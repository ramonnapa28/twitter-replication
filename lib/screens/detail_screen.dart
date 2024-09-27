import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/constants.dart';
import '../utils/widgets.dart';

class DetailsScren extends StatelessWidget {
  const DetailsScren({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey.shade300,
          width: ScreenUtil().screenWidth,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(30),
                  vertical: ScreenUtil().setHeight(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      onTap: () => Navigator.pop(context),
                      height: ScreenUtil().setHeight(40),
                      width: ScreenUtil().setWidth(50),
                      bgColor: Colors.white,
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                      ),
                    ),
                    CustomButton(
                      onTap: () {},
                      height: ScreenUtil().setHeight(40),
                      width: ScreenUtil().setWidth(50),
                      bgColor: Colors.white,
                      icon: const Icon(
                        CupertinoIcons.heart_fill,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(30),
                  vertical: ScreenUtil().setHeight(30),
                ),
                child: Placeholder(
                  fallbackHeight: ScreenUtil().setHeight(100),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Container(
                padding: EdgeInsets.only(
                  right: ScreenUtil().setWidth(35),
                  left: ScreenUtil().setWidth(35),
                  top: ScreenUtil().setHeight(30),
                ),
                width: ScreenUtil().screenWidth,
                height: ScreenUtil().screenHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InterFont(
                          text: data['name'],
                          fontSize: ScreenUtil().setSp(15),
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                        InterFont(
                          text: data['rating'].toString(),
                          fontSize: ScreenUtil().setSp(25),
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    InterFont(
                      text: data['price'].toString(),
                      fontSize: ScreenUtil().setSp(20),
                      color: Colors.black45,
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    InterFont(
                      text: 'Description: ',
                      fontSize: ScreenUtil().setSp(15),
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    InterFont(
                      text:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ac ut consequat semper viverra nam. Ultrices eros in cursus turpis massa tincidunt. Pretium fusce id velit ut tortor pretium viverra. Tempus imperdiet nulla malesuada pellentesque elit. Aliquam id diam maecenas ultricies mi. Eget nunc lobortis mattis aliquam faucibus purus in massa tempor. Pulvinar etiam non quam lacus suspendisse faucibus interdum posuere. Purus viverra accumsan in nisl nisi. Orci nulla pellentesque dignissim enim. Viverra adipiscing at in tellus integer feugiat scelerisque.',
                      fontSize: ScreenUtil().setSp(15),
                      textAlign: TextAlign.justify,
                      color: Colors.black45,
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
