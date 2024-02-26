import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_pumpkin/constants/constant.dart';

import '../../../shared_component/button_custom.dart';
import '../../../shared_component/text_form_field_custom.dart';
import '../../login/controller/provider.dart';

class SaveProduct extends ConsumerStatefulWidget {
  const SaveProduct({
    super.key,
  });

  @override
  ConsumerState<SaveProduct> createState() => _SaveProductState();
}

class _SaveProductState extends ConsumerState<SaveProduct> {
  final _areaController = TextEditingController();
  final _productController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final stateSession = (ref.watch(asyncLoginProvider));
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
      child: SingleChildScrollView(
        child: Column(children: [
          Form(
            key: formSaveProduct,
            child: Column(
              children: [
                TextFormFieldCustom(
                  label: "AREA PRODUCT",
                  controller: _areaController,
                  hintText: "A001",
                  hintStyle: const TextStyle(),
                  textStyle: const TextStyle(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'required AREA';
                    }

                    return null;
                    // return null;
                  },
                ),
                TextFormFieldCustom(
                  label: "CODE PRODUCT",
                  controller: _productController,
                  hintText: "P001",
                  hintStyle: const TextStyle(),
                  textStyle: const TextStyle(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'required CODE';
                    }

                    return null;
                    // return null;
                  },
                ),
              ],
            ),
          ),
          ButtonCustom(
            text: 'บันทึก',
            width: 200,
            color: Colors.green,
            borderColors: Colors.white,
            //   buttonType: ButtonType.circle,
            textColors: Colors.white,
            onTap: () {
              if (formSaveProduct.currentState!.validate()) {
                ref.read(asyncLoginProvider.notifier).saveProduct(
                      context: context,
                      area: _areaController.text,
                      product: _productController.text,
                    );
              }
            },
          ),
        ]),
      ),
    );
  }
}
