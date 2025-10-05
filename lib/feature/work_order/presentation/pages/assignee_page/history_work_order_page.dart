import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_intern_pdam/core/widget/app_state_page.dart';
import 'package:mobile_intern_pdam/core/widget/custom_form.dart';
import 'package:mobile_intern_pdam/core/widget/filter_list/filter_list.dart';
import 'package:mobile_intern_pdam/feature/work_order/presentation/bloc/work_order_bloc.dart';
import 'package:mobile_intern_pdam/feature/work_order/presentation/bloc/work_order_event.dart';
import 'package:mobile_intern_pdam/feature/work_order/presentation/pages/work_order_list.dart';

class HistoryWorkOrderPage extends StatefulWidget {
  final int userId;
  const HistoryWorkOrderPage({super.key, required this.userId});

  @override
  State<HistoryWorkOrderPage> createState() => _HistoryWorkOrderPageState();
}

class _HistoryWorkOrderPageState extends AppStatePage<HistoryWorkOrderPage> {
  final _searchController = TextEditingController();
  late WorkOrderBloc _workOrderBloc;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _workOrderBloc = context.read<WorkOrderBloc>();
    _fetchWorkOrders();
  }

  void _fetchWorkOrders() {
    _workOrderBloc.add(
      GetWorkOrdersEvent(userId: widget.userId, status: const [6]),
    );
  }

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
            child: WorkOrderList(status: const [6], userId: widget.userId),
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
        controller: _searchController,
        onChanged: (value) {
          if (_debounce?.isActive ?? false) _debounce!.cancel();
          _debounce = Timer(const Duration(milliseconds: 500), () {
            _workOrderBloc.add(
              SearchWorkOrdersEvent(
                value,
                userId: widget.userId,
                excludeStatus: const [6],
              ),
            );
          });
        },
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            _searchController.clear();
            _fetchWorkOrders();
          },
        ),
      ),
    );
  }
}
