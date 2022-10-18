import 'dart:io';

import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';
import 'package:eazy_shop/order/index.dart';
import 'package:eazy_shop/profile/profile_info.dart';
import 'package:eazy_shop/screens/offers/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../Folders.dart';
import 'home_view.dart';

List<Widget> _widgetOptions = [
  HomeView(),
  Order(),
  OffersPage(),
  ProfileInfo()
];

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  PageController _pageController;
  MenuPositionController _menuPositionController;
  bool userPageDragging = false;

  @override
  void initState() {
    _menuPositionController = MenuPositionController(initPosition: 0);

    _pageController =
        PageController(initialPage: 0, keepPage: false, viewportFraction: 1.0);
    _pageController.addListener(handlePageChange);

    super.initState();
  }

  void handlePageChange() {
    _menuPositionController.absolutePosition = _pageController.page;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void checkUserDragging(ScrollNotification scrollNotification) {
    if (scrollNotification is UserScrollNotification &&
        scrollNotification.direction != ScrollDirection.idle) {
      userPageDragging = true;
    } else if (scrollNotification is ScrollEndNotification) {
      userPageDragging = false;
    }
    if (userPageDragging) {
      _menuPositionController.findNearestTarget(_pageController.page);
    }
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => exit(0),
                /*Navigator.of(context).pop(true)*/
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          bottomNavigationBar: BubbledNavigationBar(
            controller: _menuPositionController,
            initialIndex: _selectedIndex,
            itemMargin: EdgeInsets.symmetric(horizontal: 8),
            backgroundColor: Colors.white,
            defaultBubbleColor: Colors.blue,
            onTap: (index) {
              _pageController.animateToPage(index,
                  curve: Curves.easeInOutQuad,
                  duration: Duration(milliseconds: 500));
              _onItemTapped(index);
            },
            items: <BubbledNavigationBarItem>[
              BubbledNavigationBarItem(
                icon: Icon(CupertinoIcons.home, size: 30, color: Colors.grey),
                activeIcon:
                    Icon(CupertinoIcons.home, size: 30, color: Colors.white),
                title: Text(
                  'Home',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              BubbledNavigationBarItem(
                icon: Icon(CupertinoIcons.shopping_cart,
                    size: 30, color: Colors.grey),
                activeIcon: Icon(CupertinoIcons.shopping_cart,
                    size: 30, color: Colors.white),
                title: Text(
                  'Orders',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              BubbledNavigationBarItem(
                icon: Icon(Icons.local_offer, size: 30, color: Colors.grey),
                activeIcon:
                    Icon(Icons.local_offer, size: 30, color: Colors.white),
                title: Text(
                  'Offers',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              BubbledNavigationBarItem(
                icon: Icon(CupertinoIcons.profile_circled,
                    size: 30, color: Colors.grey),
                activeIcon: Icon(CupertinoIcons.profile_circled,
                    size: 30, color: Colors.white),
                title: Text(
                  'Profile',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
          body: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              checkUserDragging(scrollNotification);
            },
            child: PageView(
              controller: _pageController,
              children: _widgetOptions,
              onPageChanged: (page) {
                _widgetOptions.elementAt(page);
              },
            ),
          )),
    );
  }

  Widget getBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.offline_bolt),
          title: Text(''),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_shopping_cart),
          title: Text(''),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          title: Text(''),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.supervisor_account_outlined),
          title: Text(''),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.blue,
      onTap: _onItemTapped,
    );
  }
}
