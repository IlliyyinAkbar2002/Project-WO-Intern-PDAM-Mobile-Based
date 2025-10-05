import 'package:flutter/material.dart';
import 'package:mobile_intern_pdam/core/widget/app_state_page.dart';
import 'package:mobile_intern_pdam/core/widget/custom_form.dart';
import 'package:mobile_intern_pdam/core/widget/filter_list/filter_list.dart';
import 'package:mobile_intern_pdam/feature/work_order/presentation/pages/work_order_list.dart';

class ApprovalWorkOrderListPage extends StatefulWidget {
  final int? picId;
  final int? userId;

  const ApprovalWorkOrderListPage({super.key, this.picId, this.userId});

  @override
  State<ApprovalWorkOrderListPage> createState() =>
      _ApprovalWorkOrderListPageState();
}

class _ApprovalWorkOrderListPageState
    extends AppStatePage<ApprovalWorkOrderListPage> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 8),
          _searchWorkOrder(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Work Order List", style: textTheme.displaySmall),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled:
                          true, // Agar bisa full height jika perlu
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      builder: (context) => const CustomFilterDialog(),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: WorkOrderList(
              status: const [1],
              picId: widget.picId,
              userId: widget.userId,
              creatorId: widget.picId! + 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchWorkOrder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomForm(
        labelText: 'Cari Work Order',
        hintText: 'Masukkan kata kunci',
        inputType: InputType.text,
        // controller: _workOrderBloc.searchController,
        // onChanged: (value) {
        //   _workOrderBloc.add(SearchWorkOrdersEvent(value));
        // },
        // onSubmitted: (value) {
        //   _workOrderBloc.add(SearchWorkOrdersEvent(value));
        // },
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            // _workOrderBloc.searchController.clear();
            // _workOrderBloc.add(GetWorkOrdersEvent());
          },
        ),
      ),
    );
  }
}
