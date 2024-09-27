import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../services/post_service.dart';
import '../utils/constants.dart';
import '../utils/widgets.dart';
import '../models/post_model.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late Future<List<Post>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _postsFuture =
        PostService().fetchAllPosts(); // Directly call the method here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TWITTER_BLACK,
      body: FutureBuilder<List<Post>>(
        future: _postsFuture,
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: genericLoading);
          } else if (snapshot.hasError) {
            print("Error occurred: ${snapshot.error}");
            return Center(
              child: Text('Error: ${snapshot.error}',
                  style: TextStyle(color: TWITTER_WHITE)),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            List<Post> posts = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                Post post = posts[index];
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
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
                        size: 40.sp,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                InterFont(
                                  text: post.author,
                                  fontSize: 20.sp,
                                  color: TWITTER_WHITE,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                InterFont(
                                  text: post.time,
                                  fontSize: 20.sp,
                                  color: TWITTER_WHITE,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            InterFont(
                              text: post.title,
                              fontSize: 17.5.sp,
                              color: TWITTER_WHITE,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            InterFont(
                              text: post.content,
                              fontSize: 15.sp,
                              color: TWITTER_WHITE,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  onPressed: () {
                                    print(
                                        'Navigating to comment screen with comments: ${post.comments}');
                                    Navigator.pushNamed(
                                      context,
                                      '/comment_screen',
                                      arguments: {
                                        'comments': post.comments,
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.messenger_outline_outlined,
                                    color: TWITTER_WHITE,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                InterFont(
                                  text: '${post.comments.length}',
                                  fontSize: 15.sp,
                                  color: TWITTER_WHITE,
                                ),
                                SizedBox(
                                  width: 100.w,
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  onPressed: () {
                                    setState(() {
                                      // Toggle like state
                                      if (post.likes > 0) {
                                        post.likes++;
                                      } else {
                                        post.likes--;
                                      }
                                    });
                                    print("Likes: ${post.likes}");
                                  },
                                  icon: Icon(
                                    post.likes > 0
                                        ? Icons.thumb_up_alt
                                        : Icons.thumb_up_alt_outlined,
                                    color: TWITTER_WHITE,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                InterFont(
                                  text: '${post.likes}',
                                  fontSize: 15.sp,
                                  color: TWITTER_WHITE,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(
                'No posts available',
                style: TextStyle(color: TWITTER_WHITE),
              ),
            );
          }
        },
      ),
    );
  }
}
