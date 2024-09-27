import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/constants.dart';
import '../utils/widgets.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Assuming data is passed as arguments to this screen.
    final data = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TWITTER_BLACK,
        elevation: 2,
        leading: IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: TWITTER_WHITE,
          ),
        ),
        centerTitle: true,
        title: InterFont(
          text: "Comments",
          fontSize: ScreenUtil().setSp(17.5),
          fontWeight: FontWeight.bold,
          color: TWITTER_WHITE,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: TWITTER_BLACK,
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: data['comments']
                .length, // Assuming comments are passed in the data map
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                  vertical: ScreenUtil().setHeight(18),
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: TWITTER_GREY,
                      width: 0.5,
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.account_circle_rounded,
                      color: TWITTER_GREY,
                      size: ScreenUtil().setSp(40),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(10),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Display the author name from the comment data
                        InterFont(
                          text:
                              data['comments'][index]['author'] ?? 'Anonymous',
                          fontSize: ScreenUtil().setSp(20),
                          color: TWITTER_WHITE,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(5),
                        ),
                        // Display the comment text from the comment data
                        InterFont(
                          text: data['comments'][index]['text'] ?? 'No comment',
                          fontSize: ScreenUtil().setSp(17.5),
                          color: TWITTER_WHITE,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
