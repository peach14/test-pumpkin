import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared_component/text_form_field_custom.dart';
import '../../login/controller/provider.dart';
import '../controller/provider.dart';

class CheckProduct extends ConsumerStatefulWidget {
  const CheckProduct({
    super.key,
  });

  @override
  ConsumerState<CheckProduct> createState() => _CheckProductState();
}

class _CheckProductState extends ConsumerState<CheckProduct> {
  String _quantityController = "0";

  @override
  Widget build(BuildContext context) {
    final saveComplete = (ref.watch(addQuantityProvider));
    final successLogin = ref.watch(asyncLoginProvider);

    return Container(
      padding: REdgeInsets.symmetric(vertical: 10),
      child: ListView.separated(
          itemBuilder: (context, index) => saveComplete[index]
              ? Dismissible(
                  onDismissed: (direction) {
                    ref
                        .read(addQuantityProvider.notifier)
                        .updateItemAtIndex(index, false);
                  },
                  key: Key(index.toString()),
                  child: Container(
                    padding: REdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Column(
                      children: [
                        TextFormFieldCustom(
                          label: "area: ${successLogin.maybeWhen(
                            orElse: () => '',
                            data: (data) => data['saveData'][index]['area'],
                          )} product: ${successLogin.maybeWhen(
                            orElse: () => '',
                            data: (data) => data['saveData'][index]['product'],
                          )}",
                          onChanged: (value) {
                            _quantityController = value ?? '0';
                            print(value);
                          },
                          hintText: "จำนวน",
                          textInputType: TextInputType.phone,
                          isPassword: true,
                          onPressed: () {
                            ref.read(asyncChStockProvider.notifier).addStock(
                                context: context,
                                area: successLogin.maybeWhen(
                                  orElse: () => '',
                                  data: (data) =>
                                      data['saveData'][index]['area'],
                                ),
                                product: successLogin.maybeWhen(
                                  orElse: () => '',
                                  data: (data) =>
                                      data['saveData'][index]['product'],
                                ),
                                quantity: _quantityController);

                            print(successLogin.maybeWhen(
                              orElse: () => '',
                              data: (data) => data['saveData'][index]['area'],
                            ));
                            ref
                                .read(addQuantityProvider.notifier)
                                .updateItemAtIndex(index, false);
                          },
                          iconSubmit:
                              const Icon(Icons.add, color: Colors.black),
                          hintStyle: const TextStyle(),
                          textStyle: const TextStyle(),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'required quantity';
                            }

                            return null;
                            // return null;
                          },
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          separatorBuilder: (context, index) => const SizedBox.shrink(),
          itemCount: saveComplete.length),
    );
  }
}
