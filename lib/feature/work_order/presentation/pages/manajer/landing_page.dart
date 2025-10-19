import 'package:flutter/material.dart';
import 'package:mobile_intern_pdam/config/theme/app_color.dart';
import 'package:mobile_intern_pdam/core/widget/app_state_page.dart';

class ManajerLandingPage extends StatefulWidget {
  const ManajerLandingPage({super.key});

  @override
  State<ManajerLandingPage> createState() => _ManajerLandingPageState();
}

class _ManajerLandingPageState extends AppStatePage<ManajerLandingPage> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: _colors.background[100],
      body: const Center(child: Text('Manajer Landing Page - Coming Soon')),
    );
  }

  AppColor get _colors => Theme.of(context).extension<AppColor>()!;
}
