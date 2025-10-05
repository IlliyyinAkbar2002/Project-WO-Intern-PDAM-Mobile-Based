import 'package:flutter/material.dart';
import 'package:mobile_intern_pdam/core/widget/app_state_page.dart';
import 'package:mobile_intern_pdam/core/widget/custom_app_bar.dart';
import 'package:mobile_intern_pdam/feature/work_order/presentation/pages/assigner_page/assigner_work_order_list_page.dart';
import 'package:mobile_intern_pdam/feature/work_order/presentation/pages/assigner_page/approval_work_order_list_page.dart';
import 'package:mobile_intern_pdam/feature/work_order/presentation/widgets/work_order_filter.dart';

class AssignerWorkOrderPage extends StatefulWidget {
  final int picId;
  const AssignerWorkOrderPage({super.key, required this.picId});

  @override
  State<AssignerWorkOrderPage> createState() => _AssignerWorkOrderPageState();
}

class _AssignerWorkOrderPageState extends AppStatePage<AssignerWorkOrderPage> {
  int _selectedFilter = 0; // Index filter utama
  // int _subFilter = 0; // Index filter kedua (jika ada)

  final List<String> _filterLabels = ['Pembuatan', 'Persetujuan'];

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Work Order',
        actionIcon: Icons.notification_add,
        onActionPressed: () {},
      ),
      body: Column(
        children: [
          WorkOrderFilter(
            onFilterSelected: (mainIndex, subIndex) {
              setState(() {
                _selectedFilter = mainIndex;
              });
            },
            filterLabels: _filterLabels,
          ),
          Expanded(child: _getPage()),
        ],
      ),
    );
  }

  Widget _getPage() {
    if (_selectedFilter == 0) {
      return AssignerWorkOrderListPage(picId: widget.picId);
    } else {
      return ApprovalWorkOrderListPage(picId: widget.picId);
    }
  }
}
