import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/constants.dart';
import '../utils/widgets.dart';
import 'post_screen.dart';
import 'search_screen.dart'; // Import SearchScreen
import 'profile_screen.dart'; // Import ProfileScreen
import 'login_screen.dart'; // Import LogInScreen for redirection on logout

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TWITTER_BLACK,
        elevation: 2,
        leading: Icon(
          Icons.account_circle_rounded,
          color: TWITTER_GREY,
          size: ScreenUtil().setSp(30),
        ),
        centerTitle: true,
        title: InterFont(
          text: selectedIndex == 0
              ? 'Home'
              : selectedIndex == 1
                  ? 'Search'
                  : selectedIndex == 2
                      ? 'Profile'
                      : 'Home',
          fontSize: ScreenUtil().setSp(17.5),
          fontWeight: FontWeight.bold,
          color: TWITTER_WHITE,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: TWITTER_WHITE,
              size: ScreenUtil().setSp(24),
            ),
            onPressed: () {
              // Show a confirmation dialog before logging out
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Logout"),
                    content: const Text("Are you sure you want to logout?"),
                    actions: [
                      TextButton(
                        child: const Text("Cancel"),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                      TextButton(
                        child: const Text("Logout"),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                          Navigator.pushReplacementNamed(
                              context, '/login'); // Navigate to login screen
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      backgroundColor: TWITTER_BLACK,
      body: PageView(
        controller: _pageController,
        children: const <Widget>[
          PostScreen(),
          SearchScreen(), // Ensure this is the correct import and widget
          ProfileScreen(), // Ensure this is the correct import and widget
        ],
        onPageChanged: (page) {
          setState(() {
            selectedIndex = page;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false, // Hide selected item labels
        showUnselectedLabels: false, // Hide unselected item labels
        onTap: onTappedBar,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        elevation: 10.0,
        selectedItemColor: TWITTER_WHITE,
        unselectedItemColor: TWITTER_GREY,
        currentIndex: selectedIndex,
        backgroundColor: TWITTER_BLACK,
      ),
    );
  }

  void onTappedBar(int value) {
    setState(() {
      selectedIndex = value;
      _pageController.jumpToPage(value);
    });
  }
}
