import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controller/provider.dart';

class ReportProduct extends ConsumerStatefulWidget {
  const ReportProduct({
    super.key,
  });

  @override
  ConsumerState<ReportProduct> createState() => _ReportProductState();
}

class _ReportProductState extends ConsumerState<ReportProduct> {
  @override
  Widget build(BuildContext context) {
    final dataSaveProduct = ref.watch(asyncChStockProvider);
    return ListView.separated(
        itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 1, color: Colors.grey.shade300))),
            child: Container(
              padding: REdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: dataSaveProduct.when(
                data: (data) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "พื้นที่ ${data[index]['area']} รหัสสินค้า ${data[index]['product']} จำนวน ${data[index]['quantity']}",
                        style: const TextStyle(fontSize: 14),
                      ),
                      const Text(
                        "ตรวจนำสำเร็จ",
                        style: TextStyle(fontSize: 14, color: Colors.green),
                      ),
                    ],
                  );
                },
                error: (Object error, StackTrace stackTrace) {
                  return Text(error.toString());
                },
                loading: () {
                  return const Text("Loading...");
                },
              ),
            )),
        separatorBuilder: (context, index) => const SizedBox.shrink(),
        itemCount: dataSaveProduct.maybeWhen(
          orElse: () => 0,
          data: (data) => data.length,
        ));
  }
}
