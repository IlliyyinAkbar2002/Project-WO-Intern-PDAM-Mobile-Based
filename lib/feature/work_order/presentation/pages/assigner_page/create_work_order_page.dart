import 'package:flutter/material.dart';
import 'package:mobile_intern_pdam/core/widget/app_state_page.dart';
import 'package:mobile_intern_pdam/core/widget/custom_app_bar.dart';
import 'package:mobile_intern_pdam/feature/work_order/presentation/pages/detail_work_order_page.dart';
import 'package:mobile_intern_pdam/feature/work_order/presentation/widgets/work_order_type_filter.dart';

class CreateWorkOrderPage extends StatefulWidget {
  final int? picId;
  final int? userId;
  final int? workOrderId;
  final int? status;
  final bool isOvertime;

  const CreateWorkOrderPage({
    super.key,
    this.picId,
    this.userId,
    this.workOrderId,
    this.status,
    this.isOvertime = false,
  });

  @override
  State<CreateWorkOrderPage> createState() => _CreateWorkOrderPageState();
}

class _CreateWorkOrderPageState extends AppStatePage<CreateWorkOrderPage> {
  int _subFilterIndex = 0;
  final List<String> _filterLabels = ['WO Normal', 'WO Lembur'];

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: (widget.workOrderId == null)
          ? const CustomAppBar(title: 'Buat Work Order')
          : null,
      body: Column(
        children: [
          (widget.workOrderId == null)
              ? WorkOrderTypeFilter(
                  selectedIndex: _subFilterIndex,
                  onFilterSelected: (index) {
                    setState(() {
                      _subFilterIndex = index;
                    });
                  },
                  filterLabels: _filterLabels,
                )
              : const SizedBox(),
          Expanded(
            child: DetailWorkOrderPage(
              picId: widget.picId,
              userId: widget.userId,
              key: ValueKey(_subFilterIndex),
              workOrderId: widget.workOrderId,
              status: widget.status,
              isOvertime: (widget.workOrderId != null)
                  ? widget.isOvertime
                  : _subFilterIndex == 1
                  ? true
                  : false,
            ),
          ),
        ],
      ),
    );
  }
}
