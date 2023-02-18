import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/cart/bag_screen.dart';
import 'package:flutter_application_1/features/dasboard/views/favorite_screen.dart';
import 'package:flutter_application_1/features/dasboard/views/home_screen.dart';
import 'package:flutter_application_1/features/shop/shop_screen.dart';

import 'package:flutter_application_1/utils/custom_color.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = '/dashboard';
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<DashboardScreen> {
  List<BottomNavigationBarItem> bottomNavigationList = [
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.home_outlined,
          color: CustomColor.textGreyColor,
        ),
        activeIcon: Icon(
          Icons.home,
          color: CustomColor.appButtonColor,
        ),
        label: "Home"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart_outlined,
            color: CustomColor.textGreyColor),
        activeIcon: Icon(
          Icons.shopping_cart,
          color: CustomColor.appButtonColor,
        ),
        label: "Shop"),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.shopping_bag_outlined,
          color: CustomColor.textGreyColor,
        ),
        activeIcon: Icon(
          Icons.shopping_bag,
          color: CustomColor.appButtonColor,
        ),
        label: "Bag"),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.favorite_border_outlined,
          color: CustomColor.textGreyColor,
        ),
        activeIcon: Icon(
          Icons.favorite,
          color: CustomColor.appButtonColor,
        ),
        label: "Favorite")
  ];
  int bottoBarIndex = 0;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void pageChanged(int index) {
    setState(() {
      bottoBarIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottoBarIndex = index;
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: const [
        HomeScreen(),
        ShopScreen(),
        CartScreen(),
        FavoriteScreen()
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            bottomTapped(value);
          },
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          unselectedLabelStyle:
              const TextStyle(color: CustomColor.textGreyColor),
          selectedItemColor: CustomColor.appButtonColor,
          showUnselectedLabels: true,
          unselectedItemColor: CustomColor.textGreyColor,
          selectedLabelStyle:
              const TextStyle(color: CustomColor.appButtonColor),
          items: bottomNavigationList,
          currentIndex: bottoBarIndex),
    );
  }
}
