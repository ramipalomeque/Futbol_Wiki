import 'package:flutter/material.dart';

class HomeLateralMenu {
  String title;
  String route;
  Icon icon;
  HomeLateralMenu({required this.title, required this.route, required this.icon});
}

List<HomeLateralMenu> homeLateralMenuItems = [

  HomeLateralMenu(title: 'Home', route: '/home', icon: const Icon(Icons.home),),
  HomeLateralMenu(title: 'Profile', route: '/profile', icon: const Icon(Icons.person)),
  HomeLateralMenu(title: 'Settings', route: '/settings', icon: const Icon(Icons.settings)),
  HomeLateralMenu(title: 'Logout', route: '/login', icon: Icon(Icons.logout)),
];