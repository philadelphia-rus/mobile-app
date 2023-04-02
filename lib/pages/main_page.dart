import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mobile_app/utils/app_colors.dart';

import '../utils/app_routes.dart';

class MainPage extends StatefulWidget {
  final Widget child;
  final String location;

  const MainPage({required this.child, required this.location, super.key});

  static const double navBarHeight = 60.0;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int get _currentIndex => MenuRoute.values
      .firstWhere((e) => widget.location.contains(e.path))
      .index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: widget.child,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  void _onItemTapped(BuildContext context, MenuRoute menuRoute) {
    if (menuRoute.index != _currentIndex) {
      context.go(menuRoute.path);
    }
  }

  Widget _buildBottomNavigationBar() {
    return SafeArea(
      child: Container(
        height: MainPage.navBarHeight,
        child: GNav(
          backgroundColor: const Color(0xFFF8FBFF),
          color: const Color(0xFF8F939E),
          activeColor: const Color(0xFFFFFFFF),
          tabBackgroundColor: AppColors.color7e56e8,
          tabBorderRadius: 100,
          iconSize: 20,
          gap: 8,
          padding: EdgeInsets.all(16),
          duration: Duration(milliseconds: 450),
          tabs: const [
            GButton(
              icon: Icons.settings_accessibility_rounded,
              text: "Путь",
            ),
            GButton(
              icon: Icons.home,
              text: "Лидборд",
            ),
            GButton(
              icon: Icons.chat,
              text: "Квесты",
            ),
            GButton(
              icon: Icons.chat,
              text: "База знаний",
            ),
          ],
          selectedIndex: _currentIndex,
          onTabChange: (index) =>
              _onItemTapped(context, MenuRoute.values[index]),
        ),
      ),
    );
  }
}
