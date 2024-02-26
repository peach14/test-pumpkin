import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_pumpkin/feature/login/controller/provider.dart';
import 'package:test_pumpkin/feature/login/views/login_screen.dart';

import '../../../constants/constant.dart';
import '../../../shared_component/tabbar_custom.dart';
import '../component/check_product.dart';
import '../component/report_product.dart';
import '../component/save_product.dart';

class FormInputScreen extends ConsumerStatefulWidget {
  const FormInputScreen({super.key});

  @override
  ConsumerState<FormInputScreen> createState() => _FormInputScreenState();
}

class _FormInputScreenState extends ConsumerState<FormInputScreen> {
  @override
  Widget build(BuildContext context) {
    final userName = ref.watch(asyncLoginProvider);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              'username : ',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              "${userName.maybeWhen(
                orElse: () => 'NoData',
                data: (data) => data['username'],
              )}",
              style: const TextStyle(
                  color: Colors.deepOrange, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ));
              },
              icon: const Icon(Icons.login_outlined))
        ],
      ),
      body: const SafeArea(
        child: Column(
          children: [
            CustomTabBar(
              saveProduct: SaveProduct(),
              checkProduct: CheckProduct(),
              rePort: ReportProduct(),
            )
          ],
        ),
      ),
    );
  }
}
