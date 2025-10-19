import 'package:flutter/material.dart';
import 'package:mobile_intern_pdam/config/theme/app_color.dart';
import 'package:mobile_intern_pdam/core/widget/app_state_page.dart';

class SpvLandingPage extends StatefulWidget {
  const SpvLandingPage({super.key});

  @override
  State<SpvLandingPage> createState() => _SpvLandingPageState();
}

class _SpvLandingPageState extends AppStatePage<SpvLandingPage> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: _colors.background[100],
      body: const Center(child: Text('SPV Landing Page - Coming Soon')),
    );
  }

  AppColor get _colors => Theme.of(context).extension<AppColor>()!;
}
