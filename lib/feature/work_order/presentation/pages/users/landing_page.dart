import 'package:flutter/material.dart';
import 'package:mobile_intern_pdam/config/theme/app_color.dart';
import 'package:mobile_intern_pdam/core/widget/app_state_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends AppStatePage<LandingPage> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: _colors.background[100],
      body: const Center(child: Text('User Landing Page - Coming Soon')),
    );
  }

  AppColor get _colors => Theme.of(context).extension<AppColor>()!;
}
