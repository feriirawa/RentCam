import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sewa_kamera1/screens/account_screen/account_screen.dart';
import 'package:sewa_kamera1/screens/cart_screen/cart_screen.dart';
import 'package:sewa_kamera1/screens/home/home.dart';
import 'package:sewa_kamera1/screens/order_screen/order_screen.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({Key? key}) : super(key: key);

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  PersistentTabController _controller = PersistentTabController();
  bool _hideNavBar = false; // Set to false to always show the navigation bar

  List<Widget> _buildScreens() {
    return [
      Home(),
      CartScreen(),
      OrderScreen(),
      AccountScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        inactiveIcon: Icon(Icons.home_outlined),
        title: "Beranda",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.shopping_cart),
        inactiveIcon: Icon(Icons.shopping_cart_outlined),
        title: "Keranjang",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.circle_rounded),
        inactiveIcon: Icon(Icons.circle_outlined),
        title: "Pesanan",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        inactiveIcon: Icon(Icons.person_outline),
        title: "Akun",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        resizeToAvoidBottomInset: true,
        navBarHeight: kBottomNavigationBarHeight,
        bottomScreenMargin: 0.0,
        onWillPop: (context) async {
          await showDialog(
            context: context!,
            useSafeArea: true,
            builder: (context) => Container(
              height: 50,
              width: 50,
              color: Colors.white,
              child: ElevatedButton(
                child: Text("Keluar"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          );
          return false;
        },
        backgroundColor: const Color.fromARGB(255, 0, 128, 4),
        hideNavigationBar: _hideNavBar,
        decoration: NavBarDecoration(colorBehindNavBar: const Color.fromARGB(255, 0, 121, 4)),
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
        ),
        navBarStyle: NavBarStyle.style1, // Pilih gaya nav bar dengan properti ini
      ),
    );
  }
}
