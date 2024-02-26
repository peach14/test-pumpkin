import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_pumpkin/feature/form_input/views/form_input_screen.dart';
import 'package:test_pumpkin/shared_component/text_form_field_custom.dart';

import '../../../constants/asset_path.dart';
import '../../../constants/constant.dart';
import '../../../shared_component/button_custom.dart';
import '../controller/provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _userNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
//    final stateSession = (ref.watch(asyncLoginProvider)); ดูข้อมูล user ทั้งหมด
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 150),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImagePath.logoImage),
                  scale: 3,
                  alignment: Alignment.topRight)),
          child: SingleChildScrollView(
            child: Column(children: [
              Form(
                key: formLogin,
                child: TextFormFieldCustom(
                  label: "username",
                  controller: _userNameController,
                  hintText: "username:",
                  hintStyle: const TextStyle(),
                  textStyle: const TextStyle(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'required username';
                    }

                    return null;
                    // return null;
                  },
                ),
              ),
              ButtonCustom(
                text: 'Go',
                height: 15.h,
                buttonType: ButtonType.circle,
                textColors: Colors.white,
                onTap: () {
                  if (formLogin.currentState!.validate()) {
                    ref
                        .read(asyncLoginProvider.notifier)
                        .saveSession(username: _userNameController.text);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FormInputScreen()));
                  }
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _userNameController.clear();
    super.dispose();
  }
}
