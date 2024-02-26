import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_pumpkin/shared_component/controller/text_form_field_controller.dart';

class TextFormFieldCustom extends ConsumerStatefulWidget {
  const TextFormFieldCustom({
    super.key,
    this.controller,
    required this.hintText,
    required this.hintStyle,
    required this.textStyle,
    this.prefixIcon,
    this.label,
    this.isPassword,
    this.field,
    this.backgroundColor,
    this.height = 40,
    this.width = double.infinity,
    this.validator,
    this.onChanged,
    this.focusNode,
    this.suffixIcon,
    this.enablePassword,
    this.autoValidateMode,
    this.textInputType,
    this.onPressed,
    this.iconSubmit,
  });

  final TextEditingController? controller;
  final String hintText;
  final String? label;
  final String? field;
  final TextStyle hintStyle;
  final TextStyle textStyle;
  final String? prefixIcon;
  final bool? isPassword;
  final bool? enablePassword;
  final Widget? suffixIcon;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final FormFieldValidator<String>? validator;
  final FormFieldValidator<String>? onChanged;
  final FocusNode? focusNode;
  final AutovalidateMode? autoValidateMode;
  final TextInputType? textInputType;
  final void Function()? onPressed;
  final Icon? iconSubmit;

  @override
  ConsumerState<TextFormFieldCustom> createState() =>
      _TextFormFieldCustomState();
}

class _TextFormFieldCustomState extends ConsumerState<TextFormFieldCustom> {
  @override
  Widget build(BuildContext context) {
    return FormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator ??
          (value) {
            if (value is String) {
              return (value.isNotEmpty) ? null : "Cannot be null";
            }
            return null;
          },
      initialValue: widget.controller?.text,
      builder: (FormFieldState<dynamic> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.label != null
                ? Text(widget.label ?? '',
                    style: TextStyle(height: 2.20.h, fontSize: 14.sp))
                : const SizedBox.shrink(),
            SizedBox(
              height: widget.height,
              width: widget.width,
              child: TextFormField(
                focusNode: widget.focusNode,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: widget.onChanged ??
                    (value) {
                      print("1111111111111111111$value");
                      field.didChange(value);
                    },
                keyboardType: widget.textInputType,
                controller: widget.controller,
                style: widget.textStyle,
                decoration: InputDecoration(
                    // enabled: true,
                    filled: true,
                    fillColor: widget.backgroundColor ?? Colors.white38,
                    disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(color: Colors.white38)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                            color: field.hasError ? Colors.red : Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                            color: field.hasError ? Colors.red : Colors.green)),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(color: Colors.blue)),
                    hintStyle: widget.hintStyle,
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(
                        24,
                        0,
                        0,
                        widget.isPassword == true
                            ? MediaQuery.of(context).size.height * 0.025
                            : MediaQuery.of(context).size.height * 0),
                    hintText: widget.hintText,
                    prefixIcon: widget.prefixIcon != null
                        ? Container(
                            margin: const EdgeInsets.only(left: 20, right: 16),
                            width: 24,
                            //  height: 10,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: AssetImage(widget.prefixIcon ?? ""),
                                fit: BoxFit.scaleDown,
                              ),
                              shape: const RoundedRectangleBorder(),
                            ),
                          )
                        : null,
                    // suffixIconConstraints: BoxConstraints(
                    //   minWidth: 24.spMin,
                    //   maxWidth: 60.spMax,
                    // ),
                    // prefixIconConstraints: BoxConstraints(
                    //   minWidth: 24.spMin,
                    //   maxWidth: 60.spMax,
                    // ),
                    suffixIcon: widget.isPassword == true
                        ? IconButton(
                            onPressed: widget.onPressed ??
                                () {
                                  if (ref.watch(showPassword)) {
                                    ref
                                        .read(showPassword.notifier)
                                        .update((state) => false);
                                  } else {
                                    ref
                                        .read(showPassword.notifier)
                                        .update((state) => true);
                                  }
                                },
                            icon: widget.iconSubmit ??
                                Icon(
                                    size: 24,
                                    color: Colors.deepOrange,
                                    ref.watch(showPassword)
                                        ? Icons.visibility
                                        : Icons.visibility_off))
                        : const SizedBox()),
                obscureText: widget.isPassword == true
                    ? widget.iconSubmit != null
                        ? false
                        : ref.watch(showPassword)
                            ? false
                            : true
                    : false,
              ),
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  field.errorText ?? '',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            SizedBox(
              height: 15.h,
            )
          ],
        );
      },
    );
  }
}
