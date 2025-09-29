import 'package:flutter/material.dart';
import 'package:zetstron/screens/desktop_screen.dart';
import 'package:zetstron/screens/mobile_screen.dart';
import 'package:zetstron/screens/responsive_layout.dart';
import 'package:zetstron/screens/tablet_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ResponsiveLayout(
        desktop: DesktopScreen(),
        mobile: MobileScreen(),
        tablet: TabletScreen(),
      ),
    );
  }
}
