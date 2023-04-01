import 'package:concentric_transition/page_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mobile_app/pages/auth/sign_in_page.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';

final pages = [
  const PageData(
    icon: Icons.bubble_chart,
    title: "Local news\nstories",
    bgColor: Color(0xFF0043D0),
    textColor: Colors.white,
  ),
  const PageData(
    icon: Icons.format_size,
    title: "Choose your\ninterests",
    textColor: Colors.white,
    bgColor: Color(0xFFFDBFDD),
  ),
  const PageData(
    icon: Icons.hdr_weak,
    title: "Drag and\ndrop to move",
    bgColor: Color(0xFFFFFFFF),
  ),
];

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key, required this.images}) : super(key: key);
  final List<Image> images;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  ImageProvider image1 = AssetImage("assets/sliding_panel/1.png");
  ImageProvider image2 = AssetImage("assets/sliding_panel/2.png");
  ImageProvider image3 = AssetImage("assets/sliding_panel/3.png");

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    // await precacheImage(image1, context);
    // await precacheImage(image2, context);
    // await precacheImage(image3, context);
    // imgList = [
    //   Image(
    //     image: image1,
    //   ),
    //   Image(
    //     image: image2,
    //   ),
    //   Image(
    //     image: image3,
    //   ),
    // ];
  }

  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ConcentricPageView(
        colors: pages.map((p) => p.bgColor).toList(),
        radius: screenWidth * 0.1,
        // curve: Curves.ease,
        itemCount: 3,
        onFinish: () {
          context.go(Routes.signInPage);
        },
        pageController: pageController,
        nextButtonBuilder: (context) => Padding(
          padding: const EdgeInsets.only(left: 3), // visual center
          child: Icon(
            Icons.navigate_next,
            size: screenWidth * 0.08,
          ),
        ),
        itemBuilder: (index) {
          final page = pages[index % pages.length];
          return SafeArea(
            child: _Page(
              page: page,
            ),
          );
        },
      ),
    );
  }
}

class PageData {
  final String? title;
  final IconData? icon;
  final Color bgColor;
  final Color textColor;

  const PageData({
    this.title,
    this.icon,
    this.bgColor = Colors.white,
    this.textColor = Colors.black,
  });
}

class _Page extends StatelessWidget {
  final PageData page;

  _Page({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    space(double p) => SizedBox(height: screenHeight * p / 100);
    return Column(
      children: [
        space(10),
        Icon(Icons.done),
        space(8),
        _Text(
          page: page,
          style: TextStyle(
            fontSize: screenHeight * 0.046,
          ),
        ),
      ],
    );
  }
}

class _Text extends StatelessWidget {
  const _Text({
    Key? key,
    required this.page,
    this.style,
  }) : super(key: key);

  final PageData page;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      page.title ?? '',
      style: TextStyle(
        color: page.textColor,
        fontWeight: FontWeight.w600,
        fontFamily: 'VarelaRound',
        letterSpacing: 0.0,
        fontSize: 18,
        height: 1.2,
      ).merge(style),
      textAlign: TextAlign.center,
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    Key? key,
    required this.page,
    required this.size,
    required this.iconSize,
  }) : super(key: key);

  final PageData page;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final bgColor = page.bgColor
        // .withBlue(page.bgColor.blue - 40)
        .withGreen(page.bgColor.green + 20)
        .withRed(page.bgColor.red - 100)
        .withAlpha(90);

    final icon1Color = AppColors.color7e56e8;
    final icon2Color = AppColors.color8a184d;
    final icon3Color = AppColors.color8a184d;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(60.0)),
        color: bgColor,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: RotatedBox(
              quarterTurns: 2,
              child: Icon(
                page.icon,
                size: iconSize + 20,
                color: icon1Color,
              ),
            ),
            right: -5,
            bottom: -5,
          ),
          Positioned.fill(
            child: RotatedBox(
              quarterTurns: 5,
              child: Icon(
                page.icon,
                size: iconSize + 20,
                color: icon2Color,
              ),
            ),
          ),
          Icon(
            page.icon,
            size: iconSize,
            color: icon3Color,
          ),
        ],
      ),
    );
  }
}
