import 'package:flutter/material.dart';
import 'package:mobile_intern_pdam/config/theme/app_color.dart';
import 'package:mobile_intern_pdam/core/widget/app_state_page.dart';
import 'package:mobile_intern_pdam/feature/work_order/presentation/pages/assignee_page/assignee_work_order_page.dart';
import 'package:mobile_intern_pdam/feature/work_order/presentation/pages/assigner_page/assigner_work_order_page.dart';

part 'widgets/_landing_page_header.dart';
part 'widgets/_landing_page_body.dart';
part 'widgets/_role_selector.dart';
part 'widgets/_navigation_card.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends AppStatePage<LandingPage> {
  int? _selectedPicId;
  int? _selectedUserId;

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: _colors.background[100],
      body: SafeArea(
        child: Column(
          children: [
            _LandingPageHeader(),
            Expanded(
              child: _LandingPageBody(
                selectedPicId: _selectedPicId,
                selectedUserId: _selectedUserId,
                onPicIdChanged: (value) =>
                    setState(() => _selectedPicId = value),
                onUserIdChanged: (value) =>
                    setState(() => _selectedUserId = value),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppColor get _colors => Theme.of(context).extension<AppColor>()!;
}
