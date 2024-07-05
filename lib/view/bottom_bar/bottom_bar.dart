import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:enefty_icons/enefty_icons.dart';
import 'package:rexparts/controller/bottom_provider.dart';
import 'package:rexparts/controller/noti_provider.dart';
import 'package:rexparts/view/cart/cart.dart';
import 'package:rexparts/view/home/home.dart';
import 'package:rexparts/view/notification/notification.dart';
import 'package:rexparts/view/settings/settings.dart';
import 'package:rexparts/widget/icon.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  final List<Widget> tabsList = [
    const HomeScreen(),
    const CartPage(),
    const NotificationScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final notiProvider =
        Provider.of<NotificationProvider>(context, listen: false);
    return Consumer<BottomNavProvider>(
      builder: (context, btmvalue, child) {
        return Scaffold(
          body: tabsList[btmvalue.currentIndex],
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              selectedItemColor: Colors.black,
              unselectedLabelStyle: GoogleFonts.montserrat(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              unselectedItemColor: Colors.black,
              selectedLabelStyle: GoogleFonts.montserrat(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              currentIndex: btmvalue.currentIndex,
              onTap: (int value) {
                btmvalue.currentIndexChanging(value);
              },
              items: [
                BottomNavigationBarItem(
                  icon: IconWidget(
                    context,
                    iconData: EneftyIcons.home_outline,
                    color: Colors.black,
                  ),
                  activeIcon: const Icon(EneftyIcons.home_bold),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: IconWidget(
                    context,
                    iconData: EneftyIcons.shopping_cart_outline,
                    color: Colors.black,
                  ),
                  activeIcon: const Icon(EneftyIcons.shopping_cart_bold),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    notiProvider.hasUnreadNotifications()
                        ? EneftyIcons.notification_2_bold
                        : EneftyIcons.note_3_outline,
                    color: notiProvider.hasUnreadNotifications()
                        ? Colors.blue
                        : Colors.black,
                  ),
                  // activeIcon: const Icon(EneftyIcons.notification_2_bold),
                  label: 'Notification',
                ),
                BottomNavigationBarItem(
                  icon: IconWidget(
                    context,
                    iconData: EneftyIcons.setting_outline,
                    color: Colors.black,
                  ),
                  activeIcon: const Icon(EneftyIcons.setting_bold),
                  label: 'Settings',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
